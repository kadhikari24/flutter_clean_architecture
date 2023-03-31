extension ListExtension<E, T> on List<T> {

  Iterable<E> mapIndex<E>(E Function(int index, T element) callback) {
    return asMap()
        .map((i, element) => MapEntry(i, callback(i, element)))
        .values;
  }
}
