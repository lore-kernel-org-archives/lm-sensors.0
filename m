From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <Pine.LNX.4.58.0503311209270.21101@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


We have seen that:

1) on one system it reports unknown mem type (with abit mb)

eeprom-i2c-0-51
Adapter: SMBus ALi 1563 Adapter @ 5000
Unknown EEPROM type (255).   <== this may be rather -1 as error

00: ac 00 07 0d 0b 01 48 00 04 75 75 02 82 04 04 01    ?.????H.?uu?????
10: 0e 04 0c 01 02 26 c0 a0 75 00 00 50 3c 50 2d 80    ?????&??u..P<P-?
20: ac 00 50 50 00 00 00 00 00 46 50 30 32 75 00 00    ?.PP.....FP02u..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 3d    ...............40: ac 00 7f 7f 9e 00 00 00 00 31 30 38 31 30 20 20    ?.???....10810
50: 20 20 20 20 20 20 20 20 20 20 20 00 00 05 03 00               ..??.
60: ac 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00    ?.?.............
70: 00 00 00 00 00 00 00 00 00 00 00 20 4f 02 00 00    ........... O?..
80: ac 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ?...............
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: ac 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ?...............
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: ac 00 00 00 00 00 00 00 00 00 00 28 ff 00 00 00    ?..........(....
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: ac 00 ac 00 00 00 00 00 00 00 00 00 00 00 00 00    ?.?.............
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0f 28    ..............?(

But the dump alters sometimes to: (We have seen this only once maybe
it was due to timeout of reading the bus due to debugging messages)
This values came really out of the chip:

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 07 0c 0a 01 48 00 04 75 75 02 80 08 08 01    ..????H.?uu?????
10: 0e 04 0c 01 02 26 00 a0 75 00 00 50 3c 50 30 20    ?????&.?u..P<P0
20: 00 00 50 50 00 00 00 00 00 41 4b 30 32 75 00 00    ..PP.....AK02u..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1a    ...............?
40: 00 00 00 00 00 00 00 bb ff 00 00 00 00 00 00 00    .......?........
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: 00 00 ac ff ff ff ff ff ff ff ff ff ff ff ff ff    ..?.............
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

On other motherboad we have seen:

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 1100
Memory type:            DDR SDRAM DIMM
Memory size (MB):       128

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ac 00 07 0c 0a 01 48 00 04 75 75 02 80 08 08 01    ?.????H.?uu?????
10: 0e 04 0c 01 02 26 00 a0 75 00 00 50 3c 50 30 20    ?????&.?u..P<P0
20: 00 00 50 50 00 00 00 00 00 41 4b 30 32 75 00 00    ..PP.....AK02u..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1a    ...............?
40: ac 00 00 00 00 00 00 bb ff 00 00 00 00 00 00 00    ?......?........
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: ac 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ac 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: 00 00 ac ff ff ff ff ff ff ff ff ff ff ff ff ff    ..?.............
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

Conclusions about different dumps:

I assume that the driver is working correctly and in your last email
you were using the driver WITHOUT a lot of debugging messages. Maybe the
delay while logging the messages caused troubles.

Conclusions about Unknown type versus Known type:

Please are you sure you were using same version or lm_sensors?
I think you told us that you just swapped the drives. Maybe something
is still wrong about error signaling in the ali driver.

Steps to make us sure about bus readings:

1) take some OTHER  memory DDR (different manufacturer if possible)
2) put into ABIT, remove any other ddr memory modules
3) do i2cdump 0x50 asume 0x50 is correct addr of the chip
4) try this several times, also plz load your chip driver
   and run sensors command from time to time. Check if you get
   same two first bytes of the dump third should be 0x7 for DDR.
5) take the same memory module to the intel board
6) check again if the dumps are same (plz remove any other ram modules)

If this passes and we still get unknown EEPROM and the program versions
are same it means that in ALI driver there is some error handling bug.
Or some other bug in general :)

Way from sensors program
is from libsensors to /sys/bus... or to  /proc/sys...
there are files with eeprom content that are size of 16 bytes I think.

Thus files are created by eeprom driver which is the driver for eeprom.
There must be some error that can be propagated this way.

I'm sorry I really must code my homework, please try to find how error
unknown eeprom type propages through all way. Be careful when adding
more debug messages to i2c-ali1563 it seems to be sensitive to this.

I will think about it too but later.

regards

Rudolf
