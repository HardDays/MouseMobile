import 'package:flutter/material.dart';

import 'package:intl/intl.dart' show DateFormat;

import '../../resources/app_colors.dart';

class MainCalendar extends StatefulWidget {
  final TextStyle defaultHeaderTextStyle = TextStyle(
    fontSize: 14.0,
    color: Colors.white,
  );
  final TextStyle defaultPrevDaysTextStyle = TextStyle(
    color: Colors.grey,
    fontSize: 16.0,
  );
  final TextStyle defaultNextDaysTextStyle = TextStyle(
    color: Colors.grey,
    fontSize: 16.0,
  );
  final TextStyle defaultDaysTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16.0,
  );
  final TextStyle defaultTodayTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16.0,
  );
  final TextStyle defaultSelectedDayTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16.0,
  );
  final TextStyle defaultWeekdayTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 14.0,
  );
  final TextStyle defaultWeekendTextStyle = TextStyle(
    color: Colors.pinkAccent,
    fontSize: 16.0,
  );

  final List<String> weekDays;
  final double viewportFraction;
  final TextStyle prevDaysTextStyle;
  final TextStyle daysTextStyle;
  final TextStyle nextDaysTextStyle;
  final Color prevMonthDayBorderColor;
  final Color thisMonthDayBorderColor;
  final Color nextMonthDayBorderColor;
  final double dayPadding;
  final double height;
  final double width;
  final TextStyle todayTextStyle;
  final Color dayButtonColor;
  final Color todayBorderColor;
  final Color todayButtonColor;
  final List<DateTime> selectedDateTime;
  final TextStyle selectedDayTextStyle;
  //final Color selectedDayButtonColor;
  //final Color selectedDayBorderColor;
  final bool daysHaveCircularBorder;
  final Function(DateTime) onDayPressed;
  final TextStyle weekdayTextStyle;
  final Color iconColor;
  final TextStyle headerTextStyle;
  final Widget headerText;
  final TextStyle weekendTextStyle;
  final List<DateTime> markedDates;
  final Color markedDateColor;
  final Widget markedDateWidget;
  final EdgeInsets headerMargin;
  final double childAspectRatio;
  final EdgeInsets weekDayMargin;


//  If true then picking two dates will select all days between those days
  final bool isIntervalSelectable;

  MainCalendar({
    this.weekDays = const ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'],
    this.viewportFraction = 1.0,
    this.prevDaysTextStyle,
    this.daysTextStyle,
    this.nextDaysTextStyle,
    this.prevMonthDayBorderColor = Colors.transparent,
    this.thisMonthDayBorderColor = Colors.transparent,
    this.nextMonthDayBorderColor = Colors.transparent,
    this.dayPadding = 2.0,
    this.height = double.infinity,
    this.width = double.infinity,
    this.todayTextStyle,
    this.dayButtonColor = Colors.transparent,
    this.todayBorderColor = Colors.red,
    this.todayButtonColor = Colors.red,
    this.selectedDateTime,
    this.selectedDayTextStyle,
    //this.selectedDayBorderColor = Colors.green,
    //this.selectedDayButtonColor = Colors.green,
    this.daysHaveCircularBorder,
    this.onDayPressed,
    this.weekdayTextStyle,
    this.iconColor = Colors.grey,
    this.headerTextStyle,
    this.headerText,
    this.weekendTextStyle,
    this.markedDates,
    @deprecated this.markedDateColor,
    this.markedDateWidget,
    this.headerMargin = const EdgeInsets.symmetric(vertical: 16.0),
    this.childAspectRatio = 1.0,
    this.weekDayMargin = const EdgeInsets.only(bottom: 4.0),
    this.isIntervalSelectable
  }){

  }

  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<MainCalendar> {
  PageController _controller;
  List<DateTime> _dates = List(3);
  int _startWeekday = 0;
  int _endWeekday = 0;



  @override
  initState() {
    super.initState();

    /// setup pageController
    _controller = PageController(
      initialPage: 1,
      keepPage: true,
      viewportFraction: widget.viewportFraction,

      /// width percentage
    );
    this.setDate();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 3.0, left: 0.0, right: 0.0),
            child: DefaultTextStyle(
              style: widget.headerTextStyle != null
                  ? widget.headerTextStyle
                  : widget.defaultHeaderTextStyle,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () => setDate(page: 0),
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: widget.iconColor,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                         '${DateFormat.MMMM().format(this._dates[0]).toUpperCase().substring(0, 3)}  ${DateFormat.y().format(this._dates[0])}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 14.0
                          ),
                        ),
                        Text(
                          '${DateFormat.MMMM().format(this._dates[1]).toUpperCase().substring(0, 3)}  ${DateFormat.y().format(this._dates[1])}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0
                          ),
                        ),
                        Text(
                          '${DateFormat.MMMM().format(this._dates[2]).toUpperCase().substring(0, 3)}  ${DateFormat.y().format(this._dates[2])}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 14.0
                          ),
                        ),
                      ] 
                    ), 
                  ),
                  IconButton(
                    onPressed: () => setDate(page: 2),
                    icon: Icon(
                      Icons.keyboard_arrow_right,
                      color: widget.iconColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: widget.weekDays == null
                ? Container()
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: this.renderWeekDays(),
            ),
          ),
          Expanded(
            child: PageView.builder(
              itemCount: 3,
              onPageChanged: (value) {
                this.setDate(page: value);
              },
              controller: _controller,
              itemBuilder: (context, index) {
                return builder(index);
              },
              pageSnapping: true,
            ),
          ),
        ],
      ),
    );
  }

  builder(int slideIndex) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    int totalItemCount = DateTime(
      this._dates[slideIndex].year,
      this._dates[slideIndex].month + 1,
      0,
    ).day +
        this._startWeekday +
        (7 - this._endWeekday);
    int year = this._dates[slideIndex].year;
    int month = this._dates[slideIndex].month;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double value = 1.0;
        if (_controller.position.haveDimensions) {
          value = _controller.page - slideIndex;
          value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);
        }

        return Center(
          child: SizedBox(
            height: Curves.easeOut.transform(value) * widget.height,
            width: Curves.easeOut.transform(value) * screenWidth,
            child: child,
          ),
        );
      },
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: GridView.count(
                crossAxisCount: 7,
                childAspectRatio: widget.childAspectRatio,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: List.generate(totalItemCount,
                    /// last day of month + weekday
                        (index) {
                      bool isToday =
                          DateTime
                              .now()
                              .day == index + 1 - this._startWeekday &&
                              DateTime
                                  .now()
                                  .month == month &&
                              DateTime
                                  .now()
                                  .year == year;

                      bool isNotEmptyList =  widget.selectedDateTime != null &&
                          widget.selectedDateTime.length >0;

                      int selectedIndex = selectedDayIndex(year, month, index + 1 - this._startWeekday);
                      bool selectedDay = isNotEmptyList && selectedIndex != -1;

                      bool isPrevMonthDay = index < this._startWeekday;
                      bool isNextMonthDay = index >=
                          (DateTime(year, month + 1, 0).day) +
                              this._startWeekday;

                      bool isThisMonthDay = !isPrevMonthDay && !isNextMonthDay;
                      bool firstDay = isNotEmptyList &&
                          isFirstDay(year, month, index + 1 - this._startWeekday);
                      bool lastDay = isNotEmptyList &&
                          isLastDay(year, month, index + 1 - this._startWeekday);

                      DateTime now = DateTime(year, month, 1);
                      TextStyle textStyle;
                      TextStyle defaultTextStyle;
                      if (isPrevMonthDay) {
                        now = now
                            .subtract(
                            Duration(days: this._startWeekday - index));
                        textStyle = widget.prevDaysTextStyle;
                        defaultTextStyle = widget.defaultPrevDaysTextStyle;
                      } else if (isThisMonthDay) {
                        now = DateTime(
                            year, month, index + 1 - this._startWeekday);
                        textStyle = selectedDay
                            ? widget.selectedDayTextStyle
                            : widget.daysTextStyle;
                        defaultTextStyle = selectedDay
                            ? widget.defaultSelectedDayTextStyle
                            : widget.defaultDaysTextStyle;
                      } else {
                        now = DateTime(
                            year, month, index + 1 - this._startWeekday);
                        textStyle = widget.nextDaysTextStyle;
                        defaultTextStyle = widget.defaultNextDaysTextStyle;
                      }
                      return GestureDetector(
                        onTap: (){
                          if (isThisMonthDay){
                            widget.onDayPressed(DateTime(
                                year, month, index + 1 - this._startWeekday));
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 7.0, bottom: 7.0),
                          child: Container(
                            decoration: getShape(isFist: firstDay, isLast: lastDay, index: selectedIndex), /*BoxDecoration(
                              border: getShape(isFist: firstDay, isLast: lastDay)
                              gradient: selectedDay ? LinearGradient(
                                colors: [
                                  AppColors.redLeftGradButton,
                                  AppColors.redRightGradButton
                                ]
                              ) : LinearGradient(
                                colors:[
                                  Colors.transparent,
                                  Colors.transparent
                                ]
                              )
                            ),*/
                            child: Container(
                              color:  Colors.transparent,
                              /*onPressed: (){
                                if (isThisMonthDay){
                                  widget.onDayPressed(DateTime(
                                      year, month, index + 1 - this._startWeekday));
                                }
                              },*/
                              child: Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  Center(
                                    child: DefaultTextStyle(
                                      style: (index % 7 == 0 || index % 7 == 6) &&
                                          !selectedDay ? defaultTextStyle : defaultTextStyle,
                                      child: Text(
                                        '${now.day}',
                                        style: (index % 7 == 0 || index % 7 == 6) &&
                                            !selectedDay ?textStyle : textStyle,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
    //                              _renderMarked(now),
                                ],
                              ),
                            ),
                          )
                        )
                      );
                    }
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setDate({
    int page,
  }) {
    if (page == null) {
      /// setup dates
      DateTime date0 =
      DateTime(DateTime
          .now()
          .year, DateTime
          .now()
          .month - 1, 1);
      DateTime date1 = DateTime(DateTime
          .now()
          .year, DateTime
          .now()
          .month, 1);
      DateTime date2 =
      DateTime(DateTime
          .now()
          .year, DateTime
          .now()
          .month + 1, 1);

      this.setState(() {
        /// setup current day
        _startWeekday = date1.weekday;
        _endWeekday = date2.weekday;
        this._dates = [
          date0,
          date1,
          date2,
        ];
      });
    } else if (page == 1) {
      return;
    } else {
      List<DateTime> dates = this._dates;
      if (page == 0) {
        dates[2] = DateTime(dates[0].year, dates[0].month + 1, 1);
        dates[1] = DateTime(dates[0].year, dates[0].month, 1);
        dates[0] = DateTime(dates[0].year, dates[0].month - 1, 1);
        page = page + 1;
      } else if (page == 2) {
        dates[0] = DateTime(dates[2].year, dates[2].month - 1, 1);
        dates[1] = DateTime(dates[2].year, dates[2].month, 1);
        dates[2] = DateTime(dates[2].year, dates[2].month + 1, 1);
        page = page - 1;
      }

      this.setState(() {
        _startWeekday = dates[page].weekday;
        _endWeekday = dates[page + 1].weekday;
        this._dates = dates;
      });

      _controller.animateToPage(page,
          duration: Duration(milliseconds: 1), curve: Threshold(0.0));
    }
  }

  List<Widget> renderWeekDays() {
    List<Widget> list = [];
    for (var weekDay in widget.weekDays) {
      list.add(
        Expanded(
            child: Container(
              margin: EdgeInsets.only(
                  bottom: (MediaQuery.of(context).size.height * .0165)),
              child: Center(
                child: DefaultTextStyle(
                  style: widget.defaultWeekdayTextStyle,
                  child: Text(
                    weekDay,
                    style: widget.weekdayTextStyle,
                  ),
                ),
              ),
            )),
      );
    }
    return list;
  }


  int selectedDayIndex(int year, month, day) {
//    widget.selectedDateTime != null &&
//        widget.selectedDateTime.year == year &&
//        widget.selectedDateTime.month == month &&
//        widget.selectedDateTime.day ==
//            index + 1 - this._startWeekday;

    for (int i = 0; i < widget.selectedDateTime.length; i++) {
      DateTime dateTime = widget.selectedDateTime[i];
      if (dateTime.year == year && dateTime.month == month &&
          dateTime.day == day)
        return i;
    }
    return -1;
  }

  bool isFirstDay(int year, month, day) {
    DateTime dateTime = widget.selectedDateTime[0];
    return dateTime.year == year
        && dateTime.month == month
        && dateTime.day == day;
  }

  bool isLastDay(int year, month, day) {
    DateTime dateTime = widget.selectedDateTime[widget.selectedDateTime.length - 1];
    return dateTime.year == year
        && dateTime.month == month
        && dateTime.day == day;
  }
  
  Color getGradientAt(Color from, Color to, double percent){
    return Color.fromARGB(255, 
      (from.red + (from.red - to.red) * percent).floor().abs(), 
      (from.green + (from.green - to.green) * percent).floor().abs(), 
      (from.blue + (from.blue - to.blue) * percent).floor().abs()
    );
  }

  BoxDecoration getShape({bool isFist, isLast, int index}){
    var grad = index != -1 ? LinearGradient(
      colors: [
        getGradientAt(AppColors.redRightGradButton, AppColors.redLeftGradButton, index / widget.selectedDateTime.length),
        getGradientAt(AppColors.redRightGradButton, AppColors.redLeftGradButton, (index + 1) / widget.selectedDateTime.length),
      ]
    ) : LinearGradient(
      colors:[
        Colors.transparent,
        Colors.transparent
      ]
    );
  

    if(widget.selectedDateTime.length == 1)
      return BoxDecoration(gradient: grad, borderRadius: BorderRadius.only(
          topRight: Radius.circular(0.0),
          bottomRight: Radius.circular(50.0),
          topLeft: Radius.circular(50.0),
          bottomLeft: Radius.circular(0.0),                 
        )
      );
    if(isFist){
      return  BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
            bottomLeft: Radius.circular(0.0),

          ),
          gradient: grad
      );

    }else if(isLast){
      return BoxDecoration(
          gradient: grad,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(0.0),
              bottomRight: Radius.circular(50.0)));
    }

    return BoxDecoration(gradient: grad, borderRadius: BorderRadius.all(Radius.circular(.0)));


  }

}