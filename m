From: mcarland@yahoo.com (Michael Carland)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: Error messages on ignored values
Message-Id: <20050204053725.34834.qmail@web60504.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi.

I've read the FAQ, and see the error message I am receiving, but the
answer does not seem to apply.

I am running Debian sarge, with a 2.6.10 kernel that I have built, the
user programs of lm_sensors-2.9.0, and the 2.6.10 kernel patch. I am able
to run sensors, and get valid output, but the values that are marked
ignore in the sensors.conf are reported as unreadable. I changed a label
value in the conf file and saw the output of sensors change, so I know I
am looking at the correct configuration file.

I have added a debug message to progs/sensors/chips.c to print out the
result of sensors_get_ignored, and see that the config file is being used
to determine that the values should be ignored.

mcarland@myth:~/lm_sensors-2.9.0/prog/sensors$ lsmod
Module                  Size  Used by
vt1211                 16692  0 
i2c_sensor              2784  1 vt1211
i2c_isa                 1600  0 
lirc_serial            11328  0 
lirc_dev               11404  1 lirc_serial
mcarland@myth:~/lm_sensors-2.9.0/prog/sensors$ uname -a
Linux myth 2.6.10myth-via #5 Thu Feb 3 21:24:11 UTC 2005 i686 GNU/Linux
mcarland@myth:~/lm_sensors-2.9.0/prog/sensors$ ./sensors -v
sensors version 2.9.0 with libsensors version 2.9.0
mcarland@myth:~/lm_sensors-2.9.0/prog/sensors$ ./sensors
vt1211-isa-6000
Adapter: ISA adapter
Ignored : 0 vt1211
ERROR: Can't get IN0 data!
Ignored : 0 vt1211
ERROR: Can't get IN1 data!
Ignored : 1 vt1211
VCore1:    +1.39 V  (min =  +1.28 V, max =  +1.42 V)   
Ignored : 1 vt1211
+5V:       +5.09 V  (min =  +4.60 V, max =  +5.25 V)   
Ignored : 1 vt1211
+12V:     +12.40 V  (min = +10.81 V, max = +13.20 V)   
Ignored : 1 vt1211
+3.3V:     +3.32 V  (min =  +3.13 V, max =  +3.47 V)   
Ignored : 1 vt1211
System:      0 RPM  (min = 1503 RPM, div = 4)          
Ignored : 1 vt1211
CPU:      6241 RPM  (min = 3006 RPM, div = 2)          
Ignored : 1 vt1211
temp2:     +66.5 C  (high =  +255 C, hyst =    +0 C)   
Ignored : 1 vt1211
CPU:       +28.6 C  (high =   +65 C, hyst =   +60 C)   
Ignored : 1 vt1211
temp4:     +59.0 C  (high =  +255 C, hyst =    +0 C)   
Ignored : 0 vt1211
ERROR: Can't get TEMP5 data!
Ignored : 0 vt1211
ERROR: Can't get TEMP6 data!
Ignored : 0 vt1211
ERROR: Can't get TEMP7 data!
Ignored : 1 vt1211
vid:      +2.050 V  (VRM Version 8.2)

I see that the logic to print out the values checks the ignored status,
but doesn't use it until after an attempt to read the values:

  if (!sensors_get_label_and_valid(*name,SENSORS_VT1211_IN0,&label,&valid)
&&
      !sensors_get_feature(*name,SENSORS_VT1211_IN0,&cur) &&
      !sensors_get_feature(*name,SENSORS_VT1211_IN0_MIN,&min) &&
      !sensors_get_feature(*name,SENSORS_VT1211_IN0_MAX,&max)) {
    if (valid) {
      print_label(label,10);
      printf("%+6.2f V  (min = %+6.2f V, max = %+6.2f V)   %s\n",
             cur,min,max,alarms&VT1211_ALARM_IN0?"ALARM":"");
    }
  } else
    printf("ERROR: Can't get IN0 data!\n");
  free_the_label(&label);

Shouldn't either sensors_get_feature(...) not do the read if the feature
is not valid (only that function would have to be changed), or more
appropriately change the logic for each section like the one above to
break if !valid, before sensors_get_feature(...) is called? Something like

  if (sensors_get_label_and_valid(*name,SENSORS_VT1211_IN0,&label,&valid))
{
    printf("ERROR: Can't get IN0 data!\n");
  } else if (valid) {
    if (!sensors_get_feature(*name,SENSORS_VT1211_IN0,&cur) &&
        !sensors_get_feature(*name,SENSORS_VT1211_IN0_MIN,&min) &&
        !sensors_get_feature(*name,SENSORS_VT1211_IN0_MAX,&max)) {
        print_label(label,10);
        printf("%+6.2f V  (min = %+6.2f V, max = %+6.2f V)   %s\n",
               cur,min,max,alarms&VT1211_ALARM_IN0?"ALARM":"");
    } else
    printf("ERROR: Can't get IN0 data!\n");
  }
  free_the_label(&label);

Or have I got something else wrong?

Thanks,

-Michael



		
__________________________________ 
Do you Yahoo!? 
Take Yahoo! Mail with you! Get it on your mobile phone. 
http://mobile.yahoo.com/maildemo 
