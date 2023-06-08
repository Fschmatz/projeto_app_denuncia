import 'denuncia_dao.dart';

void saveDenuncia(String question, String answer) async {
  final db = DenunciaDao.instance;
  /*Map<String, dynamic> row = {
    DenunciaDao.columnShortDescription: question,
    DenunciaDao.columnDescription: answer,
  };
  await db.insert(row);
 */
}

void deleteDenuncia(int id) async {
  final db = DenunciaDao.instance;
  await db.delete(id);
}
