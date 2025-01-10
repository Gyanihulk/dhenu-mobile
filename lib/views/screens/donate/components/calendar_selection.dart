import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';

class DonationFrequency extends StatefulWidget {
  final Function(String) onNameChange;
  final String? donorName;
  final Function(double) onAmountChange;
  final double donationPerDay;
  final Function(String, dynamic) onConfirm;

  const DonationFrequency({
    super.key,
    required this.onNameChange,
    required this.onAmountChange,
    this.donorName,
    this.donationPerDay = 500, // Default donation per day
    required this.onConfirm,
  });

  @override
  _DonationFrequency createState() => _DonationFrequency();
}

class _DonationFrequency extends State<DonationFrequency> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Set<DateTime> _selectedDates = {};
  String _selectedFilter = "single";
  TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.donorName ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    double totalDonation = _selectedDates.length * widget.donationPerDay;

    // Update the parent with the total amount
    widget.onAmountChange(totalDonation);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filters
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              const filters = [
                "Single",
                "Daily",
                "Weekly",
                "Monthly",
                "Yearly",
                "Custom"
              ];
              final filter = filters[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedFilter = filter;
                    _selectedDates.clear(); // Reset dates on filter change
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:
                        _selectedFilter == filter ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Text(
                    filter,
                    style: TextStyle(
                      color: _selectedFilter == filter
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          // Calendar
          NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollStartNotification ||
                  notification is ScrollUpdateNotification) {
                Scrollable.ensureVisible(
                    context); // Ensure parent handles scroll
              }
              return false; // Let the calendar handle its gestures too
            },
            child: TableCalendar(
              firstDay: DateTime(2020, 1, 1),
              lastDay: DateTime(2050, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return _selectedDates.any((selectedDate) =>
                    selectedDate.year == day.year &&
                    selectedDate.month == day.month &&
                    selectedDate.day == day.day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                  if (selectedDay.isBefore(
                      DateTime.now().subtract(const Duration(days: 1)))) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(localization.translate("donate_screen.past_date_error")!),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    return;
                  }
                  if (_selectedFilter == "Custom") {
                    if (_selectedDates.contains(selectedDay)) {
                      _selectedDates.remove(selectedDay);
                    } else {
                      _selectedDates.add(selectedDay);
                    }
                  } else {
                    if (_selectedDates.isEmpty) {
                      _selectedDates.add(selectedDay);
                      _applyFilter(selectedDay);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(localization
                              .translate("donate_screen.single_date_error")!
                              .replaceFirst("{filter}", _selectedFilter)),
                        ),
                      );
                    }
                  }
                  widget.onConfirm(_selectedFilter, _selectedDates.toList());
                });
              },
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.yellow,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Name Input
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: localization.translate("donate_screen.donation_in_name_of"),
              border: const OutlineInputBorder(),
            ),
            onChanged: widget.onNameChange,
          ),
          const SizedBox(height: 10),
          // Total Amount Display
          Text(
            localization.translate("donate_screen.total_donation")!,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            "₹ ${totalDonation.toStringAsFixed(2)}",
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.green),
          ),
        ],
      ),
    );
  }

  void _applyFilter(DateTime selectedDay) {
    // Clear the existing dates to avoid duplicates
    _selectedDates.clear();
    if (selectedDay
        .isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!
              .translate("donate_screen.past_date_error")!),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }
    switch (_selectedFilter) {
      case "Daily":
        _selectedDates.addAll(
            List.generate(30, (i) => selectedDay.add(Duration(days: i))));
        break;

      case "Weekly":
        for (int i = 0; i < 4; i++) {
          _selectedDates.add(selectedDay.add(Duration(days: i * 7)));
        }
        break;

      case "Monthly":
        for (int i = 0; i < 12; i++) {
          DateTime dateInNextMonth = DateTime(
              selectedDay.year, selectedDay.month + i, selectedDay.day);
          _selectedDates.add(dateInNextMonth);
        }
        break;

      case "Yearly":
        for (int i = 0; i < 10; i++) {
          DateTime dateInNextYear = DateTime(
              selectedDay.year + i, selectedDay.month, selectedDay.day);
          _selectedDates.add(dateInNextYear);
        }
        break;

      default:
        _selectedDates.add(selectedDay);
        break;
    }

    print("Filter Applied: $_selectedFilter, Dates: $_selectedDates");
  }
}
