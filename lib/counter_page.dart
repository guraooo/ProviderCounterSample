import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_sample/counter_view_model.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Provider Sample"),
      ),
      body: ChangeNotifierProvider(
        create: (_) => CounterViewModel(),
        child: const CounterSamples(),
      ),
    );
  }
}

class CounterSamples extends StatelessWidget {
  const CounterSamples({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("Build Counter Samples");

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: const <Widget>[
          _Sample1(),
          _MySizedBox(),
          _Sample2(),
          _MySizedBox(),
          _Sample3(),
          _MySizedBox(),
          _Sample4(),
          _MySizedBox(),
          _Sample5(),
          _MySizedBox(),
          _Sample6(),
        ],
      ),
    );
  }
}

class _MySizedBox extends StatelessWidget {
  const _MySizedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 20);
  }
}

///  Sample1.
class _Sample1 extends StatelessWidget {
  const _Sample1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 更新されるTextのContextがここのBuildContextと共通のため、
    // Sample1全体がリビルドされてしまう（非効率な例）。
    debugPrint("Build Whole Sample1");

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(width: 100, child: Text("Method Widget")),
        countTextOfSample1(context),
        ElevatedButton(
          onPressed: () {
            context.read<CounterViewModel>().incrementCounter1();
          },
          child: const Icon(Icons.add),
        ),
      ],
    );
  }

  Text countTextOfSample1(BuildContext context) {
    debugPrint("Build Method Widget Text");

    return Text(context.select((CounterViewModel vm) => vm.counter1).toString(),
        style: const TextStyle(fontSize: 30));
  }
}

///  Sample2.
class _Sample2 extends StatelessWidget {
  const _Sample2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 全体のビルドは最初の一度のみ
    // （更新されるTextをclassとして切り出しており、更新されるContextと異なるため）
    debugPrint("Build Whole Sample2");

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(width: 100, child: Text("context.watch")),
        const _CountTextOfSample2(),
        ElevatedButton(
          onPressed: () {
            context.read<CounterViewModel>().incrementCounter2();
          },
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}

class _CountTextOfSample2 extends StatelessWidget {
  const _CountTextOfSample2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // context.watchのため、CounterViewModelでnotifyListenersが呼ばれる度にリビルドされる
    // （非効率な例）
    debugPrint("Build context.watch Text");

    return Text(context.watch<CounterViewModel>().counter2.toString(),
        style: const TextStyle(fontSize: 30));
  }
}

///  Sample3.
class _Sample3 extends StatelessWidget {
  const _Sample3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 全体のビルドは最初の一度のみ
    // （更新されるTextをclassとして切り出しており、更新されるContextと異なるため）
    debugPrint("Build Whole Sample3");

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(width: 100, child: Text("context.select")),
        const _CountTextOfSample3(),
        ElevatedButton(
          onPressed: () => context.read<CounterViewModel>().incrementCounter3(),
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}

class _CountTextOfSample3 extends StatelessWidget {
  const _CountTextOfSample3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // context.selectのため、他のnotifyListenersが呼ばれてもリビルドされない
    // （効率的な例）
    debugPrint("Build context.select Text");

    return Text(context.select((CounterViewModel vm) => vm.counter3).toString(),
        style: const TextStyle(fontSize: 30));
  }
}

///  Sample4.
class _Sample4 extends StatelessWidget {
  const _Sample4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 全体のビルドは最初の一度のみ
    // （更新されるTextをclassとして切り出しており、更新されるContextと異なるため）
    debugPrint("Build Whole Sample4");

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(width: 100, child: Text("Provider.of\n(listen: true)")),
        const _CountTextOfSample4(),
        ElevatedButton(
          onPressed: () {
            Provider.of<CounterViewModel>(context, listen: false)
                .incrementCounter4();
          },
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}

class _CountTextOfSample4 extends StatelessWidget {
  const _CountTextOfSample4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // context.watchと同義のため、CounterViewModelでnotifyListenersが呼ばれる度にリビルドされる
    // （非効率な例）
    debugPrint("Build Provider.of(listen:true) Text");

    return Text(Provider.of<CounterViewModel>(context).counter4.toString(),
        style: const TextStyle(fontSize: 30));
  }
}

///  Sample5.
class _Sample5 extends StatelessWidget {
  const _Sample5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 全体のビルドは最初の一度のみ
    // Consumerでリビルド範囲を絞っているため。
    debugPrint("Build Whole Sample5");

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(width: 100, child: Text("Consumer")),
        Consumer<CounterViewModel>(
          builder: (ctx, model, _) {
            // CounterViewModelでnotifyListenersが呼ばれる度にリビルドされるため、
            // Selectorの方が効率的。
            debugPrint("Build Consumer Text");

            return Text(model.counter5.toString(),
                style: const TextStyle(fontSize: 30));
          },
        ),
        ElevatedButton(
          onPressed: () {
            context.read<CounterViewModel>().incrementCounter5();
          },
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}

///  Sample6.
class _Sample6 extends StatelessWidget {
  const _Sample6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 全体のビルドは最初の一度のみ
    // Selectorでリビルド範囲を絞っているため。
    debugPrint("Build Whole Sample6");

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(width: 100, child: Text("Selector")),
        Selector<CounterViewModel, int>(
          selector: (ctx, model) => model.counter6,
          builder: (ctx, count, _) {
            // context.selectと同義のため、他のnotifyListenersが呼ばれてもリビルドされない
            // （効率的な例）
            // shouldRebuildでリビルドの条件をさらに指定可能。
            debugPrint("Build Selector Text");

            return Text(count.toString(), style: const TextStyle(fontSize: 30));
          },
        ),
        ElevatedButton(
          onPressed: () {
            context.read<CounterViewModel>().incrementCounter6();
          },
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
