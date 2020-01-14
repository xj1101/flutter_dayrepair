class IphoneType{
    static String iphoneType(utsname){
      if(utsname=="iPhone1,1"){return "iPhone 2G";}
      if(utsname=="iPhone1,2"){return "iPhone 3G";}
      if(utsname=="iPhone2,1"){return "iPhone 3GS";}
      if(utsname=="iPhone3,1"){return "iPhone 4";}
      if(utsname=="iPhone3,2"){return "iPhone 4";}
      if(utsname=="iPhone3,3"){return "iPhone 4";}
      if(utsname=="iPhone4,1"){return "iPhone 4S";}
      if(utsname=="iPhone5,1"){return "iPhone 5";}
      if(utsname=="iPhone5,2"){return "iPhone 5";}
      if(utsname=="iPhone5,3"){return "iPhone 5C";}

      if(utsname=="iPhone5,4"){return "iPhone 5C";}
      if(utsname=="iPhone6,1"){return "iPhone 5S";}
      if(utsname=="iPhone6,2"){return "iPhone 5S";}
      if(utsname=="iPhone7,1"){return "iPhone 6 Plus";}
      if(utsname=="iPhone7,2"){return "iPhone 6";}
      if(utsname=="iPhone8,1"){return "iPhone 6S";}
      if(utsname=="iPhone8,2"){return "iPhone 6S Plus";}
      if(utsname=="iPhone8,4"){return "iPhone SE";}
      if(utsname=="iPhone9,1"){return "iPhone 7";}
      if(utsname=="iPhone9,2"){return "iPhone 7 Plus";}

      if(utsname=="iPhone10,1"){return "iPhone 8";}
      if(utsname=="iPhone10,2"){return "iPhone 8 Plus";}
      if(utsname=="iPhone10,3"){return "iPhone iPhone X";}
      if(utsname=="iPhone10,4"){return "iPhone iPhone 8";}
      if(utsname=="iPhone10,5"){return "iPhone iPhone 8 Plus";}
      if(utsname=="iPhone10,6"){return "iPhone X";}
      if(utsname=="iPhone11,8"){return "iPhone XR";}
      if(utsname=="iPhone11,2"){return "iPhone XS";}
      if(utsname=="iPhone11,4"){return "iPhone XS Max";}
      if(utsname=="iPhone11,6"){return "iPhone XS Max";}

      if(utsname=="iPod1,1"){return "iPod Touch 1G";}
      if(utsname=="iPod2,1"){return "iPod Touch 2G";}
      if(utsname=="iPod3,1"){return "iPod Touch 3G";}
      if(utsname=="iPod4,1"){return "iPod Touch 4G";}
      if(utsname=="iPod5,1"){return "iPod Touch 5G";}
      if(utsname=="i386"){return "iPhone 6";}
      if(utsname=="x86_64"){return "iPhone 6";}
    }
}