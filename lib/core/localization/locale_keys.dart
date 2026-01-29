// ignore_for_file: constant_identifier_names

/// Locale keys for translations
///
/// Usage:
/// ```dart
/// import 'package:quivor/core/localization/localization_service.dart';
///
/// Text(LocaleKeys.app_name.tr())
/// Text(LocaleKeys.common_ok.tr())
/// Text(LocaleKeys.subtitle_downloading.tr(namedArgs: {'fileName': 'sub.srt'}))
/// ```
class LocaleKeys {
  // App
  static const app_name = 'app.name';
  static const app_title = 'app.title';

  // Common
  static const common_ok = 'common.ok';
  static const common_cancel = 'common.cancel';
  static const common_close = 'common.close';
  static const common_save = 'common.save';
  static const common_delete = 'common.delete';
  static const common_edit = 'common.edit';
  static const common_search = 'common.search';
  static const common_refresh = 'common.refresh';
  static const common_loading = 'common.loading';
  static const common_error = 'common.error';
  static const common_success = 'common.success';
  static const common_warning = 'common.warning';
  static const common_confirm = 'common.confirm';

  // Home
  static const home_title = 'home.title';
  static const home_recent_videos = 'home.recent_videos';
  static const home_playlists = 'home.playlists';
  static const home_no_recent_videos = 'home.no_recent_videos';
  static const home_no_playlists = 'home.no_playlists';
  static const home_create_playlist = 'home.create_playlist';
  static const home_open_video = 'home.open_video';
  static const home_open_folder = 'home.open_folder';

  // Playlist
  static const playlist_title = 'playlist.title';
  static const playlist_name = 'playlist.name';
  static const playlist_videos = 'playlist.videos';
  static const playlist_total = 'playlist.total';
  static const playlist_watched = 'playlist.watched';
  static const playlist_add_videos = 'playlist.add_videos';
  static const playlist_remove_video = 'playlist.remove_video';
  static const playlist_play_all = 'playlist.play_all';
  static const playlist_delete_playlist = 'playlist.delete_playlist';
  static const playlist_edit_playlist = 'playlist.edit_playlist';
  static const playlist_start_over = 'playlist.start_over';
  static const playlist_start_over_confirm = 'playlist.start_over_confirm';
  static const playlist_start_over_warning = 'playlist.start_over_warning';
  static const playlist_start_over_success = 'playlist.start_over_success';

  // Player
  static const player_play = 'player.play';
  static const player_pause = 'player.pause';
  static const player_stop = 'player.stop';
  static const player_next = 'player.next';
  static const player_previous = 'player.previous';
  static const player_volume = 'player.volume';
  static const player_speed = 'player.speed';
  static const player_fullscreen = 'player.fullscreen';
  static const player_exit_fullscreen = 'player.exit_fullscreen';
  static const player_subtitles = 'player.subtitles';
  static const player_audio_track = 'player.audio_track';
  static const player_no_subtitle = 'player.no_subtitle';
  static const player_search_subtitles = 'player.search_subtitles';
  static const player_load_local_subtitle = 'player.load_local_subtitle';
  static const player_auto_play_settings = 'player.auto_play_settings';
  static const player_mark_watched_next = 'player.mark_watched_next';
  static const player_subtitle_sync = 'player.subtitle_sync';
  static const player_reset = 'player.reset';
  static const player_seek_duration = 'player.seek_duration';
  static const player_seek_duration_desc = 'player.seek_duration_desc';
  static const player_notes = 'player.notes';
  static const player_add_note = 'player.add_note';
  static const player_note_placeholder = 'player.note_placeholder';
  static const player_note_saved = 'player.note_saved';
  static const player_note_deleted = 'player.note_deleted';
  static const player_no_notes = 'player.no_notes';

  // Subtitle
  static const subtitle_search = 'subtitle.search';
  static const subtitle_download = 'subtitle.download';
  static const subtitle_downloading = 'subtitle.downloading';
  static const subtitle_downloaded = 'subtitle.downloaded';
  static const subtitle_no_results = 'subtitle.no_results';
  static const subtitle_try_different = 'subtitle.try_different';
  static const subtitle_language = 'subtitle.language';
  static const subtitle_search_by_hash = 'subtitle.search_by_hash';
  static const subtitle_download_failed = 'subtitle.download_failed';
  static const subtitle_error = 'subtitle.error';
  static const subtitle_possible_reasons = 'subtitle.possible_reasons';
  static const subtitle_limit_exceeded = 'subtitle.limit_exceeded';
  static const subtitle_invalid_api_key = 'subtitle.invalid_api_key';
  static const subtitle_network_issue = 'subtitle.network_issue';
  static const subtitle_try_local = 'subtitle.try_local';

  // AutoPlay
  static const autoplay_title = 'autoplay.title';
  static const autoplay_mode = 'autoplay.mode';
  static const autoplay_manual = 'autoplay.manual';
  static const autoplay_manual_desc = 'autoplay.manual_desc';
  static const autoplay_on_complete = 'autoplay.on_complete';
  static const autoplay_on_complete_desc = 'autoplay.on_complete_desc';
  static const autoplay_early = 'autoplay.early';
  static const autoplay_early_desc = 'autoplay.early_desc';
  static const autoplay_auto_transition = 'autoplay.auto_transition';
  static const autoplay_auto_transition_desc = 'autoplay.auto_transition_desc';
  static const autoplay_transition_time = 'autoplay.transition_time';
  static const autoplay_seconds = 'autoplay.seconds';

  // Settings
  static const settings_title = 'settings.title';
  static const settings_language = 'settings.language';
  static const settings_theme = 'settings.theme';
  static const settings_about = 'settings.about';

  // Messages
  static const messages_video_not_found = 'messages.video_not_found';
  static const messages_playlist_created = 'messages.playlist_created';
  static const messages_playlist_deleted = 'messages.playlist_deleted';
  static const messages_video_added = 'messages.video_added';
  static const messages_video_removed = 'messages.video_removed';
  static const messages_error_occurred = 'messages.error_occurred';
  static const messages_no_videos_selected = 'messages.no_videos_selected';
}
