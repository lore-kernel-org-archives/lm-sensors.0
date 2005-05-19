From: Huang0@Winbond.com.tw (Huang0@Winbond.com.tw)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: Ask for some information about motherboard ASUS NCLV-D
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE36FF3D@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Rudolf

> Hmm thats strange. You should see in syslog the message from the patch an=
d you
> should be able to modprobe the 792 driver without the isaset. Can you see
> the message in the log from my patch?

Do you mean to look for the message "PCI: Canceling ASUS hide and seek
played with SMBus monitoring chip\n" from drivers/pci/quirks.c in
/var/log/message?

I do NOT find any message from the patch when I load the i2c-i801/w83792d/
eeprom without isaset. Is it because I'm using "ssh" to the Linux?


> If not can you put some printks around to see where is problem? Thanks.
> We need to know:
> 1) if our patch was activated
> 2) if it works same way as isaset

Where should I put these "printks"? You'd better give me more information
about it.


> Maybe the "trick" disabled the EEPROM part of the bus.
> Can you please try with clean boot:

Yes, you are right, I find that the eeprom module works well if I do NOT
do the "isaset" trick. But at this time, the 792 module does NOT work!
[root@CFLi ~]# modprobe i2c-i801
[root@CFLi ~]# modprobe eeprom
[root@CFLi ~]# sensors
eeprom-i2c-0-55
Adapter: SMBus I801 adapter at 0400
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256

eeprom-i2c-0-51
Adapter: SMBus I801 adapter at 0400
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
Here is some of the debug message:
(1) clean reboot

(2) modprobe i2c-i801

(3) i2cdetect 0
[root@CFLi ~]# i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
50: XX 51 XX XX XX 55 XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX

(4) isaset .... (put here the trick line)
    i2cdetect 0
[root@CFLi ~]# isaset -y -f 0x04b9 0x08
[root@CFLi ~]# i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 2f
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX 44 XX XX XX XX XX XX 4b XX XX XX 4f
50: XX XX XX XX 54 55 XX XX XX XX XX XX XX XX XX XX
60: XX 61 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX 71 XX XX XX XX XX XX


(5) i2cdump 0 0x55
[root@CFLi ~]# i2cdump 0 0x55
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x55, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

(6) i2cdump 0 0x55 c
[root@CFLi ~]# i2cdump 0 0x55 c
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x55, mode byte consecutive read
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

(7) modprobe eeprom
    sensors
[root@CFLi ~]# modprobe eeprom
[root@CFLi ~]# sensors
eeprom-i2c-0-55
Adapter: SMBus I801 adapter at 0400
Unknown EEPROM type (255).

eeprom-i2c-0-54
Adapter: SMBus I801 adapter at 0400
Unknown EEPROM type (255).

(8) modprobe your792driver
    sensors
[root@CFLi ~]# modprobe w83792d
[root@CFLi ~]# sensors
w83792d-i2c-0-2f
Adapter: SMBus I801 adapter at 0400
VCoreA:    +1.33 V  (min =3D  +0.00 V, max =3D  +2.04 V)
VCoreB:    +0.35 V  (min =3D  +0.00 V, max =3D  +2.04 V)
VIN0:      +3.28 V  (min =3D  +0.00 V, max =3D  +4.08 V)
VIN1:      +3.18 V  (min =3D  +0.00 V, max =3D  +4.08 V)
VIN2:      +1.52 V  (min =3D  +0.00 V, max =3D  +4.08 V)
VIN3:      +2.50 V  (min =3D  +0.00 V, max =3D  +4.08 V)
5VCC:      +5.08 V  (min =3D  +0.00 V, max =3D  +6.12 V)
5VSB:      +4.92 V  (min =3D  +0.00 V, max =3D  +6.12 V)
VBAT:      +3.02 V  (min =3D  +0.00 V, max =3D  +4.08 V)
Fan1:        0 RPM  (min =3D    0 RPM, div =3D 128)
Fan2:        0 RPM  (min =3D    0 RPM, div =3D 2)
Fan3:        0 RPM  (min =3D    0 RPM, div =3D 128)
Fan4:        0 RPM  (min =3D    0 RPM, div =3D 128)
Fan5:        0 RPM  (min =3D    0 RPM, div =3D 128)
Fan6:        0 RPM  (min =3D    0 RPM, div =3D 2)
Fan7:        0 RPM  (min =3D    0 RPM, div =3D 128)
Temp1:     +40.0=C3=82=C2=B0C  (high =3D +127.0=C3=82=C2=B0C, hyst =3D  +0.=
0=C3=82=C2=B0C)
Temp2:     +59.0=C3=82=C2=B0C  (high =3D +43.0=C3=82=C2=B0C, hyst =3D +38.0=
=C3=82=C2=B0C)   ALARM
Temp3:     -32.0=C3=82=C2=B0C  (high =3D +45.0=C3=82=C2=B0C, hyst =3D +40.0=
=C3=82=C2=B0C)   ALARM
chassis:  Chassis is normal.

eeprom-i2c-0-55
Adapter: SMBus I801 adapter at 0400
Unknown EEPROM type (255).

eeprom-i2c-0-54
Adapter: SMBus I801 adapter at 0400
Unknown EEPROM type (255).

(9) i2cdump 0 0x55 c
[root@CFLi ~]# i2cdump 0 0x55 c
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x55, mode byte consecutive read
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

(10)
[root@CFLi ~]# rmmod w83792d
[root@CFLi ~]# rmmod eeprom
[root@CFLi ~]# rmmod i2c-i801
[root@CFLi ~]# isaset -y -f 0x04b9 0x00 <---here is 0x00 instead of 0x08 !!
[root@CFLi ~]# isadump -f 0x04b9
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address range 0x400 to 0x4ff.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 40 00 04 00 ab ff 00 00 00 44 00 00 00 00 07 07
10: 00 00 00 00 10 00 5c 00 00 00 00 00 00 00 00 00
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: c0 31 a4 1b ff ff 00 01 00 00 00 00 00 00 00 03
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 c0 31 00 00
b0: 00 0c 00 03 00 00 00 00 00 00 00 00 00 00 00 00
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: a0 0a ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[root@CFLi ~]# modprobe i2c-i801
[root@CFLi ~]# modprobe eeprom
[root@CFLi ~]# modprobe w83792d
[root@CFLi ~]# sensors  <--- the eeprom can work but 792 NOT!
eeprom-i2c-0-55
Adapter: SMBus I801 adapter at 0400
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256

eeprom-i2c-0-51
Adapter: SMBus I801 adapter at 0400
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256

Then do you know how to solve this problem? So that both the eeprom and
792 modules can work at the same time.



Thanks
Best Regards
Chunhao


> -----Original Message-----
> From: Rudolf Marek [mailto:r.marek@sh.cvut.cz]
> Sent: 2005=E5=B9=B44=E6=9C=8812=E6=97=A5 5:20
> To: PI14 HUANG0
> Cc: sensors@Stimpy.netroedge.com
> Subject: Re: Ask for some information about motherboard ASUS NCLV-D
>=20
> Huang0@Winbond.com.tw wrote:
> > Hi Rudolf
> >
> > I tested your patch "hide_and_seek_2" under linux-2.6.11 under this
> motherboard
> > ASUS NCLV-D, the 792 driver for linux-2.6 can work if I execute "isaset=
 -y
> -f 0x04b9 0x08" at first,
> even if the eeprom modules is loaded. But the eeprom
> > modules can NOT get the memory information.
>=20
> Hmm thats strange. You should see in syslog the message from the patch an=
d you
> should
> be able to modprobe the 792 driver without the isaset. Can you see the me=
ssage
> in the log
> from my patch?
>=20
> If not can you put some printks around to see where is problem? Thanks.
> We need to know:
>=20
> 1) if our patch was activated
> 2) if it works same way as isaset
>=20
> > I remember that under linux-2.4 on this motherboard, the 792 driver can=
 NOT
> > work if eeprom modules is loaded.
>=20
> yes it was because the i2c-i801 did not handle correctly the i2c-block re=
ads,
> this is already
> fixed in CVS.
>=20
> > [root@localhost linux-2.6.11]# sensors
> > w83792d-i2c-0-2f
> > Adapter: SMBus I801 adapter at 0400
> > VCoreA:    +1.33 V  (min =3D  +1.40 V, max =3D  +1.60 V)       ALARM
> > VCoreB:    +0.35 V  (min =3D  +1.40 V, max =3D  +1.60 V)       ALARM
> > VIN0:      +3.28 V  (min =3D  +3.20 V, max =3D  +3.39 V)
> > VIN1:      +3.17 V  (min =3D  +3.09 V, max =3D  +3.30 V)
> > VIN2:      +1.51 V  (min =3D  +1.39 V, max =3D  +1.49 V)       ALARM
> > VIN3:      +2.50 V  (min =3D  +2.59 V, max =3D  +2.64 V)       ALARM
> > 5VCC:      +5.08 V  (min =3D  +4.73 V, max =3D  +5.23 V)
> > 5VSB:      +4.92 V  (min =3D  +4.73 V, max =3D  +5.23 V)
> > VBAT:      +3.01 V  (min =3D  +2.85 V, max =3D  +3.14 V)
> > Fan1:        0 RPM  (min =3D    0 RPM, div =3D 128)
> > Fan2:     1448 RPM  (min =3D 1500 RPM, div =3D 4)              ALARM
> > Fan3:        0 RPM  (min =3D    0 RPM, div =3D 128)
> > Fan4:        0 RPM  (min =3D    0 RPM, div =3D 128)
> > Fan5:        0 RPM  (min =3D    0 RPM, div =3D 128)
> > Fan6:        0 RPM  (min =3D    0 RPM, div =3D 2)
> > Fan7:        0 RPM  (min =3D    0 RPM, div =3D 128)
> > Temp1:     +37.0=C3=82=C2=B0C  (high =3D +42.0=C3=82=C2=B0C, hyst =3D +=
37.0=C3=82=C2=B0C)
> > Temp2:     +57.0=C3=82=C2=B0C  (high =3D +43.0=C3=82=C2=B0C, hyst =3D +=
38.0=C3=82=C2=B0C)   ALARM
> > Temp3:     -32.0=C3=82=C2=B0C  (high =3D +45.0=C3=82=C2=B0C, hyst =3D +=
40.0=C3=82=C2=B0C)   ALARM
> > chassis:  Chassis is normal.
> >
> > eeprom-i2c-0-55
> > Adapter: SMBus I801 adapter at 0400
> > Unknown EEPROM type (255).
> >
> > eeprom-i2c-0-54
> > Adapter: SMBus I801 adapter at 0400
> > Unknown EEPROM type (255).
> >
>=20
> Hmm again some more problems...
>=20
> Maybe the "trick" disabled the EEPROM part of the bus.
> Can you please try with clean boot:
>=20
> modprobe i2c-i801  (I hope it is this driver)
>=20
> i2cdetect 0
> isaset .... (put here the trick line)
> i2cdetect 0
>=20
> Afterwards if you still can see address 0x54 and 0x55
> can you do:
> i2cdump 0 0x55
> i2cdump 0 0x55 c
> modprobe eeprom
> sensors
> modprobe your792driver
> sensors
> i2cdump 0 0x55 c
>=20
> If you cannot see addresses 54 55 as "responsive - no XX" than it means t=
he
> trick switched the bus. And because
> the quirk did not work and you did it manualy than eeprom driver cant get=
 data
> because the chip is "away"
>=20
> thanks
>=20
> regards
>=20
> Rudolf


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
