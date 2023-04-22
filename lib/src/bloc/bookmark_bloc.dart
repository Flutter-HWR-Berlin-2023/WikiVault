import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wiki_vault/src/models/article.dart';
import 'package:wiki_vault/src/models/article_group.dart';
import 'package:wiki_vault/src/views/widgets/snackbar.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

// Bloc class handling bookmarking functionality by adding, removing, and grouping articles to and from the Hive database
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
    List<int> groupKeys = groupBox.keys.cast<int>().toList();
    List<int> articleKeys = articleBox.keys.cast<int>().toList();

    emit(state.copyWith(
        status: BookmarkStatus.standby,
        groupBox: groupBox,
        articleBox: articleBox,
        group: groupKeys,
        article: articleKeys
    ));
  }


  Future<void> _addBookmark(AddBookmark event, Emitter<BookmarkState> emit) async {
    Article article = event.article;
    List<int> articles = state.article.toList(growable: true);

    try {
      state.articleBox!.put(article.pageID, article);
      articles.add(article.pageID);
    } on Error catch (e) {
      ScaffoldMessenger.of(event.context).showSnackBar(showSnackBarError("Artikel ${event.article.title} konnte nicht hinzugefügt werden"));
      return;
    }
    ScaffoldMessenger.of(event.context).showSnackBar(showSnackBarSuccess("Artikel ${event.article.title} konnte hinzugefügt werden"));

    emit(state.copyWith(
        article: articles
    ));
  }

  Future<void> _removeBookmark(RemoveBookmark event, Emitter<BookmarkState> emit) async {
    List<int> articles = state.article.toList(growable: true);

    try {
      state.articleBox!.delete(event.article.pageID);
      articles.remove(event.article.pageID);
    } on Error catch (e) {
      ScaffoldMessenger.of(event.context).showSnackBar(showSnackBarError("Artikel ${event.article.title} konnte nicht entfernt werden"));
      return;
    }
    ScaffoldMessenger.of(event.context).showSnackBar(showSnackBarSuccess("Artikel ${event.article.title} konnte entfernt werden"));

    emit(state.copyWith(
        article: articles
    ));
  }


  Future<void> _addBookmarkGroup(AddBookmarkGroup event, Emitter<BookmarkState> emit) async {
    ArticleGroup articleGroup = event.articleGroup;
    List<int> groups = state.group.toList(growable: true);

    try {
      state.groupBox!.put(articleGroup.groupID, articleGroup);
      groups.add(articleGroup.groupID);
    } on Error catch (e) {
      ScaffoldMessenger.of(event.context).showSnackBar(showSnackBarError("Gruppe ${event.articleGroup.name} konnte nicht erstellt werden"));
      return;
    }
    ScaffoldMessenger.of(event.context).showSnackBar(showSnackBarSuccess("Gruppe ${event.articleGroup.name} konnte erstellt werden"));

    emit(state.copyWith(
        group: groups
    ));
  }

  Future<void> _removeBookmarkGroup(RemoveBookmarkGroup event, Emitter<BookmarkState> emit) async {
    List<int> groups = state.group.toList(growable: true);

    try {
      List<Article> articlesOfGroup = state.articleBox!.values.where((element) => element.group == event.articleGroup.groupID).toList();
      if (event.removeArticles) {
        for (var element in articlesOfGroup) {
          state.articleBox!.delete(element.pageID);
        }
      } else {
        for (var element in articlesOfGroup) {
          state.articleBox!.put(element.pageID, element.copyWith(group: 0));
        }
      }
      state.groupBox!.delete(event.articleGroup.groupID);
      groups.remove(event.articleGroup.groupID);
    } on Error catch (e) {
      ScaffoldMessenger.of(event.context).showSnackBar(showSnackBarError("Gruppe ${event.articleGroup.name} konnte nicht entfernt werden"));
      return;
    }
    ScaffoldMessenger.of(event.context).showSnackBar(showSnackBarSuccess("Gruppe ${event.articleGroup.name} konnte entfernt werden"));

    emit(state.copyWith(
        group: groups
    ));
  }
}