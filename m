From: Konstantin Kletschke <konsti@ku-gbr.de>
Date: Wed, 24 Jun 2009 14:23:50 +0000
Subject: Re: [lm-sensors] HowTo Asus P5Q, W83667HG vs ATK0110 - fancontrol
Message-Id: <20090624142350.GA2009@punzenstreichler.doom>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090624094735.GA16670@punzenstreichler.doom>
In-Reply-To: <20090624094735.GA16670@punzenstreichler.doom>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Okay, I even moved the w83627ehf.ko and asus_atk0110.ko away and
rebooted.

Am 2009-06-24 14:53 +0200 schrieb Jean Delvare:

> isaset 0x295 0x296 0x4e 0 # set bank to 0
> isadump 0x295 0x296

 >isaset 0x295 0x296 0x4e 0
 >isadump 0x295 0x296
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 ff 04 3d 00 00 46 20 01 9b 01 01 3c 3c 04 04
10: 04 99 30 00 00 01 01 3c 43 17 00 00 32 ff ff c5
20: 80 dc cf cd d3 ff c3 2c ff 99 ff da 00 06 71 10
30: f7 94 c8 45 50 b2 8a 13 c1 90 85 01 27 01 01 ff
40: 03 00 00 ff ff 00 3f 35 2d 21 20 40 10 95 00 a3
50: ff ff 00 ff ff ff 00 80 c1 6f ff ff 19 45 04 05
60: 04 3d 50 00 01 01 3c ff 0a ff 01 ff ff ff ff 28
70: 46 46 46 46 46 37 ff ff ff ff ff 4b 22 00 2c ff
80: 04 ff 04 3d 00 00 46 20 01 9b 01 01 3c 3c 04 04
90: 04 99 30 00 00 01 01 3c 43 17 00 00 32 ff ff c5
a0: 80 dc cf cd d3 ff c3 2c ff 99 ff da 00 06 71 10
b0: f7 94 c8 45 50 b2 8a 13 c1 90 85 01 27 01 01 ff
c0: 03 00 00 ff ff 00 3f 35 2d 21 20 40 10 95 00 a3
d0: ff ff 00 ff ff ff 00 80 c1 6f ff ff 19 45 04 05
e0: 04 3d 50 00 01 01 3c ff 0a ff 01 ff ff ff ff 28
f0: 46 46 46 46 46 37 ff ff ff ff ff 4b 22 00 2c ff

> isaset 0x295 0x296 0x01 0xaa
> isadump 0x295 0x296

 >isaset 0x295 0x296 0x01 0xaa
Data mismatch, wrote 0xaa, read 0xff back.
 >isadump 0x295 0x296
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 ff 04 3d 00 00 46 20 01 9b 01 01 3c 3c 04 04
10: 04 99 30 00 00 01 01 3c 43 17 00 00 32 ff ff cf
20: 80 dc cf ce d3 ff c3 2c ff 99 ff da 00 06 71 10
30: f7 94 c8 45 50 b2 8a 13 c1 90 85 01 27 01 01 ff
40: 03 00 00 ff ff 00 3f 35 2d 21 20 40 10 95 00 a3
50: ff ff 00 ff ff ff 00 80 c1 6f ff ff 19 45 04 05
60: 04 3d 50 00 01 01 3c ff 0a ff 01 ff ff ff ff 28
70: 46 46 46 46 46 37 ff ff ff ff ff 4b 22 00 2c ff
80: 04 ff 04 3d 00 00 46 20 01 9b 01 01 3c 3c 04 04
90: 04 99 30 00 00 01 01 3c 43 17 00 00 32 ff ff cf
a0: 80 dc cf ce d3 ff c3 2c ff 99 ff da 00 06 71 10
b0: f7 94 c8 45 50 b2 8a 13 c1 90 85 01 27 01 01 ff
c0: 03 00 00 ff ff 00 3f 35 2d 21 20 40 10 95 00 a3
d0: ff ff 00 ff ff ff 00 80 c1 6f ff ff 19 45 04 05
e0: 04 3d 50 00 01 01 3c ff 0a ff 01 ff ff ff ff 28
f0: 46 46 46 46 46 37 ff ff ff ff ff 4b 22 00 2c ff

0x01 seems to be readonly.

> isaset 0x295 0x296 0x03 0xbb
> isadump 0x295 0x296

 >isaset 0x295 0x296 0x03 0xbb
Data mismatch, wrote 0xbb, read 0x37 back.
 >isadump 0x295 0x296
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 bb 04 37 00 00 46 20 01 9b 01 01 3c 3c 04 04
10: 04 99 30 00 00 01 01 3c 43 17 00 00 32 ff ff d1
20: 80 dc cf ce d3 ff c3 2b ff 9d ff da 00 06 71 10
30: f7 94 c8 45 50 b2 8a 13 c1 90 85 01 27 01 01 ff
40: 03 00 00 ff ff 00 3f 35 2d 21 20 40 10 95 00 a3
50: ff ff 00 ff ff ff 00 80 c1 6f ff ff 19 45 04 05
60: 04 37 50 00 01 01 3c ff 0a ff 01 ff ff ff ff 28
70: 46 46 46 46 46 37 ff ff ff ff ff 4b 22 00 2b ff
80: 04 bb 04 37 00 00 46 20 01 9b 01 01 3c 3c 04 04
90: 04 99 30 00 00 01 01 3c 43 17 00 00 32 ff ff d1
a0: 80 dc cf ce d3 ff c3 2b ff 9d ff da 00 06 71 10
b0: f7 94 c8 45 50 b2 8a 13 c1 90 85 01 27 01 01 ff
c0: 03 00 00 ff ff 00 3f 35 2d 21 20 40 10 95 00 a3
d0: ff ff 00 ff ff ff 00 80 c1 6f ff ff 19 45 04 05
e0: 04 37 50 00 01 01 3c ff 0a ff 01 ff ff ff ff 28
f0: 46 46 46 46 46 37 ff ff ff ff ff 4b 22 00 2b ff

0x03 writes to 0x01...

> isaset 0x295 0x296 0x11 0xcc
> isadump 0x295 0x296

 >isaset 0x295 0x296 0x11 0xcc
 >isadump 0x295 0x296
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 bb 04 37 00 00 46 20 01 9b 01 01 3c 3c 04 04
10: 04 cc 30 00 00 01 01 3c 43 17 00 00 32 ff ff d3
20: 80 dc cf ce d3 ff c3 2b ff 9d ff da 00 06 71 10
30: f7 94 c8 45 50 b2 8a 13 c1 90 85 01 27 01 01 ff
40: 03 00 00 ff ff 00 3f 35 2d 21 20 40 10 95 00 a3
50: ff ff 00 ff ff ff 00 80 c1 6f ff ff 19 45 04 05
60: 04 37 50 00 01 01 3c ff 0a ff 01 ff ff ff ff 28
70: 46 46 46 46 46 37 ff ff ff ff ff 4b 22 00 2b ff
80: 04 bb 04 37 00 00 46 20 01 9b 01 01 3c 3c 04 04
90: 04 cc 30 00 00 01 01 3c 43 17 00 00 32 ff ff d3
a0: 80 dc cf ce d3 ff c3 2b ff 9d ff da 00 06 71 10
b0: f7 94 c8 45 50 b2 8a 13 c1 90 85 01 27 01 01 ff
c0: 03 00 00 ff ff 00 3f 35 2d 21 20 40 10 95 00 a3
d0: ff ff 00 ff ff ff 00 80 c1 6f ff ff 19 45 04 05
e0: 04 37 50 00 01 01 3c ff 0a ff 01 ff ff ff ff 28
f0: 46 46 46 46 46 37 ff ff ff ff ff 4b 22 00 2b ff

0x11 indeed writes to 0x11.

This reflects somehow how echo into the /sys filesystem reacts.

> If this works fine then that would be a bug in the driver. If it
> doesn't, that would be a hardware bug.

What I wonder, is there any success report pwm controlling cpu fan from
userspace with this W83667HG-A chip?

Meanwhile I read many reports not achieving this. There are two other
fan header (3-PIN non PWM) and many people connect their fans there and
doing DC regulation, even on windows platform (the other pin on some
p5q-xxx boards are able to do DC regulating there, I don't know if mine
is able to do yet).

Kind Regards, Konsti

-- 
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
