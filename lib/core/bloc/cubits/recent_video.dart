import 'package:nexor/src/core/typedef/future.dart';
import 'package:quivor/core/bloc/base_cubit.dart';
import 'package:quivor/core/models/entities/recent.dart';
import 'package:quivor/core/models/entities/video.dart';
import 'package:quivor/core/service/interface/video.dart';
import 'package:quivor/getit_settings.dart';

final class RecentVideosCubit extends BaseCubit<List<VideoEntity>> {
  RecentVideosCubit() : super([]);
  @override
  FV init() async {
    final x = await getIt<IVideoService>().recentVideos();
    emit(x);
  }

  FV update(VideoEntity entity) async {
    await getIt<IVideoService>().createRecent(entity);
    state.removeWhere(
      (e) => e == entity,
    );
    final result = [entity, ...state];
    emit(result);
  }
}
