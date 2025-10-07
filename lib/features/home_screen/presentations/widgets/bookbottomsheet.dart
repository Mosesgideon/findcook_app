import 'package:find_cook/common/widgets/custom_button.dart';
import 'package:find_cook/common/widgets/custom_dialogs.dart';
import 'package:find_cook/common/widgets/outlined_form_field.dart';
import 'package:find_cook/common/widgets/text_view.dart';
import 'package:find_cook/features/mybookings/data/bookingsRepository/bookings_repositoryImpl.dart';
import 'package:find_cook/features/mybookings/data/models/booking_models.dart';
import 'package:find_cook/features/mybookings/domain/bookingsRepo.dart';
import 'package:find_cook/features/mybookings/presentations/bloc/bookings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../../core/services/share_prefs/shared_prefs_save.dart';
import '../../../authentication/data/models/AuthSuccessResponse.dart';

class Bookbottomsheet extends StatefulWidget {
  final String cookId;
  final String cookName;
  final String cookEmail;
  final String cookAbout;
  final String cookLocation;
  final String yearsOfExperience;
  final List<String> cookType;
  final String cookChargePerHr;
  final String cookmarriageStatus;
  final List<String> cookLanguages;
  final String cookUsername;
  final String cookReligion;
  final String cookPhone;
  final String cookProfileImage;
  final String? cookCoverImage;
  final String cookHouseAddress;
  final List<String> cookGallery;
  final List<String> cookServices;
  final List<String> cookSpecialMeals;

  const Bookbottomsheet({
    super.key,
    required this.cookServices,
    required this.cookSpecialMeals, required this.cookId, required this.cookName, required this.cookEmail, required this.cookAbout, required this.cookLocation, required this.yearsOfExperience, required this.cookType, required this.cookChargePerHr, required this.cookmarriageStatus, required this.cookLanguages, required this.cookUsername, required this.cookReligion, required this.cookPhone, required this.cookProfileImage, this.cookCoverImage, required this.cookHouseAddress, required this.cookGallery,
  });

  @override
  State<Bookbottomsheet> createState() => _BookbottomsheetState();
}

class _BookbottomsheetState extends State<Bookbottomsheet> {
  // List<String>type=["Personal/Private Chef","Pastry Chef","Garde Manger","Boucher","Catering/Banquet Chef",];
  List<int> selectedServices = [];
  List<int> selectedSpecilas = [];
  final proposalController = TextEditingController();
  final key = GlobalKey<FormState>();
  final bookBloc = BookingsBloc(BookingsRepositoryImpl());
  final shared = SharedPreferencesClass();
  AuthSuccessResponse? user;

  @override
  void initState() {
    super.initState();
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: 1.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: Form(
        key: key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                10.horizontalSpace,
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.cancel_rounded),
                ),
              ],
            ),
            20.verticalSpace,
            TextView(
              text: "Select Services You Want",
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            10.verticalSpace,
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.start,
              alignment: WrapAlignment.start,
              children: List.generate(
                widget.cookServices.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedServices.contains(index)) {
                        selectedServices.remove(index);
                      } else {
                        selectedServices.add(index);
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color:
                          selectedServices.contains(index)
                              ? Color(0xfffaab65)
                              : Colors.grey.withOpacity(0.1),
                    ),
                    child: Text(
                      widget.cookServices[index],
                      style: TextStyle(
                        color:
                            selectedServices.contains(index)
                                ? Colors.white
                                : Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            20.verticalSpace,
            Row(
              children: [
                TextView(
                  text: "Select special meals you want",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                TextView(text: "(optional)", fontSize: 10),
              ],
            ),
            10.verticalSpace,
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.start,
              alignment: WrapAlignment.start,
              children: List.generate(
                widget.cookSpecialMeals.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedSpecilas.contains(index)) {
                        selectedSpecilas.remove(index);
                      } else {
                        selectedSpecilas.add(index);
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color:
                          selectedSpecilas.contains(index)
                              ? Color(0xfffaab65)
                              : Colors.grey.withOpacity(0.1),
                    ),
                    child: Text(
                      widget.cookSpecialMeals[index],
                      style: TextStyle(
                        color:
                            selectedSpecilas.contains(index)
                                ? Colors.white
                                : Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            20.verticalSpace,
            Row(
              children: [
                TextView(text: "Proposal(Not more than 1000 words)"),
                TextView(text: "*", color: Colors.red),
              ],
            ),
            OutlinedFormField(
              controller: proposalController,
              validator:
                  MultiValidator([
                    RequiredValidator(errorText: 'This field is required'),
                  ]).call,

              hint: "write proposal",
              maxLine: 4,
            ),

            20.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: BlocConsumer<BookingsBloc, BookingsState>(
                listener: _listentToBookState,
                bloc: bookBloc,
                builder: (context, state) {
                  return CustomButton(
                    child: TextView(
                      text: "Book Cook",
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    onPressed: () {
                      bookService();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void bookService() {
    if (key.currentState!.validate()) {
      List<String> selectedServiceNames = selectedServices
          .map((index) => widget.cookServices[index])
          .toList();

      List<String> selectedMealNames = selectedSpecilas
          .map((index) => widget.cookSpecialMeals[index])
          .toList();
      bookBloc.add(BookCookEvent(AppBookingModelPayload(
          cookId: widget.cookId.toString(),
          clientId: user?.userID.toString(),
          cookName: widget.cookName,
          clientName: user?.fullname,
          cookEmail: widget.cookEmail,
          clientEmail: user?.email,
          cookAbout: widget.cookAbout,
          cookLocation: widget.cookLocation,
          clientLocation: user?.location.placeName,
          yearsOfExperience: widget.yearsOfExperience,
          cookType: widget.cookType,
          cookChargePerHr: widget.cookChargePerHr,
          cookmarriageStatus: widget.cookmarriageStatus,
          clientmarriageStatus: "Single",
          cookLanguages: widget.cookLanguages,
          cookUsername: widget.cookUsername,
          cookReligion: widget.cookReligion,
          cookPhone: widget.cookPhone,
          clientPhone: user?.phone,
          cookProfileImage: widget.cookProfileImage,
          clientProfileImage: '',
          cookCoverImage: widget.cookCoverImage,
          cookHouseAddress: widget.cookHouseAddress,
          clientHouseAddress: user?.houseAddress,
          cookGallery: widget.cookGallery,
          clientSelectedServices: selectedServiceNames,
          clientSelectedSpecialMeals: selectedMealNames, notes: proposalController.text.trim(),
          status: "pending"
      )));
    }
  }

  void _listentToBookState(BuildContext context, BookingsState state) {
    if(state is BookingsLoadingState){
      CustomDialogs.showLoading(context);
    }
    if(state is BookingsFailireState){
      Navigator.pop(context);
      CustomDialogs.showToast(state.error,isError: true);
    }
    if(state is BookingsCookSuccessState){
      Navigator.pop(context);
      CustomDialogs.showToast("Booking Successful");
      Navigator.pop(context);
    }

  }
}
