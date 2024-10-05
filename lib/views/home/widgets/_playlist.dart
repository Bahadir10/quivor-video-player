part of '../home.dart';

class _PlaylistField extends StatelessWidget {
  final List<PlaylistStateResponseModel> playlists;

  const _PlaylistField({
    super.key,
    required this.playlists,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.cubit<_ScreenCubit>();
    return Expanded(
      child: ListView.builder(
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          final playlist = playlists[index];

          return ListTile(
            hoverColor: AppColors.grey2,
            shape: RoundedRectangleBorder(
              borderRadius: Cutter.small.all,
            ),
            onTap: () async => await cubit.goPlaylistScreen(playlist),
            contentPadding: Paddings.medium.horizontal,
            title: Text(
              playlist.name,
              style: AppTypography.bodyMedium,
            ),
            trailing: playlist.progressPercentage == 100
                ? Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.white1),
                    child: AppIcons.checked.copyWith(color: AppColors.black1),
                  )
                : CustomProgressIndicator(
                    percentage: playlist.progressPercentage),
          );
          // return InkWell(
          //   borderRadius: Cutter.small.all,
          //   onTap: () async => await cubit.goPlaylistScreen(playlist),
          //   hoverColor: Colors.grey.shade900,
          //   child: Padding(
          //     padding: Paddings.small.all,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Expanded(
          //           //  width: 400,
          //           child: Flexible(
          //             child: Text(
          //               playlist.name,
          //               overflow: TextOverflow.visible,
          //               style: GoogleFonts.ptSans(
          //                   color: AppColors.white1, fontSize: 16),
          //             ),
          //           ),
          //         ),
          //         if (percentage == 100)
          //           Container(
          //             decoration: BoxDecoration(
          //                 shape: BoxShape.circle, color: AppColors.white1),
          //             child: Icon(
          //               Icons.check,
          //               color: AppColors.black1,
          //             ),
          //           )
          //         else
          //           Stack(
          //             children: [
          //               Container(
          //                 color: AppColors.white1,
          //                 width: 100,
          //                 height: 1,
          //               ),
          //               Container(
          //                 color: Colors.pink,
          //                 width: percentage,
          //                 height: 1,
          //               ),
          //             ],
          //           ),
          //         Row(
          //           children: [
          //             Spacers.low.horizontal,
          //             Icon(
          //               Icons.chevron_right_sharp,
          //               color: AppColors.white1,
          //             )
          //           ],
          //         ),
          //         // SizedBox(
          //         //   height: 15,
          //         //   width: 100,
          //         //   child: LinearProgressIndicator(
          //         //     borderRadius: Cutter.small.all,
          //         //     value: percentage / 100,
          //         //   ),
          //         // ),
          //       ],
          //     ),
          //   ),
          // );
        },
        shrinkWrap: true,
      ),
    );
  }
}
