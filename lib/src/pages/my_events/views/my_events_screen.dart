import '../../../../generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/my_events_controller.dart';
import 'widgets/custom_dialog.dart';
import 'widgets/my_event_widget.dart';

class MyEventsScreen extends GetView<MyEventsController> {
  const MyEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: _fab(),
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
        onPressed: controller.getMyEvents,
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

  Widget _fab() {
    return FloatingActionButton(
      backgroundColor: const Color(0xFF2B4D3E),
      shape: const CircleBorder(),
      onPressed: controller.addEvent,
      child: const Icon(Icons.add, color: Colors.white),
    );
  }

  Widget _events() {
    return Obx(
      () => (controller.isSearch.value)
          ? SliverToBoxAdapter(child: _loading())
          : SliverList.separated(
              itemCount: controller.myEvents.length,
              itemBuilder: (_, index) => MyEventWidget(
                event: controller.myEvents[index],
                onRemove: () =>
                    controller.onRemove(eventId: controller.myEvents[index].id),
                onEdit: () =>
                    controller.onEdit(eventId: controller.myEvents[index].id),
                removeLoading: controller.removeLoadings,
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
          Text(
            LocaleKeys.event_managment_app_my_event_page_my_events.tr,
            style: const TextStyle(
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
        hintText: LocaleKeys.event_managment_app_my_event_page_search.tr,
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
