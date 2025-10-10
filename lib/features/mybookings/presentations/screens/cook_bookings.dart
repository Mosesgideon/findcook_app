import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../common/widgets/custom_dialogs.dart';
import '../../../../common/widgets/custom_outlined_button.dart';
import '../../../../common/widgets/error_widget.dart';
import '../../../../common/widgets/image_widget.dart';
import '../../../../common/widgets/text_view.dart';
import '../../../../core/services/share_prefs/shared_prefs_save.dart';
import '../../../authentication/data/models/AuthSuccessResponse.dart';
import '../../data/bookingsRepository/bookings_repositoryImpl.dart';
import '../bloc/bookings_bloc.dart';
import 'booking_details.dart';
import 'cook_booking_details.dart';
class CookBookings extends StatefulWidget {
  const CookBookings({super.key});

  @override
  State<CookBookings> createState() => _CookBookingsState();
}

class _CookBookingsState extends State<CookBookings> {
  final mybookings = BookingsBloc(BookingsRepositoryImpl());
  final shared = SharedPreferencesClass();
  AuthSuccessResponse? user;

  @override
  void initState() {
    super.initState();
    mybookings.add(MyBookingEvent());
    _loadUser();
  }

  Future<void> _loadUser() async {
    final data = await SharedPreferencesClass.getUserData();
    setState(() {
      user = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 100),
        child: Container(
          padding: EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
          decoration: BoxDecoration(color: Color(0xfffaab65)),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: Colors.green),
                    SizedBox(width: 8),
                    TextView(text: user?.location.placeName ?? ''),
                  ],
                ),
                CircleAvatar(child: Icon(Iconsax.user)),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<BookingsBloc, BookingsState>(
          bloc: mybookings,
          listener: _listenToMyBookingsState,
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

              if(state.response.isEmpty){
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        30.verticalSpace,
                        ImageWidget(imageUrl: "assets/png/empty.png",size: 200,),
                        20.verticalSpace,

                        TextView(text: "You haven't received any booking yet",align: TextAlign.center,),
                        30.verticalSpace,
                        // CustomOutlinedButton(child: TextView(text: "Book Now"), onPressed: (){})
                      ],
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(text: "Recent Bookings"),
                    20.verticalSpace,
                    Column(
                      children: List.generate(
                        mybooks.length,
                            (bookingCTX) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (ctx) => CookBookingDetails(reponse:mybooks[bookingCTX], docid: mybooks[bookingCTX].docId.toString(),),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    offset: Offset(1, 0),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  ImageWidget(
                                    imageUrl:
                                    mybooks[bookingCTX].clientProfileImage
                                        .toString(),
                                    width: 100,
                                    height: 100,
                                    borderRadius: BorderRadius.circular(15),
                                  ),

                                  10.horizontalSpace,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextView(
                                              text:
                                              mybooks[bookingCTX]
                                                  .clientName ??
                                                  '',
                                            ),

                                          ],
                                        ),
                                        TextView(
                                          text: mybooks[bookingCTX].bookedTime != null
                                              ? timeago.format(mybooks[bookingCTX].bookedTime!)
                                              : "",
                                          fontSize: 12,
                                          color: Colors.black.withOpacity(0.7),
                                        ),
                                        TextView(
                                          text: mybooks[bookingCTX].bookedTime != null
                                              ? "Booked on: ${DateFormat('MMM d, yyyy').format(mybooks[bookingCTX].bookedTime!)}"
                                              : "Booking date not available", color: Colors.black54,
                                          fontSize: 12,
                                        ),

                                        10.verticalSpace,
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextView(
                                              text: "Status : ",
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                            TextView(
                                              text:
                                              mybooks[bookingCTX].status ??
                                                  '',
                                              color: Colors.green,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ],
                                        ),

                                        // TextView(text: "3+ years experience of home cooking",color: Colors.black54,fontSize: 12,),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    50.verticalSpace,
                  ],
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
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
