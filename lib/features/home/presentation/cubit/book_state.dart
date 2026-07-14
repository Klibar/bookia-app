import 'package:bookia/features/home/domain/entities/book_entity.dart';

abstract class BookState {}

class BookInitialState extends BookState {}

class BookLoadingState extends BookState {}

class BookLoadedState extends BookState {
  final List<BookEntity> books;
  BookLoadedState(this.books);
}

class BookErrorState extends BookState {
  final String message;
  BookErrorState(this.message);
}

class BookDetailsLoadingState extends BookState {}

class BookDetailsLoadedState extends BookState {
  final BookEntity book;
  BookDetailsLoadedState(this.book);
}

class BookDetailsErrorState extends BookState {
  final String message;
  BookDetailsErrorState(this.message);
}
