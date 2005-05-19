From: Huang0@Winbond.com.tw (Huang0@Winbond.com.tw)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: Winbond 792 source codes for lm_sensor
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE0EA5F9@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE0673FD@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE0673FD@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi MDS, Jean

I have one question when I read the document
lm_sensors/doc/developers/new_drivers:
> * Be sure that SYSCTL and ALARM definitions in the driver are bracketed
>   by the special comments so that the kernel/include/sensors.h
>   file, which is generated automatically, contains your definitions.
>   (for chip drivers only)
The kernel/include/sensors.h should be generated automatically,
But I don't know how to generate it. I have bracketed the SYSCTL and
ALARM definitions in the driver w83792d.c, Could you give me the method
of generating it?


Thanks
Best Regards
Chunhao



> -----Original Message-----
> From: PI14 HUANG0
> Sent: 2005=E5=B9=B41=E6=9C=8824=E6=97=A5 10:45
> To: 'Mark Studebaker'
> Cc: PI10 LHHsu; PI14 DZSHEN; LM Sensors
> Subject: RE: Winbond 792 source codes for lm_sensor
>=20
> Dear MDS
>=20
> This is Chunhao. Thank you for your suggestions to 792 driver.
> The following is my answer to your questions.
>=20
>=20
> > - I would like to understand the smart fan interface in /proc.
> >   Do you have a preliminary document to be doc/chips/w83792d which desc=
ribes
> >   the interface? We would like to see that.
> I'm sorry that I do not have a preliminary document describes it, but I t=
hink
> it's NOT difficult to understand, if you connect datasheet 7.7.3/7.7.4 an=
d the
> interfaces of fan_cfg, pwm_flag, pwm[1-3], thermal_cruise, fan_tolerance,
> sf2_levels_fan[1-3], and sf2_points_fan[1-3] in /proc.(^_^)
>=20
> And I'd like to give some comments here:
> (1) Since I finish this driver with the help of w83781d.c and 792 driver
>   for Windows version(which has not be finished completely). All the inte=
rfaces
>   of SmartFanI/II are the requirements of our customs. So I added it into=
 792
>   Linux driver.
> (2) As to the SmartFan, we only consider Fan1,Fan2 and Fan3, instead of a=
ll
> the
>   Fans.
>=20
> I attached some GUI of Windows version, added the interfaces of /proc ont=
o the
> GUI. Please refer to the attachments, especially the red color comments a=
dded
> by me. Then you will understand the usage of SmartFan interface. If you s=
till
> have some questions about it, don't hesitate to mail us.
>=20
>=20
> > - The VID code looks wrong. The 792D has two VID registers that are dif=
ferent
> >   than previous chips.
> En...I still do NOT understand the VID very well, Since our customs do NOT
> require
> us provide any function of VID, I'm going to delete thefunctions:
> w83792d_vid(), w83792d_vrm() and the interfaces vid and vrm in /proc.
> Do you have any disagreement or suggestions about it?
>=20
>=20
> > - In w83792d_in() the code does not handle writing only the low limit
> >   (add "if nrels_mag > 2) .....")
> Yes, you are right, I have modified the codes, thanks.
>=20
>=20
> > - Why is the vol_factor array exposed to /proc? Isn't this only for deb=
ugging?
> >   These shouldn't be exposed to the user. If the user needs to adjust
> >   computation it can be done in /etc/sensors.conf.
> In the requirements of our customer: the motherboard vendor should have t=
he
> permission to modify the voltage factor, so I expose it into /proc.
> I write it with the reference of our Windows version, the Windows version
> GUI supply a interface to modify the voltage factor, but it need authenti=
cation,
> That's to say, NOT all of the user can modify it.
>=20
>=20
> Btw, I have tested the 792 driver on the motherboard with P4 CPU, it work=
s well,
> Now, I'm waiting for another motherboard for further test. After that, I =
will
> consider to check 792 related source files into CVS.
> And I will need your help at that time. For example, to add 792 related c=
odes
> into the script program "sensors-detect" because I know very few about Pe=
rl.
> :-)
>=20
>=20
> Best Regards
> Chunhao
>=20
>=20
>=20
>=20
> > Huang0@Winbond.com.tw wrote:
> > > OK, Thank you.
> > > I will wait for your suggestion.
> > >
> > >
> > > Best Regards
> > > Chunhao
> > >
> > >
> > >
> > >>-----Original Message-----
> > >>From: Mark Studebaker [mailto:mds4@verizon.net]
> > >>Sent: 2005=E5=B9=B41=E6=9C=8818=E6=97=A5 11:04
> > >>To: PI14 HUANG0
> > >>Cc: PI10 LHHsu; PI14 DZSHEN; sensors@Stimpy.netroedge.com
> > >>Subject: Re: Winbond 792 source codes for lm_sensor
> > >>
> > >>hi chunhao
> > >>sorry for delay
> > >>holidays and vacation
> > >>will review and respond soon :)
> > >>mds
> > >>
> > >>Huang0@Winbond.com.tw wrote:
> > >>
> > >>>Hi MDS, Jean, and Mark
> > >>>
> > >>>This is chunhao.
> > >>>
> > >>>I have sent the w83792d driver source code and datasheet to you
> > >>>for about 20 days, But I have NOT get any comments till now.
> > >>>
> > >>>Did you review my codes? If you have some suggestions,
> > >>>Please don't hesitate to tell me. :-)
> > >>>
> > >>>
> > >>>Thanks
> > >>>Best Regards
> > >>>
> > >>>Chunhao
> > >>>
> > >>>
> > >>>
> > >>>
> > >>>>-----Original Message-----
> > >>>>From: Mark Studebaker [mailto:mds4@verizon.net]
> > >>>>Sent: 2004=E5=B9=B412=E6=9C=8824=E6=97=A5 01:03
> > >>>>To: PI14 HUANG0
> > >>>>Cc: PI10 LHHsu; PI14 DZSHEN; sensors@Stimpy.netroedge.com
> > >>>>Subject: Re: Winbond 792 source codes for lm_sensor
> > >>>>
> > >>>>chunhao,
> > >>>>we received both the datasheet and the code.
> > >>>>thank you very much.
> > >>>>I'm sure you'll receive comments soon.
> > >>>>mds
> > >>>>
> > >>>>Huang0@Winbond.com.tw wrote:
> > >>>>
> > >>>>
> > >>>>>Hi MDS, Jean, and Mark
> > >>>>>
> > >>>>>This is chunhao.
> > >>>>>
> > >>>>>The 792 driver of trial version has been sent to you,
> > >>>>>Please check it, and please just me us a response if
> > >>>>>you get it.
> > >>>>>
> > >>>>>I'd like to add some comments to the 792 driver:
> > >>>>>1 The source is just a trial version, I will continue
> > >>>>>to modify it, so please don't add it into the cvs.
> > >>>>>And I will commit it by lm_sensors cvs, later, which
> > >>>>>maybe need your help. :-)
> > >>>>>
> > >>>>>
> > >>>>>2 The file sent to you is only one: w83792d.c
> > >>>>>I also modified the following files:
> > >>>>> 2.1 prog/sensors/main.c
> > >>>>> 2.2 prog/sensors/chips.h
> > >>>>> 2.3 prog/sensors/chips.c
> > >>>>> 2.4 lib/chips.h
> > >>>>> 2.5 lib/chips.c
> > >>>>> 2.6 lib/proc.c
> > >>>>>If you need refer to them, please tell me.
> > >>>>>
> > >>>>>3. some of the function are added by me in 792, maybe
> > >>>>>they do NOT exist in w83781d.c, I will write some
> > >>>>>documents to them when I release it in the future.
> > >>>>>For example: the following functions
> > >>>>>w83792d_thermal_cruise()
> > >>>>>w83792d_fan_tolerance()
> > >>>>>w83792d_sf2_points()
> > >>>>>w83792d_sf2_levels()
> > >>>>>w83792d_fan_cfg()
> > >>>>>have something to do with SmartFanI and SmartFanII
> > >>>>>mode. As to the SmartFan mode, you may refer to the 792
> > >>>>>data sheet.
> > >>>>>
> > >>>>>
> > >>>>>4. If you find some bugs in the source, please don't
> > >>>>>hesitate to tell us, and you may also give me some other
> > >>>>>suggestions about it.
> > >>>>>:-)
> > >>>>>
> > >>>>>Btw, Do you have an available w83792d chip? If do, maybe
> > >>>>>you can do some simple test for me when you are free?
> > >>>>>
> > >>>>>Thanks
> > >>>>>Best Regards
> > >>>>>
> > >>>>>
> > >>>>>Chunhao
> > >>>>>
> > >>>>>________________________________________
> > >>>>>From: PI14 DZSHEN
> > >>>>>Sent: 2004=E5=B9=B412=E6=9C=8823=E6=97=A5 16:59
> > >>>>>To: 'mds4@verizon.net'; 'khali@linux-fr.org';
> > 'mhoffman@lightlink.com';
> > >>>>
> > >>>>'sensors@Stimpy.netroedge.com'
> > >>>>
> > >>>>
> > >>>>>Cc: PI14 HUANG0; PI10 LHHsu
> > >>>>>Subject: Winbond 792 source codes for lm_sensor
> > >>>>>
> > >>>>>Dear all:
> > >>>>> Per my manager=E2=80=99s request (Haoge, lhhsu@winbond.com.tw), I=
 am sending
> > >>>>>this 792 source code. If you have any technical questions, please
> > >>>>>contact huang0@winbond.com.tw.
> > >>>>>
> > >>>>>Best regards
> > >>>>>
> > >>>>>techeng
> > >>>>>
> > >>>>>
> > >>>>
> >
> >>>>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D
> > >>
> > >>=3D
> > >>
> > >>>>=3D=3D=3D=3D=3D=3D=3D=3D=3DThe privileged confidential information =
contained in
> > this
> > >>>>email is intended for use only by the addressees as indicated by the
> > original
> > >>>>author of this email. If you are not the addressee indicated in thi=
s email
> > >>
> > >>or
> > >>
> > >>>>are not responsible for delivery of the email to such person, please
> kindly
> > >>>>reply the sender indicating accordingly and delete all copies of it=
 from
> > your
> > >>>>computer and network server immediately. We thank you for your
> cooperation.
> > >>>>It is advisable that any unauthorized use of confidential informati=
on
> of
> > >>>>Winbond is strictly prohibited; and any information in this email t=
hat
> does
> > >>>>not relate to the official business of Winbond shall be deemed as n=
either
> > >>
> > >>given
> > >>
> > >>>>nor endorsed by
> >
> >>>>Winbond.=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D
> > >>
> > >>=3D
> > >>
> > >>>>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DIf your computer is unable t=
o decode Chinese
> > font,
> > >>>>please ignore the following message. They essentially repe
> > >>>>a!
> > >>>>
> > >>>>
> > >>>>>t the&nbsp; English statement above.=E3=82=BB=E7=8D=BA=E3=83=B3=E3=
=81=9A=E2=94=AE=EE=9C=BA=E5=9C=B0=C3=BC=E7=AD=BF=EE=98=92=EE=80=99=E7=99=A9=
=E7=8E=BB=E2=94=A6=E8=AF=80=E7=9B=9E
> =E2=94=A6
> > =E6=88=88
> > >>>>
> > >>>>=E7=99=9F, =E5=BA=A6=E7=94=AD=E8=88=A6=EE=85=A5=E7=A5=87=E7=8D=BA=
=EE=97=AE=EE=82=B9=EF=B9=9A=E3=81=87=CE=9C=E7=8D=BA=EE=97=AE?=E7=B6=B7=E3=
=81=87=E3=83=8E. =E5=AE=89=E3=84=8F=E7=9C=A4?=E7=8D=B6=E7=A0=86=EE=82=B9=EF=
=B9=9A=E3=81=87=CE=9C=E7=8D=BA=EE=97=AE=E2=94=AA=EE=9B=83
> =E3=83=B4?
> > =EE=85=A5
> > >>
> > >>=EE=9B=83
> > >>
> > >>>>=EE=9B=88=E3=82=BC=E7=AB=92=E7=94=AD=E8=88=A6=EE=80=99=E8=96=84?=E3=
=81=87=EE=97=BB=CE=9C?=E3=82=BB=E7=8D=BA=E3=83=B3, =E5=8F=AB=E7=9C=A4=EE=9C=
=AF=EE=80=9D=EE=85=A5=E7=A5=87=E7=8D=BA=EE=97=AE?=E3=83=9F=EE=9C=9F=E7=9B=
=A2=E7=8D=BA=E3=83=B3=E7=9C=96=E7=AD=BF=E7=A6=8F=E7=B1=94=E5=91=BC
> =E9=9A=94?
> > =E7=8B=9D
> > >>
> > >>=E7=AB=9F
> > >>
> > >>>>=E3=81=84=E3=81=89=EE=99=8E=EE=87=8F=E5=9F=83. =E7=99=B8?=E7=9C=A4=
=EE=80=99=EE=9A=BE=EE=9C=86, =D0=B8=EE=85=85??=E7=92=93=E8=B0=85. =E7=96=AD=
?=E7=9F=97=E7=9C=B6, =E3=83=B4?=E3=82=BC=E7=AB=92=E7=94=AD=E8=88=A6=E8=8F=
=8A?=E3=84=8F=E3=83=8E=E5=9C=B0=C3=BC
> =E7=AD=BF
> > =EE=98=92
> > >>
> > >>=EE=80=99
> > >>
> > >>>>=E8=AF=80=E7=9B=9E=E6=88=88=E7=99=9F=EE=80=99=EF=B8=BD=EE=83=8B=E7=
=90=8C=E7=A0=86=E8=85=A8=EE=86=BD=E7=AA=BD=E3=82=8E=EE=80=99. =E7=8D=BA=E3=
=83=B3=E7=B1=94=E5=9C=B0=C3=BC=E7=AD=BF=EE=98=92=E7=8A=81=E7=A9=A8=E7=A4=9A=
=E9=97=BD=E3=81=87=E3=81=9A=E7=94=A7,=E3=81=83=E7=9C=94=E8=B7=8C=EE=83=8B=
=E5=9C=B0
> =C3=BC
> > =E7=AD=BF
> > >>
> > >>=EE=98=92
> > >>
> > >>>>=E3=81=87=E3=83=9F=E5=88=9D=E2=94=AA=E7=A8=AE=C7=8E.
> > >>>>
> > >>>>
> > >>>
> > >>>
> >
> >>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D
> > >>=3D=3D=3D=3D=3D=3D=3D=3D=3DThe privileged confidential information co=
ntained in
> this
> > >>email is intended for use only by the addressees as indicated by the =
original
> > >>author of this email. If you are not the addressee indicated in this =
email
> > or
> > >>are not responsible for delivery of the email to such person, please =
kindly
> > >>reply the sender indicating accordingly and delete all copies of it f=
rom
> your
> > >>computer and network server immediately. We thank you for your cooper=
ation.
> > >>It is advisable that any unauthorized use of confidential information=
 of
> > >>Winbond is strictly prohibited; and any information in this email tha=
t does
> > >>not relate to the official business of Winbond shall be deemed as nei=
ther
> > given
> > >>nor endorsed by
> >
> >>Winbond.=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D
> > >>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DIf your computer is unable to =
decode Chinese
> font,
> > >>please ignore the following message. They essentially repe
> > >>at the&nbsp; English statement
> > >>above.???H???=D2=A7t?=D8=A8??q?l???]???=CA=BE?K?=CA=B8?T, ?=C8=B1??v?=
?o?H?H??w?????H?H??\????.
> > ??
> >
> >>?=CF=B1z?=C3=ABD?Q??w?????H?H?=CE=A6]????]?b???g???v?????=CE=A4??U???=
=EC=A5=BB?H??, ?=D0=B1z?i????o?H?
> > H?
> >
> >>=C3=A5=DF=A7Y?N?H??q?q???P????A???????H??. ???z???X?@, ?=DA=AD=CC=A5?P?=
?. ?S??????, ????g???
> > >>v?=D5=A6=DB=A8=CF=A5=CE=B5=D8=A8??q?l????K??T???
> > >>=E6=AC=B0?O?Q?Y??T?=EE=AA=BA. ?H??P?=D8=A8??q?l??~?L????e,???o??=D8=
=A8??q?l???=DF=B3?=CE=B7N??.
> > >
> > >
> > >
> > >
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3DThe privileged confidential information cont=
ained in this
> > email is intended for use only by the addressees as indicated by the or=
iginal
> > author of this email. If you are not the addressee indicated in this em=
ail
> or
> > are not responsible for delivery of the email to such person, please ki=
ndly
> > reply the sender indicating accordingly and delete all copies of it fro=
m your
> > computer and network server immediately. We thank you for your cooperat=
ion.
> > It is advisable that any unauthorized use of confidential information of
> > Winbond is strictly prohibited; and any information in this email that =
does
> > not relate to the official business of Winbond shall be deemed as neith=
er
> given
> > nor endorsed by
> >
> Winbond.=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DIf your computer is unable to de=
code Chinese font,
> > please ignore the following message. They essentially repe
> > at the&nbsp; English statement
> > above.???H?=F3=A4=BA=A9=D2=A7t?=D8=A8??q?l???]???=CA=BE?K?=CA=B8?T, ?=
=C8=B1??v??o?H?H??w?????H?H??\????. ??
> > ?=CF=B1z?=C3=ABD?Q??w?????H?H?=CE=A6]????]?b???g???v?????=CE=A4??U???=
=EC=A5=BB?H??, ?=D0=B1z?i????o?H?
> H?
> > =C3=A5=DF=A7Y?N?H??q?q???P????A???????H??. ???z???X?@, ?=DA=AD=CC=A5?P?=
?. ?S??????, ??=F3=A5=BC=B8g???
> > v?=D5=A6=DB=A8=CF=A5=CE=B5=D8=A8??q?l????K??T???
> > =E6=AC=B0?O?Q?Y??T?=EE=AA=BA. ?H??P?=D8=A8??q?l??~?L????e,???o??=D8=A8?=
?q?l???=DF=B3?=CE=B7N??.


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
