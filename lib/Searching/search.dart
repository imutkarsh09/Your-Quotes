bool binary_Search(List<dynamic> sortedList, String value) {
  int min = 0;
  int max = sortedList.length;
  while (min < max) {
    final int mid = min + ((max - min) >> 1);
    final String element = sortedList[mid];
    final int comp = element.compareTo(value);
    if (comp == 0) {
      return true;
    }
    if (comp < 0) {
      min = mid + 1;
    } else {
      max = mid;
    }
  }
  return false;
}
