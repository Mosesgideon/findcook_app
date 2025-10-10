import 'package:find_cook/features/home_screen/presentations/bloc/cook_bloc.dart';
import 'package:find_cook/features/mybookings/data/bookingsRepository/bookings_repositoryImpl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../common/widgets/custom_appbar.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_dialogs.dart';
import '../../../../common/widgets/image_widget.dart';
import '../../../../common/widgets/text_view.dart';
import '../../../../core/theme/pallets.dart';
import '../../data/models/book_response.dart';
import '../bloc/bookings_bloc.dart';

class CookBookingDetails extends StatefulWidget {
  final AppBookingResponse reponse;
  final String docid;
  const CookBookingDetails({super.key, required this.reponse, required this.docid});

  @override
  State<CookBookingDetails> createState() => _CookBookingDetailsState();
}

class _CookBookingDetailsState extends State<CookBookingDetails> {
  final acceptbloc = BookingsBloc(BookingsRepositoryImpl());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        tittle: TextView(
          text: "Booking Details",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        actions: [Icon(Iconsax.call), 20.horizontalSpace],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.reponse.status == "pending"
              ? CustomDialogs.showToast(
                "Messages are only available for accepted offer",
              )
              : SizedBox();
        },
        backgroundColor: Color(0xfffaab65),
        child: Icon(Icons.message, color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: "Personal Details",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              10.verticalSpace,
              Container(
                padding: EdgeInsets.all(15),
                width: 1.sw,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.5),
                  //     blurRadius: 0.5,
                  //     spreadRadius: 0.5,
                  //     offset: Offset(0.5, 0.5),
                  //   ),
                  // ],
                ),
                child: Row(
                  children: [
                    ImageWidget(
                      imageUrl: widget.reponse.clientProfileImage ?? '',
                      width: 100,
                      height: 100,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xfffaab65), width: 2),
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          8.verticalSpace,
                          TextView(
                            text: widget.reponse.clientName ?? '',
                            fontSize: 15,
                          ),
                          4.verticalSpace,
                          TextView(
                            text: "${widget.reponse.clientLocation ?? ''} ",
                            fontSize: 12,
                          ),

                          4.verticalSpace,
                          TextView(
                            text: widget.reponse.clientPhone ?? '',
                            fontSize: 12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              20.verticalSpace,

              TextView(
                text: "Booked For : ",
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              10.verticalSpace,
              TextView(
                text: widget.reponse.clientSelectedServices.toString(),
                fontWeight: FontWeight.w400,
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    text: "Date Booked :  ",
                    fontWeight: FontWeight.w400,
                  ),
                  TextView(
                    text: DateFormat(
                      'MMM d, yyyy',
                    ).format(widget.reponse.bookedTime!),
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    text: "Event Status :  ",
                    fontWeight: FontWeight.w400,
                  ),
                  TextView(
                    text: widget.reponse.eventstatus?.toUpperCase() ?? '',
                    fontWeight: FontWeight.w400,
                    color: Colors.green,
                  ),
                ],
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    text: "Client Paid Consultation Fee",
                    fontWeight: FontWeight.w400,
                  ),
                  TextView(text: "\$20", fontWeight: FontWeight.w700),
                ],
              ),
              20.verticalSpace,
              TextView(
                text: "Client Booking Proposal",
                fontWeight: FontWeight.w500,
              ),
              5.verticalSpace,
              TextView(
                text: widget.reponse.notes ?? '',
                fontWeight: FontWeight.w300,
                fontSize: 12,
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    text: "Proposal Status :  ",
                    fontWeight: FontWeight.w400,
                  ),
                  TextView(
                    text: widget.reponse.status?.toUpperCase() ?? '',
                    fontWeight: FontWeight.w400,
                    color: Colors.green,
                  ),
                ],
              ),
              5.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(text: "Date Accepted : "),
                  widget.reponse.status == "pending"
                      ? TextView(
                        text: "Not yet accepted",
                        fontWeight: FontWeight.w400,
                        color: Colors.green,
                      )
                      : TextView(
                    text: DateFormat(
                      'MMM d, yyyy',
                    ).format(widget.reponse.dateAccepted!),
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              5.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(text: "Contract/Booking Duration: "),
                  TextView(text: "4 days ", fontWeight: FontWeight.w400),
                ],
              ),
              20.verticalSpace,
              TextView(text: "Dishes Selected", fontWeight: FontWeight.w500),
              5.verticalSpace,
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.spaceAround,
                spacing: 4,
                runSpacing: 8,
                children: List.generate(
                  widget.reponse.clientSelectedSpecialMeals.length,
                  (ctx) => Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Pallets.grey60.withOpacity(0.1),
                      ),
                    ),
                    child: TextView(
                      text: widget.reponse.clientSelectedSpecialMeals[ctx],
                    ),
                  ),
                ),
              ),

              20.verticalSpace,

              TextView(text: "Start And End Date: "),
              5.verticalSpace,
              widget.reponse.status == "pending"
                  ? TextView(
                    text: "Booking still pending",
                    color: Pallets.grey35,
                  )
                  : TextView(
                    text: "Not Yet accepted - 24 Sept 2025 ",
                    fontWeight: FontWeight.w400,
                  ),
              20.verticalSpace,
              widget.reponse.status == "accepted"
                  ? SizedBox()
                  : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: BlocConsumer<BookingsBloc, BookingsState>(
                      bloc: acceptbloc,
                      listener: _listentToUpdateBooking,
                      builder: (context, state) {
                        return CustomButton(
                          child: TextView(
                            text: "Accept Booking",
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          onPressed: () {
                            acceptbooking();

                            // CustomDialogs.showBottomSheet(context,
                            // Bookbottomsheet(cookServices: [], cookSpecialMeals: [],));
                          },
                        );
                      },
                    ),
                  ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  void acceptbooking() {
    acceptbloc.add(UpdateBookingEvent(widget.reponse.docId.toString()));
  }

  void _listentToUpdateBooking(BuildContext context, BookingsState state) {
    if (state is BookingsLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is BookingsFailireState) {
      Navigator.pop(context);
      CustomDialogs.showToast(state.error, isError: true);
      print(state.error);
    }
    if (state is UpdateBookingsSuccessState) {
      Navigator.pop(context);
      CustomDialogs.showToast("Booking accepted");
      Navigator.pop(context);
    }
  }
}
