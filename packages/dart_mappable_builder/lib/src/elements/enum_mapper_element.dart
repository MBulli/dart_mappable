import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:dart_mappable/dart_mappable.dart';

import '../generators/enum_mapper_generator.dart';
import '../utils.dart';
import 'mapper_element.dart';

class EnumMapperElement extends MapperElement<EnumElement> {
  EnumMapperElement(super.parent, super.element, super.options);

  late String paramName = className[0].toLowerCase();

  late ValuesMode mode = annotation != null
      ? ValuesMode.values[
          annotation?.getField('mode')?.getField('index')?.toIntValue() ?? 0]
      : ValuesMode.named;

  late CaseStyle? caseStyle =
      annotation != null && !annotation!.getField('caseStyle')!.isNull
          ? caseStyleFromAnnotation(annotation!.getField('caseStyle')!)
          : options.enumCaseStyle;

  late int? defaultValue =
      annotation?.getField('defaultValue')!.getField('index')?.toIntValue();

  @override
  DartObject? getAnnotation() =>
      enumChecker.firstAnnotationOf(annotatedElement);
}
