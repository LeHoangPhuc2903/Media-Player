import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/presentation/navigation/routes.dart';
import 'package:media_player/presentation/widgets/component/bottom_nav_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _allItems = []; // Danh sách tất cả dữ liệu giả lập
  List<String> _filteredItems = []; // Dữ liệu được lọc

  @override
  void initState() {
    super.initState();
    _allItems = List.generate(20, (index) => 'Item $index'); // Dữ liệu mẫu
    _filteredItems = _allItems;
  }

  void _onSearchChanged(String query) {
    // Lọc dữ liệu theo từ khóa tìm kiếm
    setState(() {
      if (query.isEmpty) {
        _filteredItems = _allItems;
      } else {
        _filteredItems = _allItems
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm kiếm'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Thanh nhập tìm kiếm
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                labelText: 'Tìm',
                hintText: 'Nhập từ khóa...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          // Hiển thị kết quả
          Expanded(
            child: _filteredItems.isEmpty
                ? const Center(
                    child: Text(
                      'Không tìm thấy kết quả',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_filteredItems[index]),
                        onTap: () {
                          // Xử lý khi chọn item
                          Get.snackbar(
                            'Item Selected',
                            _filteredItems[index],
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: 1, // Index của tab "Search"
        onTabSelected: (index) {
          switch (index) {
            case 0:
              Get.offAllNamed(Routes.home); // Điều hướng về HomePage
              break;
            case 1:
              break; // Tab hiện tại, không cần điều hướng
            case 2:
              Get.offAllNamed(Routes.profile); // Điều hướng về ProfilePage
              break;
          }
        },
      ),
    );
  }
}
