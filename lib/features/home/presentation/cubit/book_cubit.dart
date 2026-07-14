import 'package:bookia/features/home/domain/usecases/get_book_details_usecase.dart';
import 'package:bookia/features/home/domain/usecases/get_books_usecase.dart';
import 'package:bookia/features/home/presentation/cubit/book_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookCubit extends Cubit<BookState> {
  final GetBooksUseCase getBooksUseCase;
  final GetBookDetailsUseCase getBookDetailsUseCase;

  BookCubit({required this.getBooksUseCase, required this.getBookDetailsUseCase})
      : super(BookInitialState());

  Future<void> loadBooks() async {
    emit(BookLoadingState());
    try {
      final books = await getBooksUseCase();
      emit(BookLoadedState(books));
    } catch (e) {
      emit(BookErrorState(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> loadBookDetails(int id) async {
    emit(BookDetailsLoadingState());
    try {
      final book = await getBookDetailsUseCase(id);
      emit(BookDetailsLoadedState(book));
    } catch (e) {
      emit(BookDetailsErrorState(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
