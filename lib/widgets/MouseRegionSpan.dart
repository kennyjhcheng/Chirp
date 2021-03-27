import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MouseRegionSpan extends WidgetSpan {
  MouseRegionSpan({
    @required MouseCursor mouseCursor,
    @required InlineSpan inlineSpan,
  }) : super(
          child: MouseRegion(
            cursor: mouseCursor,
            child: Text.rich(
              inlineSpan,
            ),
          ),
        );
}
