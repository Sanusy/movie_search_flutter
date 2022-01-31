import 'package:movie_search/data/title_details.dart';

class TitleDetailsState {
  final bool isLoading;
  final String? titleId;
  final TitleDetails? titleDetails;

  TitleDetailsState({
    required this.isLoading,
    required this.titleId,
    required this.titleDetails,
  });

  TitleDetailsState.initial()
      : isLoading = true,
        titleId = null,
        titleDetails = null;

  TitleDetailsState copy(
          {bool? isLoading, String? titleId, TitleDetails? titleDetails}) =>
      TitleDetailsState(
        isLoading: isLoading ?? this.isLoading,
        titleId: titleId ?? this.titleId,
        titleDetails: titleDetails ?? this.titleDetails,
      );
}
