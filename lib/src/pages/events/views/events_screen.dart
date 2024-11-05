import '../../../../generated/locales.g.dart';
import 'widgets/dialog_item.dart';
import 'widgets/my_drawer_button.dart';
import 'widgets/event_widget.dart';
import '../controllers/events_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventsScreen extends GetView<EventsController> {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: _drawer(),
        body: Obx(() => _pageContent()),
      ),
    );
  }

  Widget _pageContent() {
    if (controller.isLoading.value) {
      return _loading();
    }
    if (controller.isRetry.value) {
      return _retry();
    }
    return _body();
  }

  Widget _retry() {
    return Center(
      child: IconButton(
        onPressed: controller.getUserById,
        icon: const Icon(Icons.replay_circle_filled_outlined),
        color: const Color(0xFF2B4D3E),
      ),
    );
  }

  Widget _loading() {
    return const Center(
      child: CircularProgressIndicator(
        color: Color(0xFF2B4D3E),
      ),
    );
  }

  Widget _body() {
    return CustomScrollView(
      slivers: [
        _sliverAppBar(),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
        _events(),
      ],
    );
  }

  Widget _drawer() => Container(
        width: 250,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              MyDrawerButton(
                title: LocaleKeys.event_managment_app_events_page_my_events.tr,
                icon: Icons.event_outlined,
                onTap: controller.onMyEvents,
              ),
              MyDrawerButton(
                title: LocaleKeys.event_managment_app_events_page_bookmarks.tr,
                icon: Icons.bookmark_added_outlined,
                onTap: controller.onBookmarks,
              ),
              const Spacer(),
              MyDrawerButton(
                title: LocaleKeys.event_managment_app_events_page_settings.tr,
                icon: Icons.settings_outlined,
                onTap: controller.onSetting,
              ),
            ],
          ),
        ),
      );

  Widget _events() {
    return Obx(
      () => (controller.isSearch.value)
          ? SliverToBoxAdapter(child: _loading())
          : SliverList.separated(
              itemCount: controller.events.length,
              itemBuilder: (_, index) => EventWidget(
                event: controller.events[index],
                bookmarked: controller.bookmarkedEvents,
                onView: () =>
                    controller.onViewEvent(controller.events[index].id),
                onBookmark: () =>
                    controller.onBookmark(controller.events[index].id),
              ),
              separatorBuilder: (_, __) => const SizedBox(height: 12),
            ),
    );
  }

  Widget _sliverAppBar() {
    return SliverAppBar(
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(
            LocaleKeys.event_managment_app_events_page_events.tr,
            style: const TextStyle(
              fontSize: 24,
              color: Color(0xFF1F322A),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(child: _searchBar()),
          const SizedBox(width: 36),
          // Obx(() => _openDialog()),
        ],
      ),
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
        hintText: LocaleKeys.event_managment_app_events_page_search.tr,
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
          () => Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: Get.back,
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    LocaleKeys.event_managment_app_events_page_back.tr,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              DialogItem(
                isActive: controller.isLimited.value,
                onChanged: (v) => controller.isLimited.toggle(),
                title:
                    LocaleKeys.event_managment_app_events_page_price_limit.tr,
              ),
              _slider(),
              Text(limitation),
              const SizedBox(height: 6),
              DialogItem(
                isActive: controller.isFilled.value,
                onChanged: (v) => controller.isFilled.toggle(),
                title: LocaleKeys.event_managment_app_events_page_not_filled.tr,
              ),
              const SizedBox(height: 6),
              DialogItem(
                isActive: controller.isExpired.value,
                onChanged: (v) => controller.isExpired.toggle(),
                title:
                    LocaleKeys.event_managment_app_events_page_not_expired.tr,
              ),
              const SizedBox(height: 6),
              DialogItem(
                isActive: controller.isSort.value,
                onChanged: (v) => controller.isSort.toggle(),
                title:
                    LocaleKeys.event_managment_app_events_page_sort_by_date.tr,
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
        child: Text(
          LocaleKeys.event_managment_app_events_page_filter.tr,
          style: const TextStyle(
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
        child: Text(
          LocaleKeys.event_managment_app_events_page_reset.tr,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFFF6FFF8),
          ),
        ),
      ),
    );
  }

  String get limitation {
    return '${LocaleKeys.event_managment_app_events_page_from.tr} ${controller.minPrice} ${LocaleKeys.event_managment_app_events_page_to.tr} ${controller.maxPrice}';
  }
}
