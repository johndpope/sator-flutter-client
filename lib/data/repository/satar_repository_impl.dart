import 'package:get/get.dart';
import 'package:satorio/binding/login_binding.dart';
import 'package:satorio/data/datasource/api_data_source.dart';
import 'package:satorio/data/datasource/exception/api_error_exception.dart';
import 'package:satorio/data/datasource/exception/api_unauthorized_exception.dart';
import 'package:satorio/data/datasource/local_data_source.dart';
import 'package:satorio/domain/entities/challenge.dart';
import 'package:satorio/domain/entities/challenge_simple.dart';
import 'package:satorio/domain/entities/claim_reward.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/entities/wallet_balance.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/login_page.dart';

class SatorioRepositoryImpl implements SatorioRepository {
  final ApiDataSource _apiDataSource;
  final LocalDataSource _localDataSource;

  SatorioRepositoryImpl(this._apiDataSource, this._localDataSource);

  _handleException(Exception exception) {
    if (exception is ApiErrorException) {
      Get.snackbar('txt_oops'.tr, exception.errorMessage);
    } else if (exception is ApiUnauthorizedException) {
      logout();
      Get.snackbar('txt_oops'.tr, exception.errorMessage);
    } else {
      throw exception;
    }
  }

  @override
  Future<bool> isTokenValid() {
    return _apiDataSource.isTokenExist().then((isTokenExist) {
      if (isTokenExist)
        return _apiDataSource
            .refreshToken()
            .catchError((value) => _handleException(value));
      else
        return isTokenExist;
    });
  }

  @override
  Future<bool> signIn(String email, String password) {
    return _apiDataSource
        .signIn(email, password)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<bool> signUp(String email, String password, String username) {
    return _apiDataSource
        .signUp(email, password, username)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<Profile> profile() {
    return _apiDataSource
        .profile()
        .catchError((value) => _handleException(value));
  }

  @override
  Future<WalletBalance> walletBalance() {
    return _apiDataSource
        .walletBalance()
        .catchError((value) => _handleException(value));
  }

  @override
  Future<List<Show>> shows({int page}) {
    return _apiDataSource
        .shows(page: page)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<List<ChallengeSimple>> showChallenges(String showId, {int page}) {
    return _apiDataSource
        .showChallenges(showId, page: page)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<void> logout() {
    return _apiDataSource.logout().then((value) {
      Get.offAll(() => LoginPage(), binding: LoginBinding());
      return;
    });
  }

  @override
  Future<Challenge> challenge(String challengeId) {
    return _apiDataSource
        .challenge(challengeId)
        .catchError((value) => _handleException(value));
  }

  @override
  Future<GetSocket> createSocket(String challengeId) {
    return _apiDataSource
        .socketUrl(challengeId)
        .then((socketUrl) => _apiDataSource.createSocket(socketUrl))
        .catchError((value) => _handleException(value));
  }

  @override
  Future<void> sendAnswer(
      GetSocket socket, String questionId, String answerId) {
    return _apiDataSource.sendAnswer(socket, questionId, answerId);
  }

  @override
  Future<ClaimReward> claimReward() {
    return _apiDataSource
        .claimReward()
        .catchError((value) => _handleException(value));
  }
}