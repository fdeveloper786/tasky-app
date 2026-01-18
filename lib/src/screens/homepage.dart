import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky/src/controller/task_controller.dart';
import 'package:tasky/src/utils/app_icon_type.dart';
import 'package:tasky/src/utils/strings.dart';
import 'package:tasky/src/utils/text_styles.dart';
import 'package:tasky/src/widgets/app_icon.dart';
import 'package:tasky/src/widgets/custom_buttom_sheet.dart';
import 'package:tasky/src/widgets/custom_text.dart';
import 'task_list_by_date_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const CustomText(
          text: appName,
          textStyle: kTitleStyle,
        ),
        centerTitle: true,
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [Color(0xFF6A5AE0), Color(0xFF8F7CFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ]),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () => _showAddTaskSheet(context),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(() {
        final grouped = controller.groupedTasks();
        final dates = grouped.keys.toList()..sort();

        if (dates.isEmpty) return const Center(child: CustomText(text: noTask));

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.1,
          ),
          itemCount: dates.length,
          itemBuilder: (_, index) {
            final date = dates[index];
            final tasks = grouped[date]!;

            return InkWell(
              onTap: () {
                Get.to(() => TaskListByDatePage(date: date));
              },
              child: Card(
                elevation: 5,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppIcon(
                        type: AppIconType.calendarMonth,
                        size: 34,
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: "${date.day}-${date.month}-${date.year}",
                        textStyle: kBold16Style,
                      ),
                      const SizedBox(height: 6),
                      CustomText(text: taskLength(tasks.length)),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _showAddTaskSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (_) => const CustomBottomSheet(),
    );
  }
}
