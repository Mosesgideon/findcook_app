import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/custom_dialogs.dart';
import '../../../../common/widgets/error_widget.dart';
import '../../../../common/widgets/text_view.dart';
import '../../../../core/theme/pallets.dart';
import '../../../mybookings/data/bookingsRepository/bookings_repositoryImpl.dart';
import '../../../mybookings/presentations/bloc/bookings_bloc.dart';
class CookWidget extends StatefulWidget {
  const CookWidget({super.key});

  @override
  State<CookWidget> createState() => _CookWidgetState();
}

class _CookWidgetState extends State<CookWidget> {

  final mybookings = BookingsBloc(BookingsRepositoryImpl());

  @override
  void initState() {
    super.initState();
    mybookings.add(MyBookingEvent());
  }
  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<BookingsBloc, BookingsState>(
  listener: _listenToMyBookingsState,
  bloc: mybookings,

  builder: (context, state) {
    if (state is BookingsFailireState) {
      return Center(
        child: AppPromptWidget(
          onTap: () {
            mybookings.add(MyBookingEvent());
          },
        ),
      );
    }
    if (state is MyBookingsCookSuccessState) {
      final mybooks = state.response;
      final totalBookings = mybooks.length;

      double getProgress(int count) {
        if (totalBookings == 0) return 0;
        return count / totalBookings;
      }

      Color getProgressColor(int count) {
        return count == 0 ? Colors.grey : const Color(0xFF34C759);
      }

      final acceptedCount =
          mybooks.where((e) => e.status == "accepted").length;

      final completedCount =
          mybooks.where((e) => e.status == "completed").length;

      final pendingCount =
          mybooks.where((e) => e.status == "pending").length;

      final cancelledCount =
          mybooks.where((e) => e.status == "cancelled").length;
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(

                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Pallets.grey95,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(text: "Offer Success Rate"),
                      15.verticalSpace,
                      TextView(text: "${completedCount.toString()}% success rate"),

                      8.verticalSpace,
                      LinearProgressIndicator(
                        value:
                        getProgress(completedCount),
                        valueColor: AlwaysStoppedAnimation(
                          getProgressColor(completedCount),
                        ),
                        backgroundColor: Color(0xFFF4F4F4),
                        // valueColor: AlwaysStoppedAnimation(Color(0xFF34C759)),
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(10),

                      )
                    ],
                  ),
                ),
              ),
              30.verticalSpace,
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    Container(
                      width: 160,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Pallets.grey95,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(text:"Accepted offer" ,fontSize: 15,fontWeight: FontWeight.w600
                            ,),
                          10.verticalSpace,
                          Icon(Icons.check_circle,color: Colors.green,),
                          20.verticalSpace,

                          LinearProgressIndicator(
                            value:
                              getProgress(acceptedCount),
                            backgroundColor: Color(0xFFF4F4F4),
                            valueColor: AlwaysStoppedAnimation(
                              getProgressColor(acceptedCount),
                            ),
                          minHeight: 8,
                            borderRadius: BorderRadius.circular(10),

                          ),
                          10.verticalSpace,
                          TextView(text:acceptedCount.toString(),fontSize: 18,fontWeight: FontWeight.w500,),
                        ],
                      ),
                    ),
                    Container(
                      width: 160,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Pallets.grey95,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(text:"Completed offer" ,fontSize: 15,fontWeight: FontWeight.w600
                            ,),
                          10.verticalSpace,
                          Icon(Icons.check_circle,color: Colors.green,),
                          10.verticalSpace,

                          LinearProgressIndicator(
                              value:
                              getProgress(completedCount),
                            valueColor: AlwaysStoppedAnimation(
                              getProgressColor(acceptedCount),
                            ),
                            backgroundColor: Color(0xFFF4F4F4),

                            minHeight: 8,
                            borderRadius: BorderRadius.circular(10),

                          ),

                          TextView(text: completedCount.toString(),fontSize: 18,fontWeight: FontWeight.w500,),
                        ],
                      ),
                    ),
                  ]),
              20.verticalSpace,
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    Container(
                      width: 160,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Pallets.grey95,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(text:"Pending offer" ,fontSize: 15,fontWeight: FontWeight.w600
                            ,),
                          10.verticalSpace,
                          Icon(Iconsax.more,color: Color(0xffAEAE7DFF),),
                          10.verticalSpace,

                          LinearProgressIndicator(
                            value:
                            getProgress(pendingCount),
                            valueColor: AlwaysStoppedAnimation(
                              getProgressColor(acceptedCount),
                            ),
                            backgroundColor: Color(0xFFF4F4F4),
                            // valueColor: AlwaysStoppedAnimation(Color(0xFF34C759)),
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(10),

                          ),

                          TextView(text: pendingCount.toString(),fontSize: 18,fontWeight: FontWeight.w500,),
                        ],
                      ),
                    ),
                    Container(
                      width: 160,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Pallets.grey95,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(text:"Cancelled offer" ,fontSize: 15,fontWeight: FontWeight.w600
                            ,),
                          10.verticalSpace,
                          Icon(Icons.cancel_rounded,color: Colors.red,),
                          10.verticalSpace,

                          LinearProgressIndicator(
                            value:
                            getProgress(cancelledCount),
                            valueColor: AlwaysStoppedAnimation(
                              getProgressColor(acceptedCount),
                            ),
                            backgroundColor: Color(0xFFF4F4F4),
                            // valueColor: AlwaysStoppedAnimation(Color(0xFF34C759)),
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(10),

                          ),

                          TextView(text: cancelledCount.toString(),fontSize: 18,fontWeight: FontWeight.w500,),
                        ],
                      ),
                    ),
                  ]),
              50.verticalSpace,

            ],
          ),
        ),
      );

    }
     return SizedBox();
  },
);
  }
  void _listenToMyBookingsState(BuildContext context, BookingsState state) {
    if (state is BookingsLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is BookingsFailireState) {
      Navigator.pop(context);
      CustomDialogs.showToast(state.error, isError: true);
    }
    if (state is MyBookingsCookSuccessState) {
      print(state.response);
      Navigator.pop(context);
    }
  }

}
