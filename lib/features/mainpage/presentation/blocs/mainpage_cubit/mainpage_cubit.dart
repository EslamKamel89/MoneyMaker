import 'package:bloc/bloc.dart';
import 'package:trading/features/mainpage/domain/models/banner_model.dart';
import 'package:trading/features/mainpage/domain/repo_interface/advetise_repo_interface.dart';

part 'mainpage_state.dart';

class MainpageCubit extends Cubit<MainpageState> {
  AdvertiseRepoInterface advertiseRepo;
  MainpageCubit({required this.advertiseRepo}) : super(MainpageInitial());
  Future<List<BannerModel>?> getAdvertise() async {
    if (isClosed) {
      return null;
    }
    emit(MainpageLoadingState());
    final response = await advertiseRepo.getAdvertise();
    if (isClosed) {
      return null;
    }
    return response.fold(
      (errorModel) {
        emit(MainpageFailureState(errorMessage: errorModel.errorMessageEn ?? "Advertise banners not found"));
        return null;
      },
      (banners) async {
        emit(AdvertiseSuccessState(banners: banners));
        return banners;
      },
    );
  }
}
