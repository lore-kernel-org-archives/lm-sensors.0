From: Huang0@Winbond.com.tw (Huang0@Winbond.com.tw)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE36FA09@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Rudolf

Besides the previous mail, I have to add more debug result here:
If I load the 792 driver modules before eeprom module, then none of
the memory can be found!

[root@ /home/chunhao/temp]# rmmod w83792d
[root@ /home/chunhao/temp]# rmmod eeprom
[root@ /home/chunhao/temp]# rmmod i2c-ali1563
[root@ /home/chunhao/temp]# clear
[root@ /home/chunhao/temp]# lsmod|grep i2c
i2c_sensor              4480  0
i2c_dev                12800  0
i2c_core               25728  2 i2c_sensor,i2c_dev
[root@ /home/chunhao/temp]# modprobe i2c-ali1563
[root@ /home/chunhao/temp]# modprobe w83792d
[root@ /home/chunhao/temp]# modprobe eeprom
[root@ /home/chunhao/temp]# sensors
eeprom-i2c-0-51
Adapter: SMBus ALi 1563 Adapter @ 5000
Unknown EEPROM type (60)

eeprom-i2c-0-50
Adapter: SMBus ALi 1563 Adapter @ 5000
Unknown EEPROM type (255).

w83792d-i2c-0-2f
Adapter: SMBus ALi 1563 Adapter @ 5000
VCoreA:    +1.53 V  (min =3D  +0.00 V, max =3D  +1.78 V)
VCoreB:    +0.54 V  (min =3D  +0.00 V, max =3D  +1.78 V)
VIN0:      +3.30 V  (min =3D  +0.00 V, max =3D  +4.08 V)
VIN1:      +3.17 V  (min =3D  +0.00 V, max =3D  +4.08 V)
VIN2:      +2.52 V  (min =3D  +0.00 V, max =3D  +4.08 V)
VIN3:      +1.26 V  (min =3D  +0.00 V, max =3D  +4.08 V)
5VCC:      +5.03 V  (min =3D  +0.00 V, max =3D  +6.12 V)
5VSB:      +4.99 V  (min =3D  +0.00 V, max =3D  +6.12 V)
VBAT:      +3.15 V  (min =3D  +0.00 V, max =3D  +4.08 V)
Fan1:     1622 RPM  (min =3D  703 RPM, div =3D 8)
Fan2:        0 RPM  (min =3D  703 RPM, div =3D 8)
Fan3:        0 RPM  (min =3D  703 RPM, div =3D 8)
Fan4:        0 RPM  (min =3D  703 RPM, div =3D 8)
Fan5:        0 RPM  (min =3D  703 RPM, div =3D 8)
Fan6:        0 RPM  (min =3D  703 RPM, div =3D 8)
Fan7:     37500 RPM  (min =3D    0 RPM, div =3D 2)
Temp1:     +38.0=C3=82=C2=B0C  (high =3D +80.0=C3=82=C2=B0C, hyst =3D +75.0=
=C3=82=C2=B0C)   ALARM
Temp2:      -8.0=C3=82=C2=B0C  (high =3D +80.0=C3=82=C2=B0C, hyst =3D +75.0=
=C3=82=C2=B0C)   ALARM
Temp3:     +42.0=C3=82=C2=B0C  (high =3D +80.0=C3=82=C2=B0C, hyst =3D +75.0=
=C3=82=C2=B0C)   ALARM
chassis:  Chassis is normal.

[root@ /home/chunhao/temp]#

> -----Original Message-----
> From: PI14 HUANG0
> Sent: 2005=E5=B9=B44=E6=9C=887=E6=97=A5 11:44
> To: 'Rudolf Marek'
> Cc: sensors@Stimpy.netroedge.com; PI10 LHHsu; PI14 DZSHEN
> Subject: RE: We will port w83792d.c to linux-2.6
>=20
> Hi Rudolf
>=20
> I tried to add the mask, but only one of the DDR memory can be found,
> The other one still can NOT be found! Please check the attached log messa=
ges
> and the dump result below.
> [root@ /usr/src/linux]# i2cdump 0 0x50   --> refer to attached message1
> [root@ /usr/src/linux]# i2cdump 0 0x50 c   --> refer to attached message2
> [root@ /usr/src/linux]# i2cdump 0 0x50   --> refer to attached message3
> [root@ /usr/src/linux]# modprobe eeprom
> [root@ /usr/src/linux]# sensors   --> refer to attached message4
> [root@ /usr/src/linux]# modprobe w83792d
> [root@ /usr/src/linux]# sensors   --> refer to attached message5
>=20
>=20
> Thanks
> Best Regards
> Chunhao
>=20
>=20
> ++++++++++++++   detailed dump result  +++++++++++++++++++++++++++++++
> [root@ /usr/src/linux]# lsmod|grep i2c
> i2c_dev                12800  0
> i2c_ali1563             8452  0
> i2c_core               25728  2 i2c_dev,i2c_ali1563
> [root@ /usr/src/linux]# i2cdump 0 0x50   --> refer to attached message1
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
> [root@ /usr/src/linux]# i2cdump 0 0x50 c   --> refer to attached message2
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
> [root@ /usr/src/linux]# i2cdump 0 0x50   --> refer to attached message3
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
> [root@ /usr/src/linux]# modprobe eeprom
> [root@ /usr/src/linux]# sensors   --> refer to attached message4
> eeprom-i2c-0-51
> Adapter: SMBus ALi 1563 Adapter @ 5000
> Memory type:            DDR SDRAM DIMM
> Memory size (MB):       128
>=20
> eeprom-i2c-0-50
> Adapter: SMBus ALi 1563 Adapter @ 5000
> Unknown EEPROM type (0)
>=20
> [root@ /usr/src/linux]# modprobe w83792d
> [root@ /usr/src/linux]# sensors   --> refer to attached message5
> w83792d-i2c-0-2f
> Adapter: SMBus ALi 1563 Adapter @ 5000
> VCoreA:    +1.53 V  (min =3D  +0.00 V, max =3D  +1.78 V)
> VCoreB:    +0.54 V  (min =3D  +0.00 V, max =3D  +1.78 V)
> VIN0:      +3.30 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> VIN1:      +3.17 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> VIN2:      +2.52 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> VIN3:      +1.26 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> 5VCC:      +5.03 V  (min =3D  +0.00 V, max =3D  +6.12 V)
> 5VSB:      +4.99 V  (min =3D  +0.00 V, max =3D  +6.12 V)
> VBAT:      +3.15 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> Fan1:     1622 RPM  (min =3D  703 RPM, div =3D 8)
> Fan2:        0 RPM  (min =3D  703 RPM, div =3D 8)
> Fan3:        0 RPM  (min =3D  703 RPM, div =3D 8)
> Fan4:        0 RPM  (min =3D  703 RPM, div =3D 8)
> Fan5:        0 RPM  (min =3D  703 RPM, div =3D 8)
> Fan6:        0 RPM  (min =3D  703 RPM, div =3D 8)
> Fan7:     37500 RPM  (min =3D    0 RPM, div =3D 2)
> Temp1:     +37.0=C3=82=C2=B0C  (high =3D +80.0=C3=82=C2=B0C, hyst =3D +75=
.0=C3=82=C2=B0C)   ALARM
> Temp2:      -8.0=C3=82=C2=B0C  (high =3D +80.0=C3=82=C2=B0C, hyst =3D +75=
.0=C3=82=C2=B0C)   ALARM
> Temp3:     +41.0=C3=82=C2=B0C  (high =3D +80.0=C3=82=C2=B0C, hyst =3D +75=
.0=C3=82=C2=B0C)   ALARM
> chassis:  Chassis is normal.
>=20
> eeprom-i2c-0-51
> Adapter: SMBus ALi 1563 Adapter @ 5000
> Memory type:            DDR SDRAM DIMM
> Memory size (MB):       128
>=20
> eeprom-i2c-0-50
> Adapter: SMBus ALi 1563 Adapter @ 5000
> Unknown EEPROM type (0)
>=20
>=20
>=20
> > -----Original Message-----
> > From: Rudolf Marek [mailto:R.Marek@sh.cvut.cz]
> > Sent: 2005=E5=B9=B44=E6=9C=887=E6=97=A5 00:30
> > To: PI14 HUANG0
> > Cc: sensors@Stimpy.netroedge.com; PI10 LHHsu; PI14 DZSHEN
> > Subject: RE: We will port w83792d.c to linux-2.6
> >
> > Hello all,
> >
> > How could this EVER worked????!!!!
> >
> > outb_p(inb_p(SMB_HST_CNTL2) | (size << 3), SMB_HST_CNTL2);
> > MASK is missing !!!!
> >
> > Please can you add to your driver this?
> >
> > #define HST_CNTL2_SIZEMASK 0x38
> >
> > outb_p( (inb_p(SMB_HST_CNTL2)&~HST_CNTL2_SIZEMASK) | (size << 3),
> > SMB_HST_CNTL2);
> >
> > I think then it should work.
> >
> > i2cdump 0 0x50
> > i2cdump 0 0x50 c
> > i2cdump 0 0x50
> >
> > and also
> >
> > modprobe eeprom
> > sensors
> >
> >
> > Regards
> >
> > Rudolf

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
