abstract class LocalStorage {
  Future<void> setString({required String index, required String value});
  Future<String?> getString({required String index});
  Future<void> setBool({required String index, required bool value});
  Future<bool?> getBool({required String index});
  Future<void> remove({required index});
}
