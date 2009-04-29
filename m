From: =?ISO-8859-1?Q?Csapl=E1r_Zolt=E1n?= <csaplar.zoltan@gmail.com>
Date: Wed, 29 Apr 2009 15:00:50 +0000
Subject: Re: [lm-sensors] lm_sensors 3.1 unique config file
Message-Id: <06E648E007684F6A8D7A07819C0EA087@csaplar>
List-Id: <lm-sensors.vger.kernel.org>
References: <622d3d2b0903100034q2cc67357v7b1ea9707f9a6e4f@mail.gmail.com>
In-Reply-To: <622d3d2b0903100034q2cc67357v7b1ea9707f9a6e4f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hello,

I've written a program that uses lm_sensors 3.1. It's on a lot of PCs, but I 
managed to collect the chips just now:

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

I checked the sensors.conf.eg file to the lm_sensors, but fortunately it 
consists just little information. I cannot understand its logic and how to 
build up such a file, so I would like to ask for your help.

Could somebody send or link me the config files that belong to the above 
mentioned chips?
May a more complete collection exist?
Please, if you need some out RPM (e.g. IT8118F) to get a chip, let me know.

Thank you in advance for your help.

Zoli


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
