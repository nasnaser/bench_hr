import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../constants/app_color.dart';
import '../../../network/apis/employees_api.dart';
import '../../../network/json_model/employees_model.dart';

class AttendaceController extends GetxController {
  EmployeesModel? employeesModel;

  getAllEmployees() {
    EmployeesAPI employeesAPI = EmployeesAPI();
    employeesAPI.getData().then((value) {
      employeesModel = value as EmployeesModel;
      update();
    });
  }
bool searchByLocation=true;
  bool isAll=false;
  updateSerchByLocation({required bool search}){
    searchByLocation=search;
    update();
  }
  searchBotomSheet({required context}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) =>
          DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.2,
            maxChildSize: 0.5,
            expand: false,
            builder: (_, controller) =>
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 20, right: 20),
                    child: GetBuilder<AttendaceController>(builder: (logic) {
                      return Column(children: [
                        SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: Container(
                            height: 2,
                            width: 30,
                            decoration: BoxDecoration(
                                color: ColorApp.greyIntroColor2.withOpacity(
                                    .5)),
                          ),
                        ),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(43),
                              color: HexColor("#E5EEEE")),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                         GestureDetector(onTap: (){
                                updateSerchByLocation(search: false);
                              },
                          child: Container(
                                    height: 40,width: MediaQuery.of(context).size.width*.4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(43),
                                        color:searchByLocation? Colors.white.withOpacity(0):HexColor("#015555")),
                                    child: Center(child: Text("القسم", style: TextStyle(
                                        color:  searchByLocation?HexColor("#015555"): Colors.white,fontWeight: FontWeight.w400,fontSize: 16),),)),
                        )    ,     GestureDetector(onTap: (){
                                updateSerchByLocation(search: true);
                              },
                                child: Center(
                                  child: Container(
                                      height: 40,width: MediaQuery.of(context).size.width*.4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(43),
                                        color:searchByLocation? HexColor("#015555"):Colors.white.withOpacity(0),),
                                      child: Center(child: Text("الموقع", style: TextStyle(
                                          color:  searchByLocation? Colors.white:HexColor("#015555"),fontWeight: FontWeight.w400,fontSize: 16)),)),
                                ),
                              )
                              ,]),
                          ),)










                      ,  Row(children: [Checkbox( shape: ,value: isAll, onChanged: (v) {
                        isAll=v;
                        update();
                        }),Text("إختيار الكل",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)],)



                      ]);
                    }),
                  ),
                ),
          ),
    );
  }
}
