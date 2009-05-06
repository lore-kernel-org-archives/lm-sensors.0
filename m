From: =?UTF-8?B?Q3NhcGzDoXIgWm9sdMOhbg==?= <csaplar.zoltan@gmail.com>
Date: Wed, 06 May 2009 07:06:00 +0000
Subject: [lm-sensors] lm_sensors 3.1 config file
Message-Id: <622d3d2b0905060006y366594a7re837cf23d53a0406@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hello,

I've written a program that uses lm_sensors 3.1. It's on a lot of PCs,
but I managed to collect the chips just now:

- ITE IT8712F
- ITE IT8718F
Winbond:
- w83627ehf
- w83627hf
Nat. Semi.:
- PC8374L
- PC87372
SMSC:
- EMC2700LPC
- LPC47M10x (smsc47m1)
- LPC47M15x (smsc47m1)
- LPC47M172
- LPC47M172
- LPC47M172
- LPC47M182
- SCH5027D-NW

I checked the sensors.conf.eg file to the lm_sensors, but fortunately
it consists just little information. I cannot understand its logic and
how to build up such a file, so I would like to ask for your help.

Could somebody send or link me the config files that belong to the
above mentioned chips?
May a more complete collection exist?
Please, if you need some out RPM (e.g. IT8118F) to get a chip, let me know.

Thank you in advance for your help.

Zoli

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
