import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wiki_vault/src/models/article.dart';
import 'package:wiki_vault/src/views/widgets/general/snack_bar.dart';
import 'package:wiki_vault/src/core/messages.dart' as app_msg;

part 'bookmark_event.dart';
part 'bookmark_state.dart';

/// Bloc class handling bookmarking functionality by adding and removing articles to and from the Hive database
class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkBloc() : super(const BookmarkState()) {
    on<BookmarkInit>(_init);
    on<AddBookmark>(_addBookmark);
    on<RemoveBookmark>(_removeBookmark);
  }

  Future<void> _init(BookmarkInit event, Emitter<BookmarkState> emit) async {
    Box<Article> articleBox = await Hive.openBox<Article>('Articles');
    List<int> articleKeys = articleBox.keys.cast<int>().toList();

    emit(state.copyWith(
        status: BookmarkStatus.standby,
        articleBox: articleBox,
        article: articleKeys
    ));
  }

  Future<void> _addBookmark(AddBookmark event, Emitter<BookmarkState> emit) async {
    List<int> articles = state.article.toList(growable: true);
    Article article = event.article;
    bool pageInBookmark = state.articleBox!.containsKey(article.pageID);

    try {
      state.articleBox!.put(article.pageID, article);
      articles.add(article.pageID);
    } on Error {
      showSnackBarError(event.context, pageInBookmark
          ? app_msg.eventChangeBookmarkError(article.title)
          : app_msg.eventAddBookmarkError(article.title));
      return;
    }
    showSnackBarSuccess(event.context, pageInBookmark
        ? app_msg.eventChangeBookmarkSuccess(article.title)
        : app_msg.eventAddBookmarkSuccess(article.title));

    emit(state.copyWith(article: articles));
  }

  Future<void> _removeBookmark(RemoveBookmark event, Emitter<BookmarkState> emit) async {
    List<int> articles = state.article.toList(growable: true);
    Article article = event.article;

    try {
      state.articleBox!.delete(article.pageID);
      articles.remove(article.pageID);
    } on Error {
      showSnackBarError(event.context, app_msg.eventRemoveBookmarkError(article.title));
      return;
    }
    showSnackBarSuccess(event.context, app_msg.eventRemoveBookmarkSuccess(article.title));

    emit(state.copyWith(article: articles));
  }
}