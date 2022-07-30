import 'best_seller.dart';
import 'home_store.dart';

class baseRepository {
  List<HomeStore>? homeStore;
  List<BestSeller>? bestSeller;

  baseRepository({this.homeStore, this.bestSeller});

  baseRepository.fromJson(Map<String, dynamic> json) {
    if (json['home_store'] != null) {
      homeStore = <HomeStore>[];
      json['home_store'].forEach((v) {
        homeStore!.add(HomeStore.fromJson(v));
      });
    }
    if (json['best_seller'] != null) {
      bestSeller = <BestSeller>[];
      json['best_seller'].forEach((v) {
        bestSeller!.add(BestSeller.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (homeStore != null) {
      data['home_store'] = homeStore!.map((v) => v.toJson()).toList();
    }
    if (bestSeller != null) {
      data['best_seller'] = bestSeller!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


