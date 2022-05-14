import 'package:flutter/foundation.dart' show immutable;
import 'package:testingrxdart_course/models/thing.dart';

@immutable
abstract class SearchResult {
  const SearchResult();
}

@immutable
class SearchResultLoading implements SearchResult {
  const SearchResultLoading();
}

@immutable
class SearchResultNoResult implements SearchResult {
  const SearchResultNoResult();
}

@immutable
class SearchResultHasError implements SearchResult {
  final Object error;
  const SearchResultHasError(this.error);
}

@immutable
class SearchResultWithResults implements SearchResult {
  final List<Thing> results;
  const SearchResultWithResults(this.results);
}
