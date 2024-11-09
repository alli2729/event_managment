import 'widgets/custom_dialog.dart';
import '../../../../generated/locales.g.dart';
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
        body: Center(
          child: SizedBox(
            width: width(context),
            child: Obx(() => _pageContent()),
          ),
        ),
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
        onPressed: () => controller.showDialog(_dialog),
        icon: const Icon(Icons.menu),
      ),
    );
  }

  Widget get _dialog => const CustomDialog();

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

  double pageWidth(BuildContext context) => MediaQuery.sizeOf(context).width;
  double pageHeight(BuildContext context) => MediaQuery.sizeOf(context).height;
  double width(BuildContext context) =>
      (pageWidth(context) > 800) ? 800 : double.infinity;
}
