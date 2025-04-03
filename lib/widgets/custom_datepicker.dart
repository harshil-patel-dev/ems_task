import 'package:ems_task/core/utils/app_export.dart';
import 'package:ems_task/features/employee_details/models/quickdate_model.dart';
import 'package:ems_task/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final List<QuickDateOption>? quickDateOptions;

  const CustomDatePicker({
    super.key,
    required this.onDateSelected,
    this.quickDateOptions,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime _selectedDate = DateTime.now();
  DateTime _currentMonth = DateTime.now();

  @override
  void initState() {
    super.initState();

    // Set initially selected date if any option is selected
    if (widget.quickDateOptions != null) {
      for (var option in widget.quickDateOptions!) {
        if (option.isSelected) {
          _selectedDate = option.getDate();
          _currentMonth = DateTime(_selectedDate.year, _selectedDate.month);
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Quick date options
          if (widget.quickDateOptions != null &&
              widget.quickDateOptions!.isNotEmpty) ...[
            ..._buildQuickDateOptionsRows(),
            const SizedBox(height: 16),
          ],

          // Month navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.arrow_left_rounded,
                  size: 36,
                  color: AppColors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _currentMonth = DateTime(
                      _currentMonth.year,
                      _currentMonth.month - 1,
                    );
                  });
                },
              ),
              Text(
                DateFormat('MMMM yyyy').format(_currentMonth),
                style: AppStyles.title(),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.arrow_right_rounded,
                  size: 36,
                  color: AppColors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _currentMonth = DateTime(
                      _currentMonth.year,
                      _currentMonth.month + 1,
                    );
                  });
                },
              ),
            ],
          ),

          // Weekday headers
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
                  ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                      .map(
                        (day) => SizedBox(
                          width: 40,
                          child: Text(day, textAlign: TextAlign.center),
                        ),
                      )
                      .toList(),
            ),
          ),

          // Calendar grid
          _buildCalendarGrid(),

          // Selected date display and save button
          Container(
            margin: const EdgeInsets.only(top: 16.0),
            padding: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.greyLight, width: 1.0),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  DateFormat('d MMM yyyy').format(_selectedDate),
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                CustomButton(
                  type: ButtonType.secondary,
                  text: AppStrings.cancel,
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 12),
                CustomButton(
                  type: ButtonType.primary,
                  text: AppStrings.save,
                  onPressed: () {
                    widget.onDateSelected(_selectedDate);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Build rows of quick date options with 2 options per row
  List<Widget> _buildQuickDateOptionsRows() {
    final List<Widget> rows = [];
    final options = widget.quickDateOptions!;

    for (int i = 0; i < options.length; i += 2) {
      final rowOptions = options.skip(i).take(2).toList();

      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Row(
            children:
                rowOptions.map((option) {
                  final isSelected = _isDateEqual(
                    option.getDate(),
                    _selectedDate,
                  );

                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: option != rowOptions.last ? 8.0 : 0.0,
                      ),
                      child: CustomButton(
                        type:
                            isSelected
                                ? ButtonType.primary
                                : ButtonType.secondary,
                        text: option.text,
                        onPressed: () => _selectQuickDate(option.getDate()),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
      );
    }

    return rows;
  }

  bool _isDateEqual(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Widget _buildCalendarGrid() {
    final daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;

    final firstDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month,
      1,
    );
    final firstWeekdayOfMonth = firstDayOfMonth.weekday % 7; // 0-6, Sunday is 0

    final days = List<Widget>.generate(firstWeekdayOfMonth + daysInMonth, (
      index,
    ) {
      if (index < firstWeekdayOfMonth) {
        return const SizedBox(width: 40, height: 40);
      }

      final day = index - firstWeekdayOfMonth + 1;
      final date = DateTime(_currentMonth.year, _currentMonth.month, day);
      final isSelected =
          _selectedDate.year == date.year &&
          _selectedDate.month == date.month &&
          _selectedDate.day == date.day;
      final isToday =
          DateTime.now().year == date.year &&
          DateTime.now().month == date.month &&
          DateTime.now().day == date.day;

      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedDate = date;
          });
        },
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: isToday ? AppColors.primary : Colors.transparent,
              ),
              shape: BoxShape.circle,
              color: isSelected ? AppColors.primary : Colors.transparent,
            ),
            child: Text(
              day.toString(),
              style: TextStyle(
                fontSize: 15,

                color:
                    isSelected
                        ? Colors.white
                        : isToday
                        ? AppColors.primary
                        : null,
                fontWeight: isSelected || isToday ? FontWeight.bold : null,
              ),
            ),
          ),
        ),
      );
    });

    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 6,
      runSpacing: 6,
      children: days,
    );
  }

 

  void _selectQuickDate(DateTime date) {
    setState(() {
      _selectedDate = date;
      _currentMonth = DateTime(date.year, date.month);
    });
  }
}
