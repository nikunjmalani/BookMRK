import 'package:bookmrk/model/home_page_model.dart';
import 'package:flutter/cupertino.dart';

class FilterCategoryProvider extends ChangeNotifier {

  /// list of all subjects to pass in AllSubject class...
  List<Subject> _allFilterSubjectsList = [];

  List<Subject> get allFilterSubjectsList => _allFilterSubjectsList;

  set allFilterSubjectsList(List<Subject> value) {
    _allFilterSubjectsList = value;
    notifyListeners();
  }

  /// selected subject slug....
  String _selectedFilterCategorySubjectSlug;

  String get selectedFilterCategorySubjectSlug =>
      _selectedFilterCategorySubjectSlug;

  set selectedFilterCategorySubjectSlug(String value) {
    _selectedFilterCategorySubjectSlug = value;
    notifyListeners();
  }

  /// selected class slug.....
  String _selectedFilterCategoryClassSlug;

  String get selectedFilterCategoryClassSlug =>
      _selectedFilterCategoryClassSlug;

  set selectedFilterCategoryClassSlug(String value) {
    _selectedFilterCategoryClassSlug = value;
    notifyListeners();
  }


  /// list of all the publishers to pass in the filter category page...
  List<Publisher> _allPublisherList = [];

  List<Publisher> get allPublisherList => _allPublisherList;

  set allPublisherList(List<Publisher> value) {
    _allPublisherList = value;
    notifyListeners();
  }

  /// selected publisher slug....
  String _selectedFilterCategoryPublisherSlug;

  String get selectedFilterCategoryPublisherSlug =>
      _selectedFilterCategoryPublisherSlug;

  set selectedFilterCategoryPublisherSlug(String value) {
    _selectedFilterCategoryPublisherSlug = value;
    notifyListeners();
  }
}
