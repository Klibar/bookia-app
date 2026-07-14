import 'package:bookia/features/home/domain/entities/book_entity.dart';
import 'package:bookia/features/home/domain/repositories/book_repository.dart';

class GetBookDetailsUseCase {
  final BookRepository repository;

  GetBookDetailsUseCase(this.repository);

  Future<BookEntity> call(int id) => repository.getBookById(id);
}
