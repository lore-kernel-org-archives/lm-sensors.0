From: Huang0@Winbond.com.tw (Huang0@Winbond.com.tw)
Date: Thu, 19 May 2005 06:25:49 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE36FB19@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Rudolf

Great! It seems that you find out the reason, the eeprom module works well.
The attachment is the debug message. Please check it.

   i2cdump 0 0x50   --> message1
   i2cdump 0 0x50 c  --> message2
   modprobe eeprom    --> message3
   sensors
   modprobe w83792d    --> message4
   sensors             --> message5

   i2cdump 0 0x50 w  --> message6
   i2cdump 0 0x50 c  --> message7


The following is the dump output:
[root@ ~]# i2cdump 0 0x50
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x50, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ac ff 07 0c 0a 01 48 00 04 75 75 02 80 08 08 01    ?.????H.?uu?????
10: 0e 04 0c 01 02 26 00 a0 75 00 00 50 3c 50 30 20    ?????&.?u..P<P0
20: 00 00 50 50 00 00 00 00 00 41 4b 30 32 75 00 00    ..PP.....AK02u..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1a    ...............?
40: 80 00 00 00 00 00 00 bb ff 00 00 00 00 00 00 00    ?......?........
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 80 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: 80 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: 00 00 ac ff ff ff ff ff ff ff ff ff ff ff ff ff    ..?.............
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
[root@ ~]# i2cdump 0 0x50 c
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x50, mode byte consecutive read
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ac ff 07 0c 0a 01 48 00 04 75 75 02 80 08 08 01    ?.????H.?uu?????
10: 0e 04 0c 01 02 26 00 a0 75 00 00 50 3c 50 30 20    ?????&.?u..P<P0
20: 00 00 50 50 00 00 00 00 00 41 4b 30 32 75 00 00    ..PP.....AK02u..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1a    ...............?
40: 80 00 00 00 00 00 00 bb ff 00 00 00 00 00 00 00    ?......?........
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 80 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: 80 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: 00 00 ac ff ff ff ff ff ff ff ff ff ff ff ff ff    ..?.............
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
[root@ ~]# modprobe eeprom
[root@ ~]# sensors
eeprom-i2c-0-51
Adapter: SMBus ALi 1563 Adapter @ 5000
Memory type:            DDR SDRAM DIMM
Memory size (MB):       128

eeprom-i2c-0-50
Adapter: SMBus ALi 1563 Adapter @ 5000
Memory type:            DDR SDRAM DIMM
Memory size (MB):       128

[root@ ~]# modprobe w83792d
[root@ ~]# sensors
w83792d-i2c-0-2f
Adapter: SMBus ALi 1563 Adapter @ 5000
VCoreA:    +1.52 V  (min =3D  +0.00 V, max =3D  +1.78 V)
VCoreB:    +0.54 V  (min =3D  +0.00 V, max =3D  +1.78 V)
VIN0:      +3.30 V  (min =3D  +0.00 V, max =3D  +4.08 V)
VIN1:      +3.15 V  (min =3D  +0.00 V, max =3D  +4.08 V)
VIN2:      +2.52 V  (min =3D  +0.00 V, max =3D  +4.08 V)
VIN3:      +1.26 V  (min =3D  +0.00 V, max =3D  +4.08 V)
5VCC:      +5.03 V  (min =3D  +0.00 V, max =3D  +6.12 V)
5VSB:      +4.99 V  (min =3D  +0.00 V, max =3D  +6.12 V)
VBAT:      +3.18 V  (min =3D  +0.00 V, max =3D  +4.08 V)
Fan1:     1638 RPM  (min =3D  703 RPM, div =3D 8)
Fan2:        0 RPM  (min =3D  703 RPM, div =3D 8)
Fan3:        0 RPM  (min =3D  703 RPM, div =3D 8)
Fan4:        0 RPM  (min =3D  703 RPM, div =3D 8)
Fan5:        0 RPM  (min =3D  703 RPM, div =3D 8)
Fan6:        0 RPM  (min =3D  703 RPM, div =3D 8)
Fan7:     37500 RPM  (min =3D    0 RPM, div =3D 2)
Temp1:     +38.0??C  (high =3D +80.0??C, hyst =3D +75.0??C)   ALARM
Temp2:      -8.0??C  (high =3D +80.0??C, hyst =3D +75.0??C)   ALARM
Temp3:     +42.0??C  (high =3D +80.0??C, hyst =3D +75.0??C)   ALARM
chassis:  Chassis is normal.

eeprom-i2c-0-51
Adapter: SMBus ALi 1563 Adapter @ 5000
Memory type:            DDR SDRAM DIMM
Memory size (MB):       128

eeprom-i2c-0-50
Adapter: SMBus ALi 1563 Adapter @ 5000
Memory type:            DDR SDRAM DIMM
Memory size (MB):       128


[root@ ~]# i2cdump 0 0x50 w
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x50, mode word
Continue? [Y/n]
     0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
00: ffac 07ff 0c07 0a0c 010a 4801 0048 0400
08: 7504 7575 0275 8002 0880 0808 0108 0e01
10: 040e 0c04 010c 0201 2602 0026 a000 75a0
18: 0075 0000 5000 3c50 503c 3050 2030 0020
20: 0000 5000 5050 0050 0000 0000 0000 0000
28: 4100 4b41 304b 3230 7532 0075 0000 0000
30: 0000 0000 0000 0000 0000 0000 0000 0000
38: 0000 0000 0000 0000 0000 0000 1a00 801a
40: 0080 0000 0000 0000 0000 0000 bb00 ffbb
48: 00ff 0000 0000 0000 0000 0000 0000 0000
50: 0000 0000 0000 0000 0000 0000 0000 0000
58: 0000 0000 0000 0000 0000 0000 0000 0000
60: 0000 0000 0000 0000 0000 0000 0000 0000
68: 0000 0000 0000 0000 0000 0000 0000 0000
70: 0000 0000 0000 0000 0000 0000 0000 0000
78: 0000 0000 0000 0000 0000 0000 0000 8000
80: 0080 ff00 ffff ffff ffff ffff ffff ffff
88: ffff ffff ffff ffff ffff ffff ffff ffff
90: ffff ffff ffff ffff ffff ffff ffff ffff
98: ffff ffff ffff ffff ffff ffff ffff 00ff
a0: 0000 ff00 ffff ffff ffff ffff ffff ffff
a8: ffff ffff ffff ffff ffff ffff ffff ffff
b0: ffff ffff ffff ffff ffff ffff ffff ffff
b8: ffff ffff ffff ffff ffff ffff ffff 80ff
c0: 0080 ff00 ffff ffff ffff ffff ffff ffff
c8: ffff ffff ffff ffff ffff ffff ffff ffff
d0: ffff ffff ffff ffff ffff ffff ffff ffff
d8: ffff ffff ffff ffff ffff ffff ffff 00ff
e0: 0000 ac00 ffac ffff ffff ffff ffff ffff
e8: ffff ffff ffff ffff ffff ffff ffff ffff
f0: ffff ffff ffff ffff ffff ffff ffff ffff
f8: ffff ffff ffff ffff ffff ffff ffff acff
[root@ ~]# i2cdump 0 0x50 c
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x50, mode byte consecutive read
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ac ff 07 0c 0a 01 48 00 04 75 75 02 80 08 08 01    ?.????H.?uu?????
10: 0e 04 0c 01 02 26 00 a0 75 00 00 50 3c 50 30 20    ?????&.?u..P<P0
20: 00 00 50 50 00 00 00 00 00 41 4b 30 32 75 00 00    ..PP.....AK02u..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1a    ...............?
40: 80 00 00 00 00 00 00 bb ff 00 00 00 00 00 00 00    ?......?........
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 80 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: 80 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: 00 00 ac ff ff ff ff ff ff ff ff ff ff ff ff ff    ..?.............
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
[root@ ~]# rmmod w83792d
[root@ ~]# rmmod eeprom
[root@ ~]# modprobe w83792d
[root@ ~]# modprobe eeprom
[root@ ~]# sensors
eeprom-i2c-0-51
Adapter: SMBus ALi 1563 Adapter @ 5000
Memory type:            DDR SDRAM DIMM
Memory size (MB):       128

eeprom-i2c-0-50
Adapter: SMBus ALi 1563 Adapter @ 5000
Memory type:            DDR SDRAM DIMM
Memory size (MB):       128

w83792d-i2c-0-2f
Adapter: SMBus ALi 1563 Adapter @ 5000
VCoreA:    +1.52 V  (min =3D  +0.00 V, max =3D  +1.78 V)
VCoreB:    +0.54 V  (min =3D  +0.00 V, max =3D  +1.78 V)
VIN0:      +3.30 V  (min =3D  +0.00 V, max =3D  +4.08 V)
VIN1:      +3.16 V  (min =3D  +0.00 V, max =3D  +4.08 V)
VIN2:      +2.52 V  (min =3D  +0.00 V, max =3D  +4.08 V)
VIN3:      +1.26 V  (min =3D  +0.00 V, max =3D  +4.08 V)
5VCC:      +5.03 V  (min =3D  +0.00 V, max =3D  +6.12 V)
5VSB:      +4.99 V  (min =3D  +0.00 V, max =3D  +6.12 V)
VBAT:      +3.15 V  (min =3D  +0.00 V, max =3D  +4.08 V)
Fan1:     1638 RPM  (min =3D  703 RPM, div =3D 8)
Fan2:        0 RPM  (min =3D  703 RPM, div =3D 8)
Fan3:        0 RPM  (min =3D  703 RPM, div =3D 8)
Fan4:        0 RPM  (min =3D  703 RPM, div =3D 8)
Fan5:        0 RPM  (min =3D  703 RPM, div =3D 8)
Fan6:        0 RPM  (min =3D  703 RPM, div =3D 8)
Fan7:     37500 RPM  (min =3D    0 RPM, div =3D 2)
Temp1:     +38.0??C  (high =3D +80.0??C, hyst =3D +75.0??C)   ALARM
Temp2:      -8.0??C  (high =3D +80.0??C, hyst =3D +75.0??C)   ALARM
Temp3:     +42.0??C  (high =3D +80.0??C, hyst =3D +75.0??C)   ALARM
chassis:  Chassis is normal.

Thanks
Best Regards
Chunhao



> -----Original Message-----
> From: Rudolf Marek [mailto:R.Marek@sh.cvut.cz]
> Sent: 2005?4?8? 02:02
> To: PI14 HUANG0
> Cc: R.Marek@sh.cvut.cz; sensors@Stimpy.netroedge.com; PI10 LHHsu; PI14 DZ=
SHEN
> Subject: RE: We will port w83792d.c to linux-2.6
>=20
> hello,
>=20
> I think I have a solution (after some hours of work).
>=20
> First how "continous reads works"- READ_BYTE. It is good for eeprom
> reading, first you write to command register offset from which you want to
> start reading and next you read and read and read data. (in READ_BYTE_DATA
> mode you must write offset, get data, write offset+1, get data etc)
>=20
> problem: it seems that for BYTE mode readings do not start at correct
> 	 location
>=20
> The shift  by one byte we observed can be explained that we start reading
> at offset FF instead of from 00 as requested.
>=20
> Why after modprobe decoding of memory type works?
>=20
> I concluded from docs I was wrong, the problem does not depend on "older
> value of CMD".
>=20
> It seems it depends on value of some other register.
>=20
> it can be spotted right here:
>=20
> size is I2C_SMBUS_BYTE!
> size is HST_CNTL2_BYTE!
> rw =3D I2C_SMBUS_WRITE!
> Transaction (pre): STS=00, CNTL1=00, CNTL2=08, CMD@, ADD=A2, DAT0=1A,
> DAT1=00
> Transaction (post): STSB, CNTL1=00, CNTL2=08, CMD@, ADD=A2, DAT0=1A,
> DAT1=00
>=20
> This requests to read in I2C_SMBUS_BYTE from offset 0x40, offset 0x40 is
> filled to CMD REG (even before transaction because it is done in access
> routine)
>=20
> Now what we got when reading first byte:
>=20
> Transaction (pre): STS=00, CNTL1=00, CNTL2=08, CMD@, ADD=A3, DAT0=1A,
> DAT1=00
> Transaction (post): STSB, CNTL1=00, CNTL2=08, CMD@, ADD=A3, DAT0=00,
> DAT1=00
>=20
> Transaction (pre): STS=00, CNTL1=00, CNTL2=08, CMD@, ADD=A3, DAT0=00,
> DAT1=00
> Transaction (post): STSB, CNTL1=00, CNTL2=08, CMD@, ADD=A3, DAT0P,
> DAT1=00
>=20
> Transaction (pre): STS=00, CNTL1=00, CNTL2=08, CMD@, ADD=A3, DAT0P,
> DAT1=00
> Transaction (post): STSB, CNTL1=00, CNTL2=08, CMD@, ADD=A3, DAT0<,
> DAT1=00
>=20
> In DAT0 are results so we get 00 50 3C...
> But expected content is 80 00 00 00 ...
>=20
> BUT if you take a look to the dump you can find this sequence at address
> 0x1A.  00 50 3c 50 30 20
>=20
> And guess what were was the value 0x1A present?
>=20
> Transaction (pre): STS=00, CNTL1=00, CNTL2=08, CMD@, ADD=A2, DAT0=1A,
> DAT1=00
>=20
> Yes it was in DAT0 register. So this ALI thing is putting the command not
> to the CMD reg but it takes it from DAT0 register!!!!!!!!
> (intel and others are putting command to cmd register)
>=20
> So what we need now:
>=20
> 1) test the driver with following change:
>            case HST_CNTL2_BYTE:
>                dev_err(&a->dev, "size is HST_CNTL2_BYTE!\n");
>                 if (rw=3D I2C_SMBUS_WRITE)
>                         outb_p(cmd, SMB_HST_CMD);
>=20
>    and replace please last line with  outb_p(cmd, SMB_HST_DAT0);
>=20
>=20
>    now you can run
>    i2cdump 0 0x50
>    i2cdump 0 0x50 c
>    modprobe eeprom
>    sensors
>    modprobe w...
>    sensors
>=20
>    all should work now (please test also with your chip driver loaded as
>    you reported in your previous email)
>=20
> 2) ask ALI if this is a bug or feature.
> 3) test the rest modes, WORD mode, please
>    can you test (I dont know how the result should look like)
>=20
>    i2cdump 0 0x50 w
>    i2cdump 0 0x50 c
>=20
> Regards
>=20
> Rudolf
>=20
> > [root@ ~]# i2cdump 0 0x51
> > No size specified (using byte-data access)
> > WARNING! This program can confuse your I2C bus, cause data loss and wor=
se!
> > I will probe file /dev/i2c-0, address 0x51, mode byte
> > Continue? [Y/n]
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> > 00: ac ff 07 0c 0a 01 48 00 04 75 75 02 80 08 08 01    ?.????H.?uu?????
> > 10: 0e 04 0c 01 02 26 00 a0 75 00 00 50 3c 50 30 20    ?????&.?u..P<P0
> > 20: 00 00 50 50 00 00 00 00 00 41 4b 30 32 75 00 00    ..PP.....AK02u..
> > 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1a    ...............?
> > 40: 80 00 00 00 00 00 00 bb ff 00 00 00 00 00 00 00    ?......?........
> > 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 80: 80 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
> > 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > a0: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > c0: 80 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
> > d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > e0: 00 00 ac ff ff ff ff ff ff ff ff ff ff ff ff ff    ..?.............
> > f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
-------------- next part --------------
A non-text attachment was scrubbed...
Name: debug_log.tar.gz
Type: application/x-gzip
Size: 148417 bytes
Desc: debug_log.tar.gz
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050408=
/46f15c9d/debug_log.tar.gz
