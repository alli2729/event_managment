import '../controllers/bookmark_event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/dialog_item.dart';
import 'widgets/bookmark_event_widget.dart';

class BookmarkEventScreen extends GetView<BookmarkEventController> {
  const BookmarkEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            _sliverAppBar(),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            _events(),
          ],
        ),
      ),
    );
  }

  Widget _events() {
    return Obx(
      () => SliverList.separated(
        itemCount: controller.bookmarkedEvents.length,
        itemBuilder: (_, index) => BookmarkEventWidget(
          event: controller.bookmarkedEvents[index],
          bookmarked: controller.bookmarkedEvents,
          onBookmark: () => controller.onBookmark(
            eventId: controller.bookmarkedEvents[index].id,
          ),
          onView: () {},
        ),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
      ),
    );
  }

  Widget _sliverAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      snap: false,
      floating: true,
      toolbarHeight: 50,
      surfaceTintColor: const Color(0xFFEAF4F4),
      backgroundColor: const Color(0xFFEAF4F4),
      flexibleSpace: FlexibleSpaceBar(
        background: _appBar(),
      ),
    );
  }

  Widget _appBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          _backButton(),
          const SizedBox(width: 12),
          const Text(
            'Bookmarks',
            style: TextStyle(
              fontSize: 24,
              color: Color(0xFF1F322A),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(child: _searchBar()),
          // const SizedBox(width: 36),
        ],
      ),
    );
  }

  Widget _backButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: Get.back,
      child: const Icon(Icons.arrow_back),
    );
  }

  Widget _dialogButton() {
    return Badge(
      alignment: const Alignment(0.5, -0.6),
      smallSize: 10,
      isLabelVisible: controller.filtered.value,
      child: IconButton(
        onPressed: () => controller.showDialog(dialog),
        icon: const Icon(Icons.menu),
      ),
    );
  }

  Widget _searchBar() {
    return TextField(
      onChanged: controller.onSearch,
      controller: controller.searchController,
      decoration: InputDecoration(
        hintText: 'Search',
        isDense: true,
        contentPadding: const EdgeInsets.all(8),
        suffixIcon: Obx(() => _dialogButton()),
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget get dialog {
    return Dialog(
      backgroundColor: const Color(0xFFF6FFF8),
      insetPadding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Obx(
          () => SizedBox(
            height: 350,
            width: 400,
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: Get.back,
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 6),
                    const Text('Back', style: TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 12),
                DialogItem(
                  isActive: controller.isLimited.value,
                  onChanged: (v) => controller.isLimited.toggle(),
                  title: 'Price Limitaition',
                ),
                _slider(),
                Text('from ${controller.minPrice} to ${controller.maxPrice}'),
                const SizedBox(height: 6),
                DialogItem(
                  isActive: controller.isFilled.value,
                  onChanged: (v) => controller.isFilled.toggle(),
                  title: 'not Filled',
                ),
                const SizedBox(height: 6),
                DialogItem(
                  isActive: controller.isExpired.value,
                  onChanged: (v) => controller.isExpired.toggle(),
                  title: 'not Expired',
                ),
                const SizedBox(height: 6),
                DialogItem(
                  isActive: controller.isSort.value,
                  onChanged: (v) => controller.isSort.toggle(),
                  title: 'Sort By Date',
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _resetButton(),
                    const SizedBox(width: 6),
                    _fillterButton(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _slider() {
    return RangeSlider(
      activeColor: const Color(0xFF2B4D3E),
      divisions: 500,
      min: controller.min,
      max: controller.max,
      values: controller.priceLimits.value,
      onChanged:
          (controller.isLimited.value) ? controller.onPriceChanged : null,
    );
  }

  Widget _fillterButton() {
    return GestureDetector(
      onTap: () => Get.back(result: true),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFF6B9080),
        ),
        child: const Text(
          'Filter',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFF6FFF8),
          ),
        ),
      ),
    );
  }

  Widget _resetButton() {
    return GestureDetector(
      onTap: controller.onResetFilters,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFFF48C8C),
        ),
        child: const Text(
          'Reset',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFF6FFF8),
          ),
        ),
      ),
    );
  }

}
