import 'package:bloc/bloc.dart';
import 'package:trading/core/const-strings/app_strings.dart';
import 'package:trading/core/extensions/extensions.dart';
import 'package:trading/features/notifications-news-certifications/data/news_repo_implement.dart';
import 'package:trading/features/notifications-news-certifications/domain/models/certification_model.dart';
import 'package:trading/features/notifications-news-certifications/domain/models/news_model.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepo newsRepo;

  NewsCubit({required this.newsRepo}) : super(NewsInitial());

  String newsAr =
      "عزيزي المستخدم، نرحب بك ترحيبًا حارًا. نأمل مخلصين أن تجربتك مع  تطبيقنا لن تكون أقل من تجربة استثنائية. ";
  String newsEn =
      "Dear User, we extend our warmest welcome to you. We sincerely hope that your experience with MoneyMaker will be nothing short of exceptional. ";
  List<CertificationModel> certifications = [];
  List<NewsModel> blogNews = [];

  Future getNews() async {
    const t = "NewsCubit - getNews";
    emit(NewsLoadingState());
    final response = await newsRepo.getNews();
    response.fold(
      (errorModel) {
        if (!isClosed) {
          emit(
            NewsFailureState(
                errorMessage: errorModel.errorMessageEn ?? "Error Occured When Looking For News In Database"),
          );
        }
      },
      (List<NewsModel> news) {
        newsAr = AppStrings.newsAr;
        newsEn = AppStrings.newsEn;

        if (news.isEmpty) {
          if (!isClosed) {
            emit(NewsSuccessState());
          }
          return;
        }
        newsAr = "";
        newsEn = "";
        for (var newModel in news) {
          if (newModel.nameAr == null ||
              newModel.nameAr == "" ||
              newModel.descriptionAr == null ||
              newModel.descriptionAr == "") {
            newsAr = "$newsAr -- ${AppStrings.newsAr} --";
          } else {
            newsAr = "$newsAr -- ${newModel.nameAr} - ${newModel.descriptionAr} --";
          }
          if (newModel.nameEn == null ||
              newModel.nameEn == "" ||
              newModel.descriptionEn == null ||
              newModel.descriptionEn == "") {
            newsEn = "$newsEn -- ${AppStrings.newsEn} --";
          } else {
            newsEn = "$newsAr --${newModel.nameEn} - ${newModel.descriptionEn}--";
          }
        }
        newsAr.prm(t);
        newsEn.prm(t);
        if (!isClosed) {
          emit(NewsSuccessState());
        }
      },
    );
  }

  Future getCertifications() async {
    emit(CertificationsLoadingState());
    final response = await newsRepo.getCertifications();
    response.fold(
      (errorModel) {
        if (!isClosed) {
          emit(CertificationsFailureState(errorMessage: errorModel.errorMessageEn ?? "Unknow Error"));
        }
      },
      (allCertifications) {
        certifications = allCertifications;
        if (!isClosed) {
          emit(CertificationsSuccessState());
        }
      },
    );
  }

  Future getBlogNews() async {
    const t = "NewsCubit - getBlogNews";
    emit(NewsBlogLoadingState());
    final response = await newsRepo.getNews();
    response.fold(
      (errorModel) {
        if (!isClosed) {
          errorModel.errorMessageEn.prm(t);
          emit(
            NewsBlogFailureState(
                errorMessage: errorModel.errorMessageEn ?? "Error Occured When Looking For News In Database"),
          );
        }
      },
      (List<NewsModel> news) {
        blogNews = news;
        blogNews.prm(t);
        if (!isClosed) {
          emit(NewsBlogSuccessState());
        }
      },
    );
  }
}
