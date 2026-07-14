import 'package:bookia/features/home/domain/entities/book_entity.dart';
import 'package:bookia/features/home/domain/repositories/book_repository.dart';

class GetBooksUseCase {
  final BookRepository repository;

  GetBooksUseCase(this.repository);

  Future<List<BookEntity>> call() => repository.getBooks();
}
