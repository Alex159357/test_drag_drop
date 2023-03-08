import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_drag_drop/bloc/drag/drag_bloc.dart';
import 'package:test_drag_drop/helpers/states/widget_types.dart';
import 'package:collection/collection.dart';
import '../../bloc/drag/drag_event.dart';
import '../../bloc/drag/drag_state.dart';
import '../../helpers/constaints.dart';
import '../../model/hub_id_model.dart';

class AddWidgetView extends StatelessWidget {
  late DragBloc bloc;

  AddWidgetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<DragBloc>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
              color: Colors.black38,
              blurRadius: 5.0,
              offset: Offset(5.3, 5.3),
              spreadRadius: 5.0)
        ],
      ),
      width: 400,
      height: 450,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AddWidgetDialog.dialogTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AddWidgetDialog.dialogTitle,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          _getNameField,
          const Divider(),
          _getTypeSelect,
          const Divider(),
          _getHubSelect,
          const Divider(),
          _getTagField,
          const Spacer(),
          const Divider(),
          _getButtonsBar
        ],
      ),
    );
  }

  Widget get _getNameField => BlocBuilder<DragBloc, DragState>(
        builder: (BuildContext context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey.withOpacity(.3)
              ),
              child: TextFormField(
                initialValue: state.addWidgetState.name,
                onChanged: (v) {
                  bloc.add(OnWidgetNameChanged(v));
                },
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: AddWidgetDialog.nameHintTitle),
              ),
            ),
          );
        },
      );

  Widget get _getTypeSelect => BlocBuilder<DragBloc, DragState>(
        builder: (BuildContext context, state) {
          WidgetTypes widgetTypes = state.addWidgetState.widgetType.isNotEmpty
              ? WidgetTypes.values.firstWhere((element) =>
                  element.getTitle == state.addWidgetState.widgetType)
              : WidgetTypes.UNDEFINED;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AddWidgetDialog.deviceType,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.grey.withOpacity(.3)
                  ),
                  child: DropdownButton<WidgetTypes>(
                    value: widgetTypes,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    elevation: 16,
                    underline: Container(
                      color: Colors.transparent,
                    ),
                    onChanged: (WidgetTypes? value) {
                      bloc.add(OnTypeChanged(value!.getTitle));
                    },
                    items: WidgetTypes.values
                        .map<DropdownMenuItem<WidgetTypes>>(
                            (WidgetTypes value) {
                      return DropdownMenuItem<WidgetTypes>(
                        value: value,
                        child: Text(
                          value.getTitle,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      );

  Widget get _getHubSelect => BlocBuilder<DragBloc, DragState>(
        builder: (BuildContext context, state) {
          HubIdModel widgetTypes = state.hubList.firstWhereOrNull((element) => element.id == state.selectedHubModel) ?? state.hubList[0];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AddWidgetDialog.deviceType,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.grey.withOpacity(.3)
                  ),
                  child: DropdownButton<HubIdModel>(
                    value: widgetTypes,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    elevation: 16,
                    underline: Container(
                      color: Colors.transparent,
                    ),
                    onChanged: (HubIdModel? value) {
                      bloc.add(OnHubChanged(value!.id));
                    },
                    items: state.hubList
                        .map<DropdownMenuItem<HubIdModel>>(
                            (HubIdModel value) {
                      return DropdownMenuItem<HubIdModel>(
                        value: value,
                        child: Text(
                          value.objectName,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      );

  Widget get _getButtonsBar => BlocBuilder<DragBloc, DragState>(
        builder: (BuildContext context, state) {
          return ButtonBar(
            mainAxisSize: MainAxisSize.max,
            children: [
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: state.addWidgetState.didFieldsValid? 1: .3,
                child: ElevatedButton(
                  onPressed: () => state.addWidgetState.didFieldsValid? bloc.add(OnAddWidgetBtnPressed()):{},
                  child: const Text(AddWidgetDialog.addTitle),
                ),
              ),
              TextButton(
                  onPressed: () => bloc.add(AddDialogState()),
                  child: const Text(
                    AddWidgetDialog.cancelTitle,
                    style: TextStyle(color: Colors.redAccent),
                  ))
            ],
          );
        },
      );

  Widget get _getTagField => BlocBuilder<DragBloc, DragState>(
        builder: (BuildContext context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey.withOpacity(.3)
              ),
              child: TextFormField(
                initialValue: state.addWidgetState.widgetTag,
                onChanged: (v) {
                  bloc.add(OnTagNameChanged(v));
                },
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: AddWidgetDialog.nameHintTitle),
              ),
            ),
          );
        },
      );
}
