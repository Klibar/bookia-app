import 'package:bookia/features/home/data/models/book_model.dart';
import 'package:bookia/features/home/domain/entities/book_entity.dart';
import 'package:bookia/features/home/domain/repositories/book_repository.dart';

/// Dummy implementation so the UI can be built and demoed before the real
/// books API is ready. Swap the body of these methods for Dio calls (see
/// AuthRepositoryImpl for the pattern) once the endpoint exists — the rest
/// of the app (cubits, pages) won't need to change since they only depend
/// on [BookRepository].
class BookRepositoryImpl implements BookRepository {
  static final List<BookModel> _dummyBooks = [
    const BookModel(
      id: 1,
      title: 'The Republic',
      author: 'Plato',
      price: 285,
      coverImage: 'https://picsum.photos/seed/republic1/300/420',
      description:
          'A classic work of philosophy exploring justice, order and the '
          'character of the just city-state and the just man.',
      isBestSeller: true,
    ),
    const BookModel(
      id: 2,
      title: 'The Republic',
      author: 'Plato',
      price: 285,
      coverImage: 'https://picsum.photos/seed/republic2/300/420',
      description:
          'A classic work of philosophy exploring justice, order and the '
          'character of the just city-state and the just man.',
      isBestSeller: true,
    ),
    const BookModel(
      id: 3,
      title: 'The Republic',
      author: 'Plato',
      price: 285,
      coverImage: 'https://picsum.photos/seed/republic3/300/420',
      description:
          'A classic work of philosophy exploring justice, order and the '
          'character of the just city-state and the just man.',
      isBestSeller: true,
    ),
    const BookModel(
      id: 4,
      title: 'The Republic',
      author: 'Plato',
      price: 285,
      coverImage: 'https://picsum.photos/seed/republic4/300/420',
      description:
          'A classic work of philosophy exploring justice, order and the '
          'character of the just city-state and the just man.',
      isBestSeller: true,
    ),
    const BookModel(
      id: 5,
      title: 'Black Heart',
      author: 'Holly Black',
      price: 285,
      coverImage: 'https://picsum.photos/seed/blackheart/300/420',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '
          'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut '
          'enim ad minim veniam, quis nostrud exercitation ullamco laboris '
          'nisi ut aliquip ex ea commodo consequat.',
    ),
  ];

  @override
  Future<List<BookEntity>> getBooks() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _dummyBooks;
  }

  @override
  Future<BookEntity> getBookById(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _dummyBooks.firstWhere(
      (b) => b.id == id,
      orElse: () => _dummyBooks.first,
    );
  }
}
