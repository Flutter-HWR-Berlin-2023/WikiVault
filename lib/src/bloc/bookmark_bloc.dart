import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/article.dart';
import '../models/article_group.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkBloc() : super(const BookmarkState()) {
    on<BookmarkInit>(_init);
    on<AddBookmark>(_addBookmark);
    on<RemoveBookmark>(_removeBookmark);
    on<AddBookmarkGroup>(_addBookmarkGroup);
    on<RemoveBookmarkGroup>(_removeBookmarkGroup);
  }

  Future<void> _init(BookmarkInit event, Emitter<BookmarkState> emit) async {
    Box<ArticleGroup> groupBox = await Hive.openBox<ArticleGroup>('ArticleGroup');
    Box<Article> articleBox = await Hive.openBox<Article>('Article');

    emit(state.copyWith(status: BookmarkStatus.standby, groupBox: groupBox, articleBox: articleBox));
  }

  Future<void> _addBookmark(AddBookmark event, Emitter<BookmarkState> emit) async {

  }

  Future<void> _removeBookmark(RemoveBookmark event, Emitter<BookmarkState> emit) async {

  }

  Future<void> _addBookmarkGroup(AddBookmarkGroup event, Emitter<BookmarkState> emit) async {

  }

  Future<void> _removeBookmarkGroup(RemoveBookmarkGroup event, Emitter<BookmarkState> emit) async {

  }
}