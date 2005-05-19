From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:49 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <Pine.LNX.4.58.0504071339560.21101@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

I have some ideas.

The dumps in "continuous" mode are one byte shifted.
Possible reason is that old CMD reg value is used when writing
"transaction size" to HNST2

After i2cdump 0 0x50

The CMD reg is 0xFF
That would explain that
i2cdump 0 0x50 c

Begins with FF (last byte of eeprom)

Also why
modprobe eeprom
sensors

works for first one.

After I2C_QUICK cmd reg is already 00
so the continous read would work.

Then it changes to other value??? (I the log is exactly this part missing
I dont know why)

Apr  7 15:58:15 pi140001 kernel: i2c-ali1563: ENTERING ali1563_access,
line: 252
Apr  7 15:58:15 pi140001 kernel: i2c_adapter i2c-0: size is Ier i2c-0:

                                                     ^^^^^^^^^^^^^^^^
size is HST_CNTL2_BYTE!
Apr  7 15:58:15 pi140001 kernel: i2c_adapter i2c-0: rw = I2C_SMBUS_READ!

Also I'm not sure how to explain
> i2cdump 0 0x50 c  --> message2
> i2cdump 0 0x51 c  --> message3

Because CMD is also 00 but this is one byte shifted too.

Anyone else some ideas?

thanks

regards

Rudolf




On Thu, 7 Apr 2005 Huang0@Winbond.com.tw wrote:

> Hi Rudolf
>
> Please check the log message in attachment and the output message below.
> i2cdump 0 0x50  --> message1
> i2cdump 0 0x50 c  --> message2
> i2cdump 0 0x51 c  --> message3
> i2cdump 0 0x51  --> message4
> i2cdump 0 0x2f  --> message5
> i2cdump 0 0x50 c  --> message6
>
> [root@ ~]# modprobe eeprom
> [root@ ~]# sensors          --> message7
>
> =======================
>
> [root@ ~]# lsmod|grep i2c
> i2c_dev                12800  0
> i2c_ali1563            10116  0
> i2c_core               25728  2 i2c_dev,i2c_ali1563
> [root@ ~]# i2cdump 0 0x50
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x50, mode byte
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: ac 00 07 0c 0a 01 48 00 04 75 75 02 80 08 08 01    ?.????H.?uu?????
> 10: 0e 04 0c 01 02 26 00 a0 75 00 00 50 3c 50 30 20    ?????&.?u..P<P0
> 20: ac 00 50 50 00 00 00 00 00 41 4b 30 32 75 00 00    ?.PP.....AK02u..
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1a    ...............?
> 40: ac 00 00 00 00 00 00 bb ff 00 00 00 00 00 00 00    ?......?........
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 60: ac 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ?...............
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: ac 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> a0: ac 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> c0: ac 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: ac 00 ac ff ff ff ff ff ff ff ff ff ff ff ff ff    ?.?.............
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> [root@ ~]# i2cdump 0 0x50 c
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x50, mode byte consecutive read
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: ff ac 00 07 0c 0a 01 48 00 04 75 75 02 80 08 08    .?.????H.?uu????
> 10: 01 0e 04 0c 01 02 26 00 a0 75 00 00 50 3c 50 30    ??????&.?u..P<P0
> 20: 20 ac 00 50 50 00 00 00 00 00 41 4b 30 32 75 00     ?.PP.....AK02u.
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 40: 1a ac 00 00 00 00 00 00 bb ff 00 00 00 00 00 00    ??......?.......
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 60: 00 ac 00 00 00 00 00 00 00 00 00 00 00 00 00 00    .?..............
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: 00 ac 00 ff ff ff ff ff ff ff ff ff ff ff ff ff    .?..............
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> a0: ff ac 00 ff ff ff ff ff ff ff ff ff ff ff ff ff    .?..............
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> c0: ff ac 00 ff ff ff ff ff ff ff ff ff ff ff ff ff    .?..............
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: ff ac 00 ac ff ff ff ff ff ff ff ff ff ff ff ff    .?.?............
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> [root@ ~]# i2cdump 0 0x51 c
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x51, mode byte consecutive read
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: ff ac ff 07 0c 0a 01 48 00 04 75 75 02 80 08 08    .?.????H.?uu????
> 10: 01 0e 04 0c 01 02 26 00 a0 75 00 00 50 3c 50 30    ??????&.?u..P<P0
> 20: 20 00 00 50 50 00 00 00 00 00 41 4b 30 32 75 00     ..PP.....AK02u.
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 40: 1a 80 00 00 00 00 00 00 bb ff 00 00 00 00 00 00    ??......?.......
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: 00 80 00 ff ff ff ff ff ff ff ff ff ff ff ff ff    .?..............
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> a0: ff 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> c0: ff 80 00 ff ff ff ff ff ff ff ff ff ff ff ff ff    .?..............
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: ff 00 00 ac ff ff ff ff ff ff ff ff ff ff ff ff    ...?............
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> [root@ ~]# i2cdump 0 0x51
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x51, mode byte
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: ac ff 07 0c 0a 01 48 00 04 75 75 02 80 08 08 01    ?.????H.?uu?????
> 10: 0e 04 0c 01 02 26 00 a0 75 00 00 50 3c 50 30 20    ?????&.?u..P<P0
> 20: 00 00 50 50 00 00 00 00 00 41 4b 30 32 75 00 00    ..PP.....AK02u..
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1a    ...............?
> 40: 80 00 00 00 00 00 00 bb ff 00 00 00 00 00 00 00    ?......?........
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: 80 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> a0: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> c0: 80 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: 00 00 ac ff ff ff ff ff ff ff ff ff ff ff ff ff    ..?.............
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> [root@ ~]# i2cdump 0 0x2f
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x2f, mode byte
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 2a 2a 00 00 00 00 00 00 00 00 00 00 00 00 00 00    **..............
> 10: 00 00 64 64 9f 00 00 5f 00 ff 00 00 25 00 7c 80    ..dd?.._....%.|?
> 20: be 43 ce c5 9d 4f d1 26 68 ff ff ff 00 ff 00 ff    ?C???O?&h.......
> 30: 00 ff 00 ff 00 ff 00 ff 00 50 4b f0 f0 f0 d4 22    .........PK????"
> 40: 23 00 00 e3 7f ff ff bb 2f 13 73 c3 5f ff 80 5c    #..??..?/?s?_.?\
> 50: ff ff ff ff ff ff ff ff 7a 30 ff bb bb c1 05 7f    ........z0.?????
> 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 80: 01 08 01 0f 3f 3c 3c 00 a8 a8 ff ff 3c 3c 0a 0a    ?????<<.??..<<??
> 90: 19 00 00 01 09 ff 28 00 98 ff 3c 00 ff 01 01 ff    ?..??.(.?.<..??.
> a0: 01 01 01 28 0d 69 8f ff 3c c0 00 e0 ff ff 00 00    ???(?i?.<?.?....
> b0: d0 c5 ff ff ff 00 ff 00 ff ff ff f0 f0 f0 12 ff    ??.........????.
> c0: f8 00 00 4b 00 50 00 ff 2a 00 00 4b 00 50 00 ff    ?..K.P..*..K.P..
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: bd bd ac 46 50 5a 46 50 5a 32 3c 46 ff ff ff ff    ???FPZFPZ2<F....
> f0: ff ff 80 ff 00 01 00 51 ff 02 ff 00 00 00 00 ff    ..?..?.Q.?......
> [root@ ~]# i2cdump 0 0x50 c
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x50, mode byte consecutive read
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: ff ac 00 07 0c 0a 01 48 00 04 75 75 02 80 08 08    .?.????H.?uu????
> 10: 01 0e 04 0c 01 02 26 00 a0 75 00 00 50 3c 50 30    ??????&.?u..P<P0
> 20: 20 ac 00 50 50 00 00 00 00 00 41 4b 30 32 75 00     ?.PP.....AK02u.
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 40: 1a ac 00 00 00 00 00 00 bb ff 00 00 00 00 00 00    ??......?.......
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 60: 00 ac 00 00 00 00 00 00 00 00 00 00 00 00 00 00    .?..............
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: 00 ac 00 ff ff ff ff ff ff ff ff ff ff ff ff ff    .?..............
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> a0: ff ac 00 ff ff ff ff ff ff ff ff ff ff ff ff ff    .?..............
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> c0: ff ac 00 ff ff ff ff ff ff ff ff ff ff ff ff ff    .?..............
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: ff ac 00 ac ff ff ff ff ff ff ff ff ff ff ff ff    .?.?............
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
>
> [root@ ~]# modprobe eeprom
> [root@ ~]# sensors
> eeprom-i2c-0-51
> Adapter: SMBus ALi 1563 Adapter @ 5000
> Memory type:            DDR SDRAM DIMM
> Memory size (MB):       128
>
> eeprom-i2c-0-50
> Adapter: SMBus ALi 1563 Adapter @ 5000
> Unknown EEPROM type (0)
>
> Thanks
> Best Regards
> Chunhao
>
>
>
> > -----Original Message-----
> > From: Rudolf Marek [mailto:R.Marek@sh.cvut.cz]
> > Sent: 2005???4???7??? 15:28
> > To: PI14 HUANG0
> > Cc: R.Marek@sh.cvut.cz; sensors@Stimpy.netroedge.com; PI10 LHHsu; PI14 DZSHEN
> > Subject: RE: We will port w83792d.c to linux-2.6
> >
> >
> > Hello,
> >
> > Please can you repeat your tests? Debug messages are empty.
> >
> > I would prefer following without loading the eeprom driver and hwmon chip
> > driver.
> >
> > i2cdump 0 0x50
> > i2cdump 0 0x50 c
> > i2cdump 0 0x51 c
> > i2cdump 0 0x51
> > i2cdump 0 0x2f
> > i2cdump 0 0x50 c
> >
> > Thanks
> >
> > Regards
> >
> > Rudolf
> >
> >
> >
> > On Thu, 7 Apr 2005 Huang0@Winbond.com.tw wrote:
> >
> > > Hi Rudolf
> > >
> > > I tried to add the mask, but only one of the DDR memory can be found,
> > > The other one still can NOT be found! Please check the attached log messages
> > > and the dump result below.
> > > [root@ /usr/src/linux]# i2cdump 0 0x50   --> refer to attached message1
> > > [root@ /usr/src/linux]# i2cdump 0 0x50 c   --> refer to attached message2
> > > [root@ /usr/src/linux]# i2cdump 0 0x50   --> refer to attached message3
> > > [root@ /usr/src/linux]# modprobe eeprom
> > > [root@ /usr/src/linux]# sensors   --> refer to attached message4
> > > [root@ /usr/src/linux]# modprobe w83792d
> > > [root@ /usr/src/linux]# sensors   --> refer to attached message5
> > >
> > >
> > > Thanks
> > > Best Regards
> > > Chunhao
> > >
> > >
> > > ++++++++++++++   detailed dump result  +++++++++++++++++++++++++++++++
> > > [root@ /usr/src/linux]# lsmod|grep i2c
> > > i2c_dev                12800  0
> > > i2c_ali1563             8452  0
> > > i2c_core               25728  2 i2c_dev,i2c_ali1563
> > > [root@ /usr/src/linux]# i2cdump 0 0x50   --> refer to attached message1
> > > No size specified (using byte-data access)
> > > WARNING! This program can confuse your I2C bus, cause data loss and worse!
> > > I will probe file /dev/i2c-0, address 0x50, mode byte
> > > Continue? [Y/n]
> > >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> > > 00: ac 00 07 0c 0a 01 48 00 04 75 75 02 80 08 08 01    ?.????H.?uu?????
> > > 10: 0e 04 0c 01 02 26 00 a0 75 00 00 50 3c 50 30 20    ?????&.?u..P<P0
> > > 20: ac 00 50 50 00 00 00 00 00 41 4b 30 32 75 00 00    ?.PP.....AK02u..
> > > 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1a    ...............?
> > > 40: ac 00 00 00 00 00 00 bb ff 00 00 00 00 00 00 00    ?......?........
> > > 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > > 60: ac 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ?...............
> > > 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > > 80: ac 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
> > > 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > > a0: ac 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
> > > b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > > c0: ac 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
> > > d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > > e0: ac 00 ac ff ff ff ff ff ff ff ff ff ff ff ff ff    ?.?.............
> > > f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > > [root@ /usr/src/linux]# i2cdump 0 0x50 c   --> refer to attached message2
> > > WARNING! This program can confuse your I2C bus, cause data loss and worse!
> > > I will probe file /dev/i2c-0, address 0x50, mode byte consecutive read
> > > Continue? [Y/n]
> > >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> > > 00: ff ac 00 07 0c 0a 01 48 00 04 75 75 02 80 08 08    .?.????H.?uu????
> > > 10: 01 0e 04 0c 01 02 26 00 a0 75 00 00 50 3c 50 30    ??????&.?u..P<P0
> > > 20: 20 ac 00 50 50 00 00 00 00 00 41 4b 30 32 75 00     ?.PP.....AK02u.
> > > 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > > 40: 1a ac 00 00 00 00 00 00 bb ff 00 00 00 00 00 00    ??......?.......
> > > 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > > 60: 00 ac 00 00 00 00 00 00 00 00 00 00 00 00 00 00    .?..............
> > > 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > > 80: 00 ac 00 ff ff ff ff ff ff ff ff ff ff ff ff ff    .?..............
> > > 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > > a0: ff ac 00 ff ff ff ff ff ff ff ff ff ff ff ff ff    .?..............
> > > b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > > c0: ff ac 00 ff ff ff ff ff ff ff ff ff ff ff ff ff    .?..............
> > > d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > > e0: ff ac 00 ac ff ff ff ff ff ff ff ff ff ff ff ff    .?.?............
> > > f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > > [root@ /usr/src/linux]# i2cdump 0 0x50   --> refer to attached message3
> > > No size specified (using byte-data access)
> > > WARNING! This program can confuse your I2C bus, cause data loss and worse!
> > > I will probe file /dev/i2c-0, address 0x50, mode byte
> > > Continue? [Y/n]
> > >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> > > 00: ac 00 07 0c 0a 01 48 00 04 75 75 02 80 08 08 01    ?.????H.?uu?????
> > > 10: 0e 04 0c 01 02 26 00 a0 75 00 00 50 3c 50 30 20    ?????&.?u..P<P0
> > > 20: ac 00 50 50 00 00 00 00 00 41 4b 30 32 75 00 00    ?.PP.....AK02u..
> > > 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1a    ...............?
> > > 40: ac 00 00 00 00 00 00 bb ff 00 00 00 00 00 00 00    ?......?........
> > > 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > > 60: ac 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ?...............
> > > 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > > 80: ac 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
> > > 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > > a0: ac 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
> > > b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > > c0: ac 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
> > > d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > > e0: ac 00 ac ff ff ff ff ff ff ff ff ff ff ff ff ff    ?.?.............
> > > f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > > [root@ /usr/src/linux]# modprobe eeprom
> > > [root@ /usr/src/linux]# sensors   --> refer to attached message4
> > > eeprom-i2c-0-51
> > > Adapter: SMBus ALi 1563 Adapter @ 5000
> > > Memory type:            DDR SDRAM DIMM
> > > Memory size (MB):       128
> > >
> > > eeprom-i2c-0-50
> > > Adapter: SMBus ALi 1563 Adapter @ 5000
> > > Unknown EEPROM type (0)
> > >
> > > [root@ /usr/src/linux]# modprobe w83792d
> > > [root@ /usr/src/linux]# sensors   --> refer to attached message5
> > > w83792d-i2c-0-2f
> > > Adapter: SMBus ALi 1563 Adapter @ 5000
> > > VCoreA:    +1.53 V  (min =  +0.00 V, max =  +1.78 V)
> > > VCoreB:    +0.54 V  (min =  +0.00 V, max =  +1.78 V)
> > > VIN0:      +3.30 V  (min =  +0.00 V, max =  +4.08 V)
> > > VIN1:      +3.17 V  (min =  +0.00 V, max =  +4.08 V)
> > > VIN2:      +2.52 V  (min =  +0.00 V, max =  +4.08 V)
> > > VIN3:      +1.26 V  (min =  +0.00 V, max =  +4.08 V)
> > > 5VCC:      +5.03 V  (min =  +0.00 V, max =  +6.12 V)
> > > 5VSB:      +4.99 V  (min =  +0.00 V, max =  +6.12 V)
> > > VBAT:      +3.15 V  (min =  +0.00 V, max =  +4.08 V)
> > > Fan1:     1622 RPM  (min =  703 RPM, div = 8)
> > > Fan2:        0 RPM  (min =  703 RPM, div = 8)
> > > Fan3:        0 RPM  (min =  703 RPM, div = 8)
> > > Fan4:        0 RPM  (min =  703 RPM, div = 8)
> > > Fan5:        0 RPM  (min =  703 RPM, div = 8)
> > > Fan6:        0 RPM  (min =  703 RPM, div = 8)
> > > Fan7:     37500 RPM  (min =    0 RPM, div = 2)
> > > Temp1:     +37.0?????????C  (high = +80.0?????????C, hyst = +75.0?????????C)   ALARM
> > > Temp2:      -8.0?????????C  (high = +80.0?????????C, hyst = +75.0?????????C)   ALARM
> > > Temp3:     +41.0?????????C  (high = +80.0?????????C, hyst = +75.0?????????C)   ALARM
> > > chassis:  Chassis is normal.
> > >
> > > eeprom-i2c-0-51
> > > Adapter: SMBus ALi 1563 Adapter @ 5000
> > > Memory type:            DDR SDRAM DIMM
> > > Memory size (MB):       128
> > >
> > > eeprom-i2c-0-50
> > > Adapter: SMBus ALi 1563 Adapter @ 5000
> > > Unknown EEPROM type (0)
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Rudolf Marek [mailto:R.Marek@sh.cvut.cz]
> > > > Sent: 2005??????4??????7??????? 00:30
> > > > To: PI14 HUANG0
> > > > Cc: sensors@Stimpy.netroedge.com; PI10 LHHsu; PI14 DZSHEN
> > > > Subject: RE: We will port w83792d.c to linux-2.6
> > > >
> > > > Hello all,
> > > >
> > > > How could this EVER worked????!!!!
> > > >
> > > > outb_p(inb_p(SMB_HST_CNTL2) | (size << 3), SMB_HST_CNTL2);
> > > > MASK is missing !!!!
> > > >
> > > > Please can you add to your driver this?
> > > >
> > > > #define HST_CNTL2_SIZEMASK 0x38
> > > >
> > > > outb_p( (inb_p(SMB_HST_CNTL2)&~HST_CNTL2_SIZEMASK) | (size << 3),
> > > > SMB_HST_CNTL2);
> > > >
> > > > I think then it should work.
> > > >
> > > > i2cdump 0 0x50
> > > > i2cdump 0 0x50 c
> > > > i2cdump 0 0x50
> > > >
> > > > and also
> > > >
> > > > modprobe eeprom
> > > > sensors
> > > >
> > > >
> > > > Regards
> > > >
> > > > Rudolf
> > >
> > =====================================
> > =========The privileged confidential information contained in this
> > email is intended for use only by the addressees as indicated by the original
> > author of this email. If you are not the addressee indicated in this email or
> > are not responsible for delivery of the email to such person, please kindly
> > reply the sender indicating accordingly and delete all copies of it from your
> > computer and network server immediately. We thank you for your cooperation.
> > It is advisable that any unauthorized use of confidential information of
> > Winbond is strictly prohibited; and any information in this email that does
> > not relate to the official business of Winbond shall be deemed as neither given
> > nor endorsed by
> > Winbond.=================================
> > =============If your computer is unable to decode Chinese font,
> > please ignore the following message. They essentially repeat the&nbsp; English
> > statement above.??????H??????????????t??????????q??l??????]?????????????
K??????????T,
> > ?????
????v??????o??H??H??????w??????????H??H??????\????????.
> > ?????????
z??????D??Q??????w??????????H??H??????]??????????????]??b??????g?
????v?????
????????????U??????????????
> > H????, ?????
z??i??????????o??H??H??????????Y?
N??H?????
q??q??????P??????????????A??????????????H????????.
> > ?????????
z??????X??@, ??????????????????P????. ??S????????????,
> > ??????????????g?
????v??????????????????????????q??l?????????
K??????T??????????????O??Q??Y??????T????????.
> > ??H??????P??????????q??l??????~??L??????????????e,?????
o??????????????????q??l??????????????????N????.
> > >
>
==============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original author of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such person, please kindly reply the sender indicating accordingly and delete all copies of it from your computer and network server immediately. We thank you for your cooperation. It is advisable that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email that does not relate to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.==============================================If your computer is unable to decode Chinese font, please ignore the following message. They essentially repea!
 t the&nbsp; English statement above.???H???????t?????q?l???]???????K?????T, ?????v???o?H?H???w?????H?H???\????. ?????z???D?Q???w?????H?H???]???????]?b???g???v?????????U???????H??, ???z?i?????o?H?H?????Y?N?H???q?q???P???????A???????H????. ?????z???X?@, ?????????P??. ?S??????, ???????g???v?????????????q?l?????K???T???????O?Q?Y???T????. ?H???P?????q?l???~?L???????e,???o?????????q?l?????????N??.
>
