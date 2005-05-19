From: ascannell@somanetworks.com (Adin Scannell)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: libsensors & PCF8574
Message-Id: <Pine.LNX.4.44.0303031320300.2628-300000@albatross.yyz.somanetworks.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey there,

I am interested in using libsensors for a project that I am working on, but 
I discovered that one of the chips that I need to access isn't supported 
through it.  This is, of course (noting the subject :), the PCF8574.  
Attached is the tiny patch required for this support.  I hope it can be 
included in future releases.  Anyways, please let me know.  Keep up the 
great work!

Attached files are diffs for:
lm_sensors2/lib/chips.c
lm_sensors2/lib/chips.h

Thanks!
-Adin Scannell
-------------- next part --------------
Index: chips.h
=================================RCS file: /home/cvs/lm_sensors2/lib/chips.h,v
retrieving revision 1.61
diff -r1.61 chips.h
1127a1128,1133
> /* PCF8574 chip. */
> #define SENSORS_PCF8574_PREFIX "pcf8574"
> 
> #define SENSORS_PCF8574_READ 1 /* R */
> #define SENSORS_PCF8574_WRITE 2 /* W */
> 
-------------- next part --------------
Index: chips.c
=================================RCS file: /home/cvs/lm_sensors2/lib/chips.c,v
retrieving revision 1.78
diff -r1.78 chips.c
2832a2833,2841
>   static sensors_chip_feature pcf8574_features[] >   {
>     { SENSORS_PCF8574_READ, "read", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
>                             SENSORS_MODE_R, PCF8574_SYSCTL_READ, VALUE(1), 0 },
>     { SENSORS_PCF8574_WRITE, "write", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
>                              SENSORS_MODE_RW, PCF8574_SYSCTL_WRITE, VALUE(1), 0 },
>     { 0 }
>   };
> 	
3386a3396
>  { SENSORS_PCF8574_PREFIX, pcf8574_features }, 
