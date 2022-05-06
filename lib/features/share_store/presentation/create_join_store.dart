import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

enum _ActionType { create, join }

class CreateJoinStore extends StatefulWidget {
  const CreateJoinStore({Key? key}) : super(key: key);

  static const path = "/create-join-store";

  @override
  State<CreateJoinStore> createState() => _CreateJoinStoreState();
}

class _CreateJoinStoreState extends State<CreateJoinStore> {
  _ActionType _actionType = _ActionType.create;

  final _nameController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _SelectorButton(
              onActionChanged: (actionType) => setState(() {
                _actionType = actionType;
              }),
              selectedAction: _actionType,
            ),
          ),
          const Spacer(flex: 3),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: AnimatedCrossFade(
              firstChild: _buildCreateStore(),
              secondChild: _buildJoinStore(),
              crossFadeState: _actionType == _ActionType.create
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
            child: AnimatedBuilder(
              animation: Listenable.merge([_nameController, _codeController]),
              builder: (context, child) => ElevatedButton(
                onPressed: _canContinue ? () {} : null,
                child: const Text("Continue"),
              ),
            ),
          ),
          const Spacer(flex: 5),
        ],
      ),
    );
  }

  bool get _canContinue =>
      (_actionType == _ActionType.create && _nameController.text.isNotEmpty) ||
      (_actionType == _ActionType.join && _codeController.text.length == 6);

  Widget _buildCreateStore() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Store Name",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(hintText: "ABC XYZ"),
        ),
      ],
    );
  }

  Widget _buildJoinStore() {
    final _theme = Theme.of(context);
    final _colorScheme = _theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Store code",
          style: _theme.textTheme.bodyLarge,
        ),
        PinCodeTextField(
          pinTheme: PinTheme(
            inactiveColor: _colorScheme.secondary.withOpacity(.2),
            selectedColor: _colorScheme.primary,
            activeColor: _colorScheme.secondary,
          ),
          textStyle: _theme.textTheme.bodyLarge,
          cursorColor: _colorScheme.secondary,
          animationType: AnimationType.fade,
          appContext: context,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          controller: _codeController,
          onChanged: (value) {},
          length: 6,
          keyboardType: TextInputType.text,
        ),
      ],
    );
  }
}

class _SelectorButton extends StatelessWidget {
  const _SelectorButton({
    Key? key,
    required this.selectedAction,
    required this.onActionChanged,
  }) : super(key: key);

  final _ActionType selectedAction;
  final Function(_ActionType actionType) onActionChanged;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(width: 0, color: Colors.transparent),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          TextButtonTheme(
            data: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: _theme.colorScheme.onSecondary,
                splashFactory: NoSplash.splashFactory,
              ),
            ),
            child: SizedBox(
              height: _size.height / 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      onPressed: () => onActionChanged(_ActionType.create),
                      child: const Text("Create"),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () => onActionChanged(_ActionType.join),
                      child: const Text("Join"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedAlign(
            alignment: selectedAction == _ActionType.create
                ? Alignment.centerLeft
                : Alignment.centerRight,
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 300),
            child: Container(
              width: _size.width / 2,
              height: _size.height / 15,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSecondary,
                borderRadius: BorderRadius.circular(100),
              ),
              alignment: Alignment.center,
              child: Text(
                selectedAction == _ActionType.create ? "Create" : "Join",
                style: _theme.textTheme.bodyMedium!.copyWith(
                  color: _theme.colorScheme.secondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
