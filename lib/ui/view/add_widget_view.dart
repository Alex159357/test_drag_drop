import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_drag_drop/bloc/drag/drag_bloc.dart';
import 'package:test_drag_drop/helpers/states/widget_types.dart';
import 'package:collection/collection.dart';
import 'package:test_drag_drop/model/module_id.dart';
import '../../bloc/drag/drag_event.dart';
import '../../bloc/drag/drag_state.dart';
import '../../helpers/constaints.dart';
import '../../helpers/states/device_types.dart';
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
      width: 450,
      height: 550,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
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
          _getModuleSelect,
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
          DeviceTypes widgetTypes = state.addWidgetState.widgetType.isNotEmpty
              ? DeviceTypes.values.firstWhere((element) =>
                  element.getKey == state.addWidgetState.widgetType)
              : DeviceTypes.ANALOG_OUTPUT_1;
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
                  child: DropdownButton<DeviceTypes>(
                    value: widgetTypes,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    elevation: 16,
                    underline: Container(
                      color: Colors.transparent,
                    ),
                    onChanged: (DeviceTypes? value) {
                      bloc.add(OnTypeChanged(value!.getKey));
                    },
                    items: DeviceTypes.values
                        .map<DropdownMenuItem<DeviceTypes>>(
                            (DeviceTypes value) {
                      return DropdownMenuItem<DeviceTypes>(
                        value: value,
                        child: Text(
                          value.getName,
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
          HubIdModel? selectedHub =  state.hubList.isNotEmpty? state.hubList.firstWhereOrNull((element) => element.id == state.addWidgetState.selectedHub) ?? state.hubList[0] : null;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AddWidgetDialog.deviceHub,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.grey.withOpacity(.3)
                  ),
                  child: DropdownButton<HubIdModel>(
                    value: selectedHub,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    elevation: 16,
                    underline: Container(
                      color: Colors.transparent,
                    ),
                    onChanged: (HubIdModel? value) {
                      bloc.add(OnHubChanged(value!.id!));
                    },
                    items: state.hubList
                        .map<DropdownMenuItem<HubIdModel>>(
                            (HubIdModel value) {
                      return DropdownMenuItem<HubIdModel>(
                        value: value,
                        child: Text(
                          value.id!,
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

  Widget get _getModuleSelect => BlocBuilder<DragBloc, DragState>(
    builder: (BuildContext context, state) {
      List<ModuleModel> moduleList = state.modelList.where((element) =>  element.hubId == state.addWidgetState.selectedHub && element.status).toList();
      if(moduleList.isNotEmpty && state.addWidgetState.selectedHub.isNotEmpty) {
        ModuleModel selectedModel = state.modelList.firstWhereOrNull((element) => element.id == state.addWidgetState.selectedModule) ?? state.modelList.first;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AddWidgetDialog.moduleSelect,
                style: Theme
                    .of(context)
                    .textTheme
                    .titleSmall,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey.withOpacity(.3)
                ),
                child: DropdownButton<ModuleModel>(
                  value: selectedModel,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  elevation: 16,
                  underline: Container(
                    color: Colors.transparent,
                  ),
                  onChanged: (ModuleModel? value) {
                    bloc.add(OnModuleSelected(value!.id));
                  },
                  items: state.modelList
                      .map<DropdownMenuItem<ModuleModel>>(
                          (ModuleModel value) {
                        return DropdownMenuItem<ModuleModel>(
                          value: value,
                          child: Text(
                            value.name,
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall,
                          ),
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        );
      }else{
        return Container();
      }
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
  // 0800 210 800
  // 2513

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
