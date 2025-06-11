import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketbase/pocketbase.dart' show ClientException;

part 'base_state.dart';
part 'state_status.dart';

abstract class BaseCubit<TState> extends Cubit<TState> {
  BaseCubit(super.initState);

  void handleError(String message);

  Future<void> makeErrorHandledCall(AsyncValueGetter callback) async {
    try {
      await callback();
    } on ClientException catch (exception, stackTrace) {
      log(
        'Exeption in makeErrorHandledCall()',
        error: exception,
        stackTrace: stackTrace,
      );

      handleError(exception.response['message']);
    } catch (exception, stackTrace) {
      log(
        'Exeption in makeErrorHandledCall()',
        error: exception,
        stackTrace: stackTrace,
      );
      handleError(exception.toString());
    }
  }
}
