import 'dart:math';

import 'package:over_react/over_react.dart';
import 'package:scadnano/src/state/modification.dart';

import '../state/strand.dart';
import '../state/helix.dart';
import '../constants.dart' as constants;

part 'design_main_strand_modification_bound_substrand.over_react.g.dart';

@Factory()
UiFactory<DesignMainStrandModificationBoundSubstrandProps> DesignMainStrandModificationBoundSubstrand =
    _$DesignMainStrandModificationBoundSubstrand;

@Props()
class _$DesignMainStrandModificationBoundSubstrandProps extends UiProps {
  Address address;
  Helix helix;
  Modification modification;
}

@Component2()
class DesignMainStrandModificationBoundSubstrandComponent
    extends UiComponent2<DesignMainStrandModificationBoundSubstrandProps> {
  @override
  render() {
    Point<num> pos = props.helix.svg_base_pos(props.address.offset, props.address.forward);
    if (props.modification is Modification5Prime) {
      return (Dom.g()..className = "'modification-5'")(
        _end_connector(pos, props.address.forward),
        _modification_svg(pos, props.address.forward),
      );
    } else if (props.modification is Modification3Prime) {
      return (Dom.g()..className = "'modification-3'")(
        _end_connector(pos, props.address.forward),
        _modification_svg(pos, props.address.forward),
      );
    } else {
      return (Dom.g()..className = 'modification-internal')(
        _internal_connector(pos, props.address.forward),
        _modification_svg(pos, props.address.forward),
      );
    }
  }

  ReactElement _end_connector(Point<num> pos, bool forward) {
    double y_del_small = (forward ? -Y_DELTA_MOD : Y_DELTA_MOD) / 4.0;
    double x = -X_DELTA_MOD;
    return (Dom.polyline()
      ..fill = 'none'
      ..stroke = 'black'
      ..strokeWidth = 2
      ..points = ''
          '${pos.x},${pos.y} '
          '${pos.x + x},${pos.y + y_del_small} '
          '${pos.x},${pos.y + 2 * y_del_small} '
          '${pos.x + x},${pos.y + 3 * y_del_small} '
          '${pos.x},${pos.y + 4 * y_del_small}'
      ..key = 'connector')();
  }

  ReactElement _internal_connector(Point<num> pos, bool forward) {
    double y_del_small = (forward ? -Y_DELTA_MOD : Y_DELTA_MOD).toDouble();
    return (Dom.line()
      ..stroke = 'black'
      ..strokeWidth = 2
      ..x1 = pos.x
      ..y1 = pos.y
      ..x2 = pos.x
      ..y2 = pos.y + y_del_small
      ..key = 'connector')();
  }

  ReactElement _modification_svg(Point<num> pos, bool forward) {
    double y_del_small = (forward ? -1.1 * Y_DELTA_MOD : Y_DELTA_MOD).toDouble();
    return (Dom.text()
    ..className='modification-text'
      ..x = pos.x
      ..y = pos.y + y_del_small
      ..dominantBaseline = forward ? 'baseline' : 'hanging'
      ..key = 'mod')(props.modification.display_text);
  }
}

const Y_DELTA_MOD = constants.BASE_HEIGHT_SVG * 1.8;
const X_DELTA_MOD = constants.BASE_WIDTH_SVG / 3.0;
