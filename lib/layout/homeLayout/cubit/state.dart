abstract class HomeStates {}

class HomeInitialState extends HomeStates {}


class ChangeLocalState extends HomeStates {}

class ChangeLanguageArState extends HomeStates {}

class ChangeLanguageEnState extends HomeStates {}

class HomeChangeBottomNav extends HomeStates {}

class LoadingGetUserData extends HomeStates {}

class SuccessGetUserData extends HomeStates {}

class ErrorGetUserData extends HomeStates {}

class EditProfileLoading extends HomeStates {}

class EditProfileSuccess extends HomeStates {
  final Map<String, dynamic> successModel;

  EditProfileSuccess(this.successModel);
}

class EditProfileError extends HomeStates {
  final String errorModel;

  EditProfileError(this.errorModel);
}

class UpdatePasswordLoading extends HomeStates {}

class UpdatePasswordSuccess extends HomeStates {
  final Map<String, dynamic> successModel;

  UpdatePasswordSuccess(this.successModel);
}

class UpdatePasswordError extends HomeStates {
  final String errorModel;

  UpdatePasswordError(this.errorModel);
}

class GetLocationState extends HomeStates {}

class DeleteAccountLoading extends HomeStates {}

class DeleteAccountSuccess extends HomeStates {
  final Map<String, dynamic> successModel;

  DeleteAccountSuccess(this.successModel);
}

class DeleteAccountError extends HomeStates {
  final String errorModel;

  DeleteAccountError(this.errorModel);
}

class HomePostImagePickedSuccessState extends HomeStates {}

class HomePostImagePickedErrorState extends HomeStates {}

class LoadingGetAllEvent extends HomeStates {}

class SuccessGetAllEvent extends HomeStates {}

class ErrorGetAllEvent extends HomeStates {}

class LoadingGetEvent extends HomeStates {}

class SuccessGetEvent extends HomeStates {}

class ErrorGetEvent extends HomeStates {}

class LoadingGetAllPlaces extends HomeStates {}

class SuccessGetAllPlaces extends HomeStates {}

class ErrorGetAllPlaces extends HomeStates {}

class LoadingGetPlace extends HomeStates {}

class SuccessGetPlace extends HomeStates {}

class ErrorGetPlace extends HomeStates {}

class LoadingGetAllTrips extends HomeStates {}

class SuccessGetAllTrips extends HomeStates {}

class ErrorGetAllTrips extends HomeStates {}

class LoadingGetTrips extends HomeStates {}

class SuccessGetTrips extends HomeStates {}

class ErrorGetTrips extends HomeStates {}

class LoadingGetSearch extends HomeStates {}

class SuccessGetSearch extends HomeStates {}

class ErrorGetSearch extends HomeStates {}

class LoadingGetAllRecomended extends HomeStates {}

class SuccessGetAllRecomended extends HomeStates {}

class ErrorGetAllRecomended extends HomeStates {}

class LoadingReview extends HomeStates {}

class SuccessReview extends HomeStates {
  final Map<String, dynamic> successModel;

  SuccessReview(this.successModel);
}

class ErrorReview extends HomeStates {
  final String errorModel;

  ErrorReview(this.errorModel);
}

class LoadingGetAllArticles extends HomeStates {}

class SuccessGetAllArticles extends HomeStates {}

class ErrorGetAllArticles extends HomeStates {}

class LoadingGetArticles extends HomeStates {}

class SuccessGetArticles extends HomeStates {}

class ErrorGetArticles extends HomeStates {}

class LoadingFavoritePlace extends HomeStates {}

class SuccessFavoritePlace extends HomeStates {}

class ErrorFavoritePlace extends HomeStates {}

class LoadingFavoriteArticlePlace extends HomeStates {}

class SuccessFavoriteArticlePlace extends HomeStates {}

class ErrorFavoriteArticlePlace extends HomeStates {}
class LoadingRemoveFavoritePlace extends HomeStates {}

class SuccessRemoveFavoritePlace extends HomeStates {}

class ErrorRemoveFavoritePlace extends HomeStates {}

class LoadingRemoveFavoriteArticlePlace extends HomeStates {}

class SuccessRemoveFavoriteArticlePlace extends HomeStates {}

class ErrorRemoveFavoriteArticlePlace extends HomeStates {}

class LoadingGetFavorite extends HomeStates {}

class SuccessGetFavorite extends HomeStates {}

class ErrorGetFavorite extends HomeStates {}

class LoadingUserTipsPlace extends HomeStates {}

class SuccessUserTipsPlace extends HomeStates {}

class ErrorUserTipsPlace extends HomeStates {}

class LoadingRemoveUserTipsPlace extends HomeStates {}

class SuccessRemoveUserTipsPlace extends HomeStates {}

class ErrorRemoveUserTipsPlace extends HomeStates {}

class ChangeAppMode extends HomeStates {}

class LoadingGetAllRecommend extends HomeStates {}

class SuccessGetAllRecommend extends HomeStates {}

class ErrorGetAllRecommend extends HomeStates {}

class DiscardChange extends HomeStates {}


class ChangePasswordVisibilityState extends HomeStates {}