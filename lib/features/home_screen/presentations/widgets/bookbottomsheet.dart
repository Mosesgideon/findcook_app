import 'package:find_cook/common/widgets/custom_button.dart';
import 'package:find_cook/common/widgets/outlined_form_field.dart';
import 'package:find_cook/common/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Bookbottomsheet extends StatefulWidget {
  const Bookbottomsheet({super.key});

  @override
  State<Bookbottomsheet> createState() => _BookbottomsheetState();
}

class _BookbottomsheetState extends State<Bookbottomsheet> {
  List<String>type=["Personal/Private Chef","Pastry Chef","Garde Manger","Boucher","Catering/Banquet Chef",];
  List<int> selectedIndices = [];
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      width: 1.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),
        ),color: Colors.white
      ),
      child: Column(

        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              10.horizontalSpace,
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                  child: Icon(Icons.cancel_rounded)),

            ],
          ),
          20.verticalSpace,
          TextView(text: "Select Services You Want",fontSize: 16,fontWeight: FontWeight.w600,),
          20.verticalSpace,
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            crossAxisAlignment: WrapCrossAlignment.start,
            runAlignment:WrapAlignment.start ,
            alignment: WrapAlignment.start,
            children: List.generate(
              type.length,
                  (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    if (selectedIndices.contains(index)) {
                      selectedIndices.remove(index);
                    } else {
                      selectedIndices.add(index);
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: selectedIndices.contains(index)
                        ? Color(0xfffaab65)
                        : Colors.grey.withOpacity(0.1),
                  ),
                  child: Text(
                    type[index],
                    style: TextStyle(
                        color: selectedIndices.contains(index)
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                      fontSize: 12
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
              TextView(text: "*",color: Colors.red,),
            ],
          ),
          OutlinedFormField(hint: "write proposal",maxLine: 4,),
          20.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: CustomButton(child: TextView(text: "Book Cook",color: Colors.white,fontWeight: FontWeight.w700 ,), onPressed: (){
              Navigator.pop(context);
            }),
          )
        ],
      ),
    );
  }
}
