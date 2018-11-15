import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/main_button.dart';
import '../widgets/main_calendar.dart';

import '../dialogs/dialogs.dart';

import '../routes/default_page_route.dart';

import '../../models/api/genre.dart';

import '../../resources/app_colors.dart';
import '../../resources/translations.dart';

import '../../helpers/api/main_api.dart';
import '../../helpers/storage/filters/dates_filter.dart';

class DatesFilterDialog extends StatefulWidget  {
  DatesFilter filter;

  Function (DatesFilter) onSave;

  DatesFilterDialog({this.filter, this.onSave});

  @override
  DatesFilterDialogState createState() => DatesFilterDialogState();
}

class DatesFilterDialogState extends State<DatesFilterDialog> {

  DatesFilter result;

  List<DateTime> selectedDates = [];
  

  void initState(){
    super.initState();

    result = DatesFilter();

    if (widget.filter.dateFrom != null){
      selectedDates.add(widget.filter.dateFrom);
    }
    if (widget.filter.dateTo != null){
      selectedDates.add(widget.filter.dateTo);      
    }

    if (selectedDates.isNotEmpty){
       update(selectedDates.last);
    }
  }

  void onSelect(DateTime date){
    setState(() {      
      update(date);
    });
  }

  void update(DateTime date){
    if (selectedDates.isEmpty){
        selectedDates = [date];
        result.dateFrom = date;
        result.dateTo = date;
      } else if (selectedDates.length == 1 && selectedDates.first == date){
        selectedDates.clear();
        result = DatesFilter();
      } else {
        DateTime min = selectedDates.first;
        DateTime max = selectedDates.last;

        int diff = date.difference(min).inDays;

        if (diff > 0){
          max = date;
          selectedDates = [min, date];
        } else if (diff < 0){
          min = date;
          selectedDates = [date, max];
        } else {
          min = date;
          max = date;
          selectedDates = [date];
        }
        
        int days = max.difference(min).inDays.abs();
        for (int i = 1; i < days; i++){
          selectedDates.add(min.add(Duration(days: i)));
        }
        selectedDates.sort();
        result.dateFrom = min;
        result.dateTo = max;
      }
  }

  @override 
  Widget build(BuildContext ctx){
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      decoration: BoxDecoration(
        color: AppColors.dialogBg,
        borderRadius: BorderRadius.all(Radius.circular(5.0))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MainCalendar(
            selectedDateTime: selectedDates,
            onDayPressed: onSelect,
            height: MediaQuery.of(context).size.height * 0.52, 
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
            width: MediaQuery.of(context).size.width * 1.0,
            height: 40.0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: MainButton(Translations.save.toUpperCase(),
                onTap: (){
                  Navigator.pop(context);     
                  if (widget.onSave != null){
                    widget.onSave(result);
                  }
                },
              )
            )
          )
        ],
      )
    );
  }
}