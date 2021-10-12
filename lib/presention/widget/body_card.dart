import 'package:flutter/material.dart';
import 'package:todo_task/data/model/todo_model.dart';

class BodyCard extends StatelessWidget {
  const BodyCard({
    Key key,
    this.todo,
    this.stateTask,
    this.onClick,
    this.colorText,
    this.onSubmitPopUpMenu,
  }) : super(key: key);
  final TodoModel todo;
  final String stateTask;
  final Color colorText;
  final Function(String) onSubmitPopUpMenu;
  final Function() onClick;
  @override
  Widget build(BuildContext context) {
    final List<String> popupMenuData = ['Edit', 'Delete'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: colorText,
                boxShadow: [
                  BoxShadow(
                    color: colorText,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Text(
                stateTask,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: PopupMenuButton(
                onSelected: onSubmitPopUpMenu,
                itemBuilder: (BuildContext context) {
                  return popupMenuData
                      .map(
                        (item) => PopupMenuItem<String>(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList();
                },
              ),
            )
          ],
        ),
        Divider(
          color: Colors.grey.shade400,
        ),
        GestureDetector(
          onTap: onClick,
          child: SizedBox(
            width: double.infinity,
            // height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  todo.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.indigo.shade900,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  todo.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_outlined,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      todo.time,
                      style: TextStyle(
                        color: Colors.indigo.shade900,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.date_range,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      todo.date,
                      style: TextStyle(
                        color: Colors.indigo.shade900,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
