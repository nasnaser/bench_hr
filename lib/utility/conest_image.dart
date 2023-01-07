class AppImage {
  static const String imagePath = "assets/image/flags/";
  static const String imageEventsIconPath = "assets/image/eventsicon/";


  static String   getimageEventsIconPath({required String eventIcon}) {
    if(eventIcon=="barchart06"){
      return "assets/image/eventsicon/birthday.svg";
    }else if(eventIcon=="rocket02"){
      return "assets/image/eventsicon/onboarding.svg";




    }else if(eventIcon=="trendup01"){
      return "assets/image/eventsicon/yearlyanniversary.svg";;
    }else if(eventIcon=="calendarcheck02"){
      return "assets/image/eventsicon/employeefarewell.svg";
    }
    else if(eventIcon=="rocket02"){
      return "assets/image/eventsicon/onboarding.svg";
    }
    return "assets/image/eventsicon/birthday.svg";


      // switch (eventIcon) {
      //     case "barchart06":
      //         return "assets/image/eventsicon/birthday.svg";
      //
      //     case "rocket02":
      //       ;
      //
      //
      //
      //     case "trendup01":
      //         return "assets/image/eventsicon/yearlyanniversary.svg";
      //     case "calendarcheck02":
      //         return "assets/image/eventsicon/employeefarewell.svg";
      //     case "award05":
      //
      //
      //     default: {
      //         return "assets/image/eventsicon/birthday.svg";
      //     }
      // }
  }
}