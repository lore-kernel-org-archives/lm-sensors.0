From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:49 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <Pine.LNX.4.58.0504080802230.21101@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,

Those are from I2C_QUICK when detecting presence of chips (for example
addresses 0x52, 0x53, ... and 0x2d, 0x2e...)
(possible locations of eeproms and other chips) This messages are only
informative, although I do not remember how they are treated in rest of
drivers?

Khali should it be dev_warn of dev_dbg ?

Thanks

regards

Rudolf

On Fri, 8 Apr 2005 Huang0@Winbond.com.tw wrote:

> Hi Rudolf
>
> There are always some "Device error!" messages(7 times) printed on the sc=
reen
> when I load eeprom module after the i2c-ali1563 has been loaded.
> These codes in i2c-ali1563 are the reason:
>         /* device error - probably missing ACK */
>         if (data & HST_STS_DEVERR) {
>                 dev_warn(&a->dev, "Device error!\n");
>         }
>
> You may check the log message in previous mails, maybe it is normal. But
> don't you think these "Device error!" messages should NOT be printed?
> Because eeprom module works well, so do w83792d modules(there are also su=
ch
> messages, maybe 3 times or once)
>
> Best Regards
> Chunhao
>
>
> > -----Original Message-----
> > From: PI14 HUANG0
> > Sent: 2005=E5=B9=B44=E6=9C=888=E6=97=A5 09:38
> > To: 'Rudolf Marek'
> > Cc: sensors@Stimpy.netroedge.com; PI10 LHHsu; PI14 DZSHEN
> > Subject: RE: We will port w83792d.c to linux-2.6
> >
> > Hi Rudolf
> >
> > Great! It seems that you find out the reason, the eeprom module works w=
ell.
> > The attachment is the debug message. Please check it.
> >
> >    i2cdump 0 0x50   --> message1
> >    i2cdump 0 0x50 c  --> message2
> >    modprobe eeprom    --> message3
> >    sensors
> >    modprobe w83792d    --> message4
> >    sensors             --> message5
> >
> >    i2cdump 0 0x50 w  --> message6
> >    i2cdump 0 0x50 c  --> message7
> >
> >
> > The following is the dump output:
> > [root@ ~]# i2cdump 0 0x50
> > No size specified (using byte-data access)
> > WARNING! This program can confuse your I2C bus, cause data loss and wor=
se!
> > I will probe file /dev/i2c-0, address 0x50, mode byte
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
> > [root@ ~]# i2cdump 0 0x50 c
> > WARNING! This program can confuse your I2C bus, cause data loss and wor=
se!
> > I will probe file /dev/i2c-0, address 0x50, mode byte consecutive read
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
> > [root@ ~]# modprobe eeprom
> > [root@ ~]# sensors
> > eeprom-i2c-0-51
> > Adapter: SMBus ALi 1563 Adapter @ 5000
> > Memory type:            DDR SDRAM DIMM
> > Memory size (MB):       128
> >
> > eeprom-i2c-0-50
> > Adapter: SMBus ALi 1563 Adapter @ 5000
> > Memory type:            DDR SDRAM DIMM
> > Memory size (MB):       128
> >
> > [root@ ~]# modprobe w83792d
> > [root@ ~]# sensors
> > w83792d-i2c-0-2f
> > Adapter: SMBus ALi 1563 Adapter @ 5000
> > VCoreA:    +1.52 V  (min =3D  +0.00 V, max =3D  +1.78 V)
> > VCoreB:    +0.54 V  (min =3D  +0.00 V, max =3D  +1.78 V)
> > VIN0:      +3.30 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> > VIN1:      +3.15 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> > VIN2:      +2.52 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> > VIN3:      +1.26 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> > 5VCC:      +5.03 V  (min =3D  +0.00 V, max =3D  +6.12 V)
> > 5VSB:      +4.99 V  (min =3D  +0.00 V, max =3D  +6.12 V)
> > VBAT:      +3.18 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> > Fan1:     1638 RPM  (min =3D  703 RPM, div =3D 8)
> > Fan2:        0 RPM  (min =3D  703 RPM, div =3D 8)
> > Fan3:        0 RPM  (min =3D  703 RPM, div =3D 8)
> > Fan4:        0 RPM  (min =3D  703 RPM, div =3D 8)
> > Fan5:        0 RPM  (min =3D  703 RPM, div =3D 8)
> > Fan6:        0 RPM  (min =3D  703 RPM, div =3D 8)
> > Fan7:     37500 RPM  (min =3D    0 RPM, div =3D 2)
> > Temp1:     +38.0=C3=82=C2=B0C  (high =3D +80.0=C3=82=C2=B0C, hyst =3D +=
75.0=C3=82=C2=B0C)   ALARM
> > Temp2:      -8.0=C3=82=C2=B0C  (high =3D +80.0=C3=82=C2=B0C, hyst =3D +=
75.0=C3=82=C2=B0C)   ALARM
> > Temp3:     +42.0=C3=82=C2=B0C  (high =3D +80.0=C3=82=C2=B0C, hyst =3D +=
75.0=C3=82=C2=B0C)   ALARM
> > chassis:  Chassis is normal.
> >
> > eeprom-i2c-0-51
> > Adapter: SMBus ALi 1563 Adapter @ 5000
> > Memory type:            DDR SDRAM DIMM
> > Memory size (MB):       128
> >
> > eeprom-i2c-0-50
> > Adapter: SMBus ALi 1563 Adapter @ 5000
> > Memory type:            DDR SDRAM DIMM
> > Memory size (MB):       128
> >
> >
> > [root@ ~]# i2cdump 0 0x50 w
> > WARNING! This program can confuse your I2C bus, cause data loss and wor=
se!
> > I will probe file /dev/i2c-0, address 0x50, mode word
> > Continue? [Y/n]
> >      0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
> > 00: ffac 07ff 0c07 0a0c 010a 4801 0048 0400
> > 08: 7504 7575 0275 8002 0880 0808 0108 0e01
> > 10: 040e 0c04 010c 0201 2602 0026 a000 75a0
> > 18: 0075 0000 5000 3c50 503c 3050 2030 0020
> > 20: 0000 5000 5050 0050 0000 0000 0000 0000
> > 28: 4100 4b41 304b 3230 7532 0075 0000 0000
> > 30: 0000 0000 0000 0000 0000 0000 0000 0000
> > 38: 0000 0000 0000 0000 0000 0000 1a00 801a
> > 40: 0080 0000 0000 0000 0000 0000 bb00 ffbb
> > 48: 00ff 0000 0000 0000 0000 0000 0000 0000
> > 50: 0000 0000 0000 0000 0000 0000 0000 0000
> > 58: 0000 0000 0000 0000 0000 0000 0000 0000
> > 60: 0000 0000 0000 0000 0000 0000 0000 0000
> > 68: 0000 0000 0000 0000 0000 0000 0000 0000
> > 70: 0000 0000 0000 0000 0000 0000 0000 0000
> > 78: 0000 0000 0000 0000 0000 0000 0000 8000
> > 80: 0080 ff00 ffff ffff ffff ffff ffff ffff
> > 88: ffff ffff ffff ffff ffff ffff ffff ffff
> > 90: ffff ffff ffff ffff ffff ffff ffff ffff
> > 98: ffff ffff ffff ffff ffff ffff ffff 00ff
> > a0: 0000 ff00 ffff ffff ffff ffff ffff ffff
> > a8: ffff ffff ffff ffff ffff ffff ffff ffff
> > b0: ffff ffff ffff ffff ffff ffff ffff ffff
> > b8: ffff ffff ffff ffff ffff ffff ffff 80ff
> > c0: 0080 ff00 ffff ffff ffff ffff ffff ffff
> > c8: ffff ffff ffff ffff ffff ffff ffff ffff
> > d0: ffff ffff ffff ffff ffff ffff ffff ffff
> > d8: ffff ffff ffff ffff ffff ffff ffff 00ff
> > e0: 0000 ac00 ffac ffff ffff ffff ffff ffff
> > e8: ffff ffff ffff ffff ffff ffff ffff ffff
> > f0: ffff ffff ffff ffff ffff ffff ffff ffff
> > f8: ffff ffff ffff ffff ffff ffff ffff acff
> > [root@ ~]# i2cdump 0 0x50 c
> > WARNING! This program can confuse your I2C bus, cause data loss and wor=
se!
> > I will probe file /dev/i2c-0, address 0x50, mode byte consecutive read
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
> > [root@ ~]# rmmod w83792d
> > [root@ ~]# rmmod eeprom
> > [root@ ~]# modprobe w83792d
> > [root@ ~]# modprobe eeprom
> > [root@ ~]# sensors
> > eeprom-i2c-0-51
> > Adapter: SMBus ALi 1563 Adapter @ 5000
> > Memory type:            DDR SDRAM DIMM
> > Memory size (MB):       128
> >
> > eeprom-i2c-0-50
> > Adapter: SMBus ALi 1563 Adapter @ 5000
> > Memory type:            DDR SDRAM DIMM
> > Memory size (MB):       128
> >
> > w83792d-i2c-0-2f
> > Adapter: SMBus ALi 1563 Adapter @ 5000
> > VCoreA:    +1.52 V  (min =3D  +0.00 V, max =3D  +1.78 V)
> > VCoreB:    +0.54 V  (min =3D  +0.00 V, max =3D  +1.78 V)
> > VIN0:      +3.30 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> > VIN1:      +3.16 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> > VIN2:      +2.52 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> > VIN3:      +1.26 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> > 5VCC:      +5.03 V  (min =3D  +0.00 V, max =3D  +6.12 V)
> > 5VSB:      +4.99 V  (min =3D  +0.00 V, max =3D  +6.12 V)
> > VBAT:      +3.15 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> > Fan1:     1638 RPM  (min =3D  703 RPM, div =3D 8)
> > Fan2:        0 RPM  (min =3D  703 RPM, div =3D 8)
> > Fan3:        0 RPM  (min =3D  703 RPM, div =3D 8)
> > Fan4:        0 RPM  (min =3D  703 RPM, div =3D 8)
> > Fan5:        0 RPM  (min =3D  703 RPM, div =3D 8)
> > Fan6:        0 RPM  (min =3D  703 RPM, div =3D 8)
> > Fan7:     37500 RPM  (min =3D    0 RPM, div =3D 2)
> > Temp1:     +38.0=C3=82=C2=B0C  (high =3D +80.0=C3=82=C2=B0C, hyst =3D +=
75.0=C3=82=C2=B0C)   ALARM
> > Temp2:      -8.0=C3=82=C2=B0C  (high =3D +80.0=C3=82=C2=B0C, hyst =3D +=
75.0=C3=82=C2=B0C)   ALARM
> > Temp3:     +42.0=C3=82=C2=B0C  (high =3D +80.0=C3=82=C2=B0C, hyst =3D +=
75.0=C3=82=C2=B0C)   ALARM
> > chassis:  Chassis is normal.
> >
> > Thanks
> > Best Regards
> > Chunhao
> >
> >
> >
> > > -----Original Message-----
> > > From: Rudolf Marek [mailto:R.Marek@sh.cvut.cz]
> > > Sent: 2005=E5=B9=B44=E6=9C=888=E6=97=A5 02:02
> > > To: PI14 HUANG0
> > > Cc: R.Marek@sh.cvut.cz; sensors@Stimpy.netroedge.com; PI10 LHHsu; PI14
> > DZSHEN
> > > Subject: RE: We will port w83792d.c to linux-2.6
> > >
> > > hello,
> > >
> > > I think I have a solution (after some hours of work).
> > >
> > > First how "continous reads works"- READ_BYTE. It is good for eeprom
> > > reading, first you write to command register offset from which you wa=
nt to
> > > start reading and next you read and read and read data. (in READ_BYTE=
_DATA
> > > mode you must write offset, get data, write offset+1, get data etc)
> > >
> > > problem: it seems that for BYTE mode readings do not start at correct
> > > 	 location
> > >
> > > The shift  by one byte we observed can be explained that we start rea=
ding
> > > at offset FF instead of from 00 as requested.
> > >
> > > Why after modprobe decoding of memory type works?
> > >
> > > I concluded from docs I was wrong, the problem does not depend on "ol=
der
> > > value of CMD".
> > >
> > > It seems it depends on value of some other register.
> > >
> > > it can be spotted right here:
> > >
> > > size is I2C_SMBUS_BYTE!
> > > size is HST_CNTL2_BYTE!
> > > rw =3D I2C_SMBUS_WRITE!
> > > Transaction (pre): STS=00, CNTL1=00, CNTL2=08, CMD@, ADD=A2, DAT0=1A,
> > > DAT1=00
> > > Transaction (post): STSB, CNTL1=00, CNTL2=08, CMD@, ADD=A2, DAT0=1A,
> > > DAT1=00
> > >
> > > This requests to read in I2C_SMBUS_BYTE from offset 0x40, offset 0x40=
 is
> > > filled to CMD REG (even before transaction because it is done in acce=
ss
> > > routine)
> > >
> > > Now what we got when reading first byte:
> > >
> > > Transaction (pre): STS=00, CNTL1=00, CNTL2=08, CMD@, ADD=A3, DAT0=1A,
> > > DAT1=00
> > > Transaction (post): STSB, CNTL1=00, CNTL2=08, CMD@, ADD=A3, DAT0=00,
> > > DAT1=00
> > >
> > > Transaction (pre): STS=00, CNTL1=00, CNTL2=08, CMD@, ADD=A3, DAT0=00,
> > > DAT1=00
> > > Transaction (post): STSB, CNTL1=00, CNTL2=08, CMD@, ADD=A3, DAT0P,
> > > DAT1=00
> > >
> > > Transaction (pre): STS=00, CNTL1=00, CNTL2=08, CMD@, ADD=A3, DAT0P,
> > > DAT1=00
> > > Transaction (post): STSB, CNTL1=00, CNTL2=08, CMD@, ADD=A3, DAT0<,
> > > DAT1=00
> > >
> > > In DAT0 are results so we get 00 50 3C...
> > > But expected content is 80 00 00 00 ...
> > >
> > > BUT if you take a look to the dump you can find this sequence at addr=
ess
> > > 0x1A.  00 50 3c 50 30 20
> > >
> > > And guess what were was the value 0x1A present?
> > >
> > > Transaction (pre): STS=00, CNTL1=00, CNTL2=08, CMD@, ADD=A2, DAT0=1A,
> > > DAT1=00
> > >
> > > Yes it was in DAT0 register. So this ALI thing is putting the command=
 not
> > > to the CMD reg but it takes it from DAT0 register!!!!!!!!
> > > (intel and others are putting command to cmd register)
> > >
> > > So what we need now:
> > >
> > > 1) test the driver with following change:
> > >            case HST_CNTL2_BYTE:
> > >                dev_err(&a->dev, "size is HST_CNTL2_BYTE!\n");
> > >                 if (rw=3D I2C_SMBUS_WRITE)
> > >                         outb_p(cmd, SMB_HST_CMD);
> > >
> > >    and replace please last line with  outb_p(cmd, SMB_HST_DAT0);
> > >
> > >
> > >    now you can run
> > >    i2cdump 0 0x50
> > >    i2cdump 0 0x50 c
> > >    modprobe eeprom
> > >    sensors
> > >    modprobe w...
> > >    sensors
> > >
> > >    all should work now (please test also with your chip driver loaded=
 as
> > >    you reported in your previous email)
> > >
> > > 2) ask ALI if this is a bug or feature.
> > > 3) test the rest modes, WORD mode, please
> > >    can you test (I dont know how the result should look like)
> > >
> > >    i2cdump 0 0x50 w
> > >    i2cdump 0 0x50 c
> > >
> > > Regards
> > >
> > > Rudolf
> > >
> > > > [root@ ~]# i2cdump 0 0x51
> > > > No size specified (using byte-data access)
> > > > WARNING! This program can confuse your I2C bus, cause data loss and=
 worse!
> > > > I will probe file /dev/i2c-0, address 0x51, mode byte
> > > > Continue? [Y/n]
> > > >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 0123456789abcdef
> > > > 00: ac ff 07 0c 0a 01 48 00 04 75 75 02 80 08 08 01    ?.????H.?uu?=
????
> > > > 10: 0e 04 0c 01 02 26 00 a0 75 00 00 50 3c 50 30 20    ?????&.?u..P=
<P0
> > > > 20: 00 00 50 50 00 00 00 00 00 41 4b 30 32 75 00 00    ..PP.....AK0=
2u..
> > > > 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1a    ............=
...?
> > > > 40: 80 00 00 00 00 00 00 bb ff 00 00 00 00 00 00 00    ?......?....=
....
> > > > 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ............=
....
> > > > 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ............=
....
> > > > 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ............=
....
> > > > 80: 80 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...........=
....
> > > > 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ............=
....
> > > > a0: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ............=
....
> > > > b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ............=
....
> > > > c0: 80 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...........=
....
> > > > d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ............=
....
> > > > e0: 00 00 ac ff ff ff ff ff ff ff ff ff ff ff ff ff    ..?.........=
....
> > > > f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ............=
....
>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DThe privileg=
ed confidential information contained in this email is intended for use onl=
y by the addressees as indicated by the original author of this email. If y=
ou are not the addressee indicated in this email or are not responsible for=
 delivery of the email to such person, please kindly reply the sender indic=
ating accordingly and delete all copies of it from your computer and networ=
k server immediately. We thank you for your cooperation. It is advisable th=
at any unauthorized use of confidential information of Winbond is strictly =
prohibited; and any information in this email that does not relate to the o=
fficial business of Winbond shall be deemed as neither given nor endorsed b=
y Winbond.=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
If your computer is unable to decode Chinese font, please ignore the follow=
ing message. They essentially repea!
 t the&nbsp; English statement above.=A5=BB=ABH=A5=F3=A4=BA=A9=D2=A7t=B5=D8=
=A8=B9=B9q=A4l=AA=BA=B0]=B2=A3=A9=CA=BE=F7=B1K=A9=CA=B8=EA=B0T, =B6=C8=B1=
=C2=C5v=AD=EC=B5o=ABH=A4H=AB=FC=A9w=A4=A7=A6=AC=ABH=A4H=A8=FA=BE\=A4=A7=A5=
=CE. =B0=B2=A8=CF=B1z=A8=C3=ABD=B3Q=AB=FC=A9w=A4=A7=A6=AC=ABH=A4H=A9=CE=A6]=
=A5=F4=A6=F3=AD=EC=A6]=A6b=A5=BC=B8g=B1=C2=C5v=AA=BA=B1=A1=A7=CE=A4=A7=A4U=
=A6=AC=A8=EC=A5=BB=ABH=A5=F3, =BD=D0=B1z=A7i=AA=BE=AD=EC=B5o=ABH=A4H=A8=C3=
=A5=DF=A7Y=B1N=ABH=A5=F3=B1q=B9q=B8=A3=BBP=BA=F4=B8=F4=A6=F8=AAA=BE=B9=A4=
=A4=A4=A9=A5H=AE=F8=B0=A3. =B9=EF=A9=F3=B1z=AA=BA=A6X=A7@, =A7=DA=AD=CC=A5=
=FD=A6=B9=ADP=C1=C2. =AFS=A6=B9=B4=A3=BF=F4, =A5=F4=A6=F3=A5=BC=B8g=B1=C2=
=C5v=BE=D5=A6=DB=A8=CF=A5=CE=B5=D8=A8=B9=B9q=A4l=AA=BA=BE=F7=B1K=B8=EA=B0T=
=AA=BA=A6=E6=AC=B0=ACO=B3Q=C4Y=AE=E6=B8T=A4=EE=AA=BA. =ABH=A5=F3=BBP=B5=D8=
=A8=B9=B9q=A4l=C0=E7=B7~=B5L=C3=F6=A4=A7=A4=BA=AEe,=A4=A3=B1o=B5=F8=AC=B0=
=B5=D8=A8=B9=B9q=A4l=A4=A7=A5=DF=B3=F5=A9=CE=B7N=A8=A3.
>
