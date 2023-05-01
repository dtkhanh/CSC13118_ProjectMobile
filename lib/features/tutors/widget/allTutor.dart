import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AllTutorView extends StatefulWidget {
  const AllTutorView({Key? key}) : super(key: key);

  @override
  State<AllTutorView> createState() => _AllTutorViewStage();

}

class _AllTutorViewStage extends State<AllTutorView> {
  int chosenFilter = 0;
  static const int _pageSize = 10;
  final PagingController<int, String> _pagingController =
  PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final items = List.generate(
          _pageSize,
              (index) => 'Item ${(pageKey ) }');
      final isLastPage = pageKey == 5;
      if (isLastPage) {
        _pagingController.appendLastPage(items);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(items, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagedListView<int, String>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<String>(
          itemBuilder: (context, item, index) => ListTile(
            title: Text(item),
          ),
        ),
      ),
    );
  }

}