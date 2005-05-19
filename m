From: emil71se@bredband.net (emil71se@bredband.net)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: vt1211.c for 2.6 again
Message-Id: <Pine.LNX.4.60.0408172043440.16429@ekman10.ekmanhome>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

I have put my port of the vt1211 for 2.6 kernels at;
http://hem.bredband.net/ekmlar/vt1211.html

Now it should be fairly complete except for testing. 
You may take it if you have use for it.


I found 2 bugs in the old version that you might want to correct
(i have lm_sensors-2.8.5);

1. In the "/etc/sensors.conf" for vt1211;

     compute in2 ((@ * 100) - 3) / (0.5952 * 95.8), (@ * 0.5952 * 0.958) + .03

    should be;

     compute in2 ((@ * 100) - 3) / (1.0 * 95.8), (@ * 1.0 * 0.958) + .03

    since K=1.0 for VCore.


2. In the "vt1211.c" file;

       #define ISTEMP(i, ch_config) ((i) = 1 ? 1 : \
 			      (i) = 3 ? 1 : \
 			      (i) = 2 ? ((ch_config) >> 1) & 0x01 : \
 			                 ((ch_config) >> ((i)-1)) & 0x01)

    should be;

       #define ISTEMP(i, ch_config) ((i) = 1 ? 1 : \
 			      (i) = 3 ? 1 : \
 			      (i) = 2 ? ((ch_config) >> 2) & 0x01 : \
 			                 ((ch_config) >> ((i)-1)) & 0x01)

    with this bug "temp2" will never be interpreted as a temp-sensor.


Best Regards,
Lars Ekman
