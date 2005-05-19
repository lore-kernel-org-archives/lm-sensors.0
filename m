From: Huang0@Winbond.com.tw (Huang0@Winbond.com.tw)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: A question when test W83792D driver on another motherboard
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE2459A9@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190C6C@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190C6C@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean

We tried the command "isaset -y -f 0x4b9 0x08", and find that the w83792d d=
river
can "work" now when run "sensors" after load the 792 module, but we meet so=
me
other problems:
1* All of the voltage/fan/temperature measured values are fixed, they
do NOT change at all. The voltage/fan/temperature limits can NOT be set eit=
her.
Here is the output message of "sensors", please refer it.
Do you ever meet such similar problem before? Our 792 driver for Windows
can work well.
******************  output of "sensors"  ************************
w83792d-i2c-0-2f
Adapter: SMBus I801 adapter at 0400
VCoreA:    +2.05 V  (min =3D  +2.04 V, max =3D  +2.04 V)       ALARM
VCoreB:    +2.05 V  (min =3D  +2.04 V, max =3D  +2.04 V)       ALARM
VIN0:      +4.09 V  (min =3D  +4.08 V, max =3D  +4.08 V)       ALARM
VIN1:      +4.09 V  (min =3D  +4.08 V, max =3D  +4.08 V)       ALARM
VIN2:      +4.09 V  (min =3D  +4.08 V, max =3D  +4.08 V)       ALARM
VIN3:      +4.09 V  (min =3D  +4.08 V, max =3D  +4.08 V)       ALARM
5VCC:      +6.14 V  (min =3D  +6.12 V, max =3D  +6.12 V)       ALARM
5VSB:      +6.12 V  (min =3D  +6.12 V, max =3D  +6.12 V)
VBAT:      +4.08 V  (min =3D  +4.08 V, max =3D  +4.08 V)
Fan1:        0 RPM  (min =3D    0 RPM, div =3D 1)
Fan2:        0 RPM  (min =3D    0 RPM, div =3D 1)
Fan3:        0 RPM  (min =3D    0 RPM, div =3D 4080)
Fan4:        0 RPM  (min =3D    0 RPM, div =3D 255)
Fan5:        0 RPM  (min =3D    0 RPM, div =3D 255)
Fan6:        0 RPM  (min =3D    0 RPM, div =3D 255)
Fan7:        0 RPM  (min =3D    0 RPM, div =3D 255)
Temp1:    +255.0=C2=A2XC  (high =3D +255.0=C2=A2XC, hyst =3D +255.0=C2=A2XC)
Temp2:    +255.5=C2=A2XC  (high =3D +255.5=C2=A2XC, hyst =3D +255.5=C2=A2XC)
Temp3:    +255.5=C2=A2XC  (high =3D +255.5=C2=A2XC, hyst =3D +255.5=C2=A2XC)
ERROR: Can't get Chassis data!

2* When I rmmod the w83792d module, and insmod it again, the 792 driver
will NOT work any more: I get nothing from "sensors". I'm sure that the
0x04b9 is still "0x08", it does NOT change. Then we have to reboot the
Linux to make 792 driver "work" again. :-(

Btw, the "sensors-detect" still can NOT find the 792 chip after I run
"isaset -y -f 0x4b9 0x08".


Thanks
Best Regards

Chunhao
2005-03-02


> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: 2005=E5=B9=B42=E6=9C=8828=E6=97=A5 16:35
> To: PI14 HUANG0
> Cc: LM Sensors; PI10 LHHsu; PI14 DZSHEN; PI13 CFLi
> Subject: RE: A question when test W83792D driver on another motherboard
>=20
>=20
> Hi Chunhao,
>=20
> > When it has been confirmed that it is ASUS motherboard, write the value
> > 0x08 into the port 0x04b9.
> > (...)
> > Then, do you have any idea on how to solve the problem we meet?
> > If do, please tell me, I'd like to test it on this motherboard.
>=20
> Just try "isaset -y -f 0x4b9 0x08". That should do the trick Asus
> recommends.
>=20
> If you confirm that the W83792D then appears on the SMBus (as probed by
> sensors-detect or i2cdetect) then we'll have to integrate the trick.
> For 2.6 there is a place dedicated to this (pci/quirks.c). For 2.4 there
> is none so we'll just document the fact that isaset must be run prior
> to loading the smbus driver, or integrate the operation into the smbus
> driver itself (shouldn't be too hard).
>=20
> I still wonder what device is at 0x4b9. According to the snapshot of
> /proc/ioports you sent, your linux system doesn't know about it.
>=20
> Thanks,
> --
> Jean Delvare

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
