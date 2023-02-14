import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_drag_drop/bloc/drag/drag_state.dart';
import 'package:test_drag_drop/ui/widgets/drag_widgets/drag_wrapper.dart';
import 'package:test_drag_drop/ui/widgets/drag_widgets/widgets/widget_size_render_object.dart';
import 'bloc/drag/drag_bloc.dart';
import 'bloc/drag/drag_event.dart';
import 'model/widget_model.dart';

class DragViewWidget extends StatelessWidget {
  late DragBloc bloc;

  DragViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<DragBloc>(context);
    return _getBody;
  }


  Widget get _getBody => BlocBuilder<DragBloc, DragState>(
        builder: (BuildContext context, state) {
          return Stack(
            children: [
              WidgetSizeOffsetWrapper(
                  onSizeChange: (Size size) {
                    bloc.add(InitSize(width: size.width, height: size.height));
                  },
                  child: Container(color: Colors.red, child: Image.asset("assets/plan_1.png"))),
              _getDragTarget,
              Positioned(child: ElevatedButton(child: Icon(Icons.add), onPressed: ()=>context.read<DragBloc>().add(OnAddItemClicked(dx: 200, dy: 200)),)),
              for (WidgetModel wm in state.widgetList) DragWrapper(widgetModel: wm,)
            ],
          );
        },
      );

  Widget get _getDragTarget => BlocBuilder<DragBloc, DragState>(builder: (BuildContext context, state) {
    return  Positioned(
      right: 30,
      bottom: 30,
      child: AnimatedOpacity(
        opacity: state.didItemOverRemoveTarget? 0.4: 1,
        duration: Duration(milliseconds: 500),
        child: AnimatedScale(
          scale: state.didItemOverRemoveTarget? 1.5: 1,
          duration: Duration(milliseconds: 500),
          child: AnimatedSwitcher(duration: const Duration(milliseconds: 500),
            child: state.holdState?
            DragTarget<int>(
              onMove: (d){
                bloc.add(OnItemOverDeleteTargetStateChange(true));
              },
              onLeave: (d){
                bloc.add(OnItemOverDeleteTargetStateChange(false));
              },
              builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,) {
                return ClipOval(
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    color: Colors.red,
                    child: const Center(child: Icon(Icons.delete_outline_outlined, color: Colors.white, size: 45,)),
                  ),
                );
              },
              onAcceptWithDetails: (data){
                bloc.add(OnRemoveReq(data.data));
              },
            ): Container(),
          ),
        ),
      ),
    );
  },);

}
