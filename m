From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <Pine.LNX.4.58.0503281655230.21101@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

The eeprom content seems corrupted. It can be caused by incorrect content
or reading of eeprom.

> 00: ac 00 07 0d 0b 01 48 00 04 75 75 02 82 04 04 01    ?.????H.?uu?????
> 10: 0e 04 0c 01 02 26 c0 a0 75 00 00 50 3c 50 2d 80    ?????&??u..P<P-?
> 20: ac 00 50 50 00 00 00 00 00 46 50 30 32 75 00 00    ?.PP.....FP02u..
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 3d    ...............> 40: ac 00 7f 7f 9e 00 00 00 00 31 30 38 31 30 20 20    ?.???....10810
> 50: 20 20 20 20 20 20 20 20 20 20 20 00 00 05 03 00               ..??.
> 60: ac 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00    ?.?.............
> 70: 00 00 00 00 00 00 00 00 00 00 00 20 4f 02 00 00    ........... O?..
> 80: ac 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ?...............
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> a0: ac 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ?...............
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> c0: ac 00 00 00 00 00 00 00 00 00 00 28 ff 00 00 00    ?..........(....
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> e0: ac 00 ac 00 00 00 00 00 00 00 00 00 00 00 00 00    ?.?.............
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0f 28    ..............?(

Can you see ac 00 each 16th byte?

Lets try to solve this. Best would be to grab you DDR module put it to
other machine with some other than ali SMBUS controller and do the dump
again. If it is same, eeprom is really corrupted. If it differs send it
here please.

Second and more likely is that ALI smbus host or our driver has some
problem.

Please can you try

i2cdump 0 0x50 c

This will use other SMBUS commands for readings maybe this time we will
get something better.

Please can you repeat experiments with debugging enabled?

1) classic i2dump
2) i2cdump with c

Please attach the logs.

Thanks

Rudolf
