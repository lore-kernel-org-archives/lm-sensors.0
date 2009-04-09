From: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
Date: Thu, 09 Apr 2009 17:06:43 +0000
Subject: [lm-sensors] AMD 10h core temperatures
Message-Id: <49DE2B23.90900@aei.mpg.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi all,

I'm currently trying to persuade lm-sensors 3.0.2 to work with 2 Opteron
2354 on a Supermicro H8DM8 board. I've used the patch found here
http://groups.google.com/group/alt.os.linux/msg/13949f6da1fbdc1a?dmode=source&output=gplain
(please let me know if that patch is ok-ish enough) against a recent
2.6.27 kernel. However I do see quite a temperature difference here:

einstein-db:~# while sleep 2; do sensors|grep Core; ipmitool sdr|head -n
3; done
Core0 Temp:  +28.5°C
Core0 Temp:  +35.5°C
CPU1 Temp        | 31 degrees C      | ok
CPU2 Temp        | 31 degrees C      | ok
Sys Temp         | 35 degrees C      | ok
Core0 Temp:  +29.0°C
Core0 Temp:  +36.0°C
CPU1 Temp        | 31 degrees C      | ok
CPU2 Temp        | 31 degrees C      | ok
Sys Temp         | 35 degrees C      | ok
Core0 Temp:  +29.5°C
Core0 Temp:  +36.0°C
CPU1 Temp        | 32 degrees C      | ok
CPU2 Temp        | 32 degrees C      | ok
Sys Temp         | 35 degrees C      | ok
Core0 Temp:  +30.0°C
Core0 Temp:  +36.5°C
CPU1 Temp        | 33 degrees C      | ok
CPU2 Temp        | 33 degrees C      | ok
Sys Temp         | 35 degrees C      | ok
Core0 Temp:  +30.0°C
Core0 Temp:  +37.0°C
CPU1 Temp        | 33 degrees C      | ok
CPU2 Temp        | 33 degrees C      | ok
Sys Temp         | 35 degrees C      | ok
Core0 Temp:  +31.0°C
Core0 Temp:  +37.5°C
CPU1 Temp        | 34 degrees C      | ok
CPU2 Temp        | 33 degrees C      | ok
Sys Temp         | 35 degrees C      | ok
Core0 Temp:  +32.0°C
Core0 Temp:  +37.5°C
CPU1 Temp        | 34 degrees C      | ok
CPU2 Temp        | 34 degrees C      | ok
Sys Temp         | 35 degrees C      | ok
Core0 Temp:  +32.5°C
Core0 Temp:  +38.0°C
CPU1 Temp        | 35 degrees C      | ok
CPU2 Temp        | 34 degrees C      | ok
Sys Temp         | 35 degrees C      | ok
Core0 Temp:  +32.5°C
Core0 Temp:  +38.0°C
CPU1 Temp        | 35 degrees C      | ok
CPU2 Temp        | 35 degrees C      | ok
Sys Temp         | 35 degrees C      | ok
Core0 Temp:  +33.0°C
Core0 Temp:  +39.0°C
CPU1 Temp        | 36 degrees C      | ok
CPU2 Temp        | 35 degrees C      | ok
Sys Temp         | 35 degrees C      | ok
Core0 Temp:  +33.5°C
Core0 Temp:  +39.5°C
CPU1 Temp        | 37 degrees C      | ok
CPU2 Temp        | 35 degrees C      | ok
Sys Temp         | 35 degrees C      | ok
Core0 Temp:  +33.5°C
Core0 Temp:  +39.0°C
CPU1 Temp        | 37 degrees C      | ok
CPU2 Temp        | 36 degrees C      | ok
Sys Temp         | 35 degrees C      | ok
Core0 Temp:  +34.5°C
Core0 Temp:  +39.5°C
CPU1 Temp        | 38 degrees C      | ok
CPU2 Temp        | 36 degrees C      | ok
Sys Temp         | 35 degrees C      | ok
Core0 Temp:  +35.0°C
Core0 Temp:  +39.5°C
CPU1 Temp        | 38 degrees C      | ok
CPU2 Temp        | 37 degrees C      | ok
Sys Temp         | 35 degrees C      | ok
Core0 Temp:  +35.0°C
Core0 Temp:  +41.0°C
CPU1 Temp        | 39 degrees C      | ok
CPU2 Temp        | 37 degrees C      | ok
Sys Temp         | 35 degrees C      | ok
Core0 Temp:  +35.5°C
Core0 Temp:  +40.5°C
CPU1 Temp        | 39 degrees C      | ok
CPU2 Temp        | 37 degrees C      | ok
Sys Temp         | 35 degrees C      | ok
Core0 Temp:  +35.0°C
Core0 Temp:  +40.5°C
CPU1 Temp        | 39 degrees C      | ok
CPU2 Temp        | 38 degrees C      | ok
Sys Temp         | 35 degrees C      | ok
Core0 Temp:  +36.0°C
Core0 Temp:  +41.0°C
CPU1 Temp        | 39 degrees C      | ok
CPU2 Temp        | 38 degrees C      | ok
Sys Temp         | 35 degrees C      | ok
Core0 Temp:  +36.0°C
Core0 Temp:  +41.5°C
CPU1 Temp        | 40 degrees C      | ok
CPU2 Temp        | 38 degrees C      | ok
Sys Temp         | 35 degrees C      | ok
Core0 Temp:  +36.5°C
Core0 Temp:  +42.0°C
CPU1 Temp        | 40 degrees C      | ok
CPU2 Temp        | 39 degrees C      | ok
Sys Temp         | 35 degrees C      | ok
Core0 Temp:  +37.0°C
Core0 Temp:  +42.0°C
CPU1 Temp        | 40 degrees C      | ok
CPU2 Temp        | 39 degrees C      | ok
Sys Temp         | 35 degrees C      | ok
^C

Can anyone elaborate about the current status?

I'll be happy if I can help a bit

Cheers

Carsten

PS: Please Cc me

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
