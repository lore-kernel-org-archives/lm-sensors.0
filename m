From: Huang0@Winbond.com.tw (Huang0@Winbond.com.tw)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: Winbond 792 source codes for lm_sensor
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE1902D8@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE0673FD@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE0673FD@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Dear MDS

Thank you for your reply. The following is my further answers.

> Since the factors are only for the measured values, your implementation i=
s fine.
> Adjustments in userspace (through /etc/sensors.conf) would apply to
> both the measured values and the limits, so  it would not be
> possible to adjust the 'factors' without the separate /proc values
> for the factors; otherwise the limits would change as well. But as I said,
> hopefully the factors are fixed, and the /proc interface for the factors
> can be removed.

As to the voltage factor, I discussed with our Windows version
developer and our customer again this morning.
We still think that the voltage factor should be exposed to the
user, this because some motherboard Corp may lay the 792 chip
in there own way, that's to say, the voltage factor they set may
be different with the one on 792 DataSheet. So, the voltage factor
to the measured value(NOT voltage limits) can NOT be fixed
in the driver(though I want it to be fixed too, personally ^_^).

The probability of motherboard Corp using other factor is little,
But we have to provide them the method of modifying it.

So, I will keep the vol_factor in /proc, the modification to it
will affect the measured voltages only, instead of voltage limits.
And user can also modify /etc/sensors.conf, to change both the value
of measured value and limits.


>> #define IN_TO_REG(val)  (SENSORS_LIMIT((((val) * 10 + 8)/16),0,255))=20
>> #define IN_FROM_REG(val) (((val) * 16 + 5) / 10)
> These macros are not a full conversion, but simply multiply/divide by 10
> with some rounding and limit checks.
> The sysctl and /proc interfaces don't use floating point, so any floating
> point numbers are scaled by 10 (or 100 or 1000) to become integers.

Yes, I know, in the driver of w83792d, I also use integers instead of float=
ing
point.


Thanks

Best Regards
Chunhao


> -----Original Message-----
> From: Mark Studebaker [mailto:mds4@verizon.net]
> Sent: 2005=E5=B9=B41=E6=9C=8830=E6=97=A5 08:19
> To: PI14 HUANG0
> Cc: sensors@Stimpy.netroedge.com; PI10 LHHsu; PI14 DZSHEN
> Subject: Re: Winbond 792 source codes for lm_sensor
>=20
> I'll try and answer your other questions below.
>=20
> Huang0@Winbond.com.tw wrote:
> > Dear Jean:
> >
> >
> >
> >>>>- Why is the vol_factor array exposed to /proc? Isn't this only
> >
> > for
> >
> >>>>  debugging?
> >>>>  These shouldn't be exposed to the user. If the user needs to
> >>>>  adjust computation it can be done in /etc/sensors.conf.
> >>>
> >>>In the requirements of our customer: the motherboard vendor should
> >>>have the permission to modify the voltage factor, so I expose it
> >
> > into
> >
> >>>/proc. I write it with the reference of our Windows version, the
> >>>Windows version GUI supply a interface to modify the voltage factor,
> >>>but it need authentication, That's to say, NOT all of the user can
> >>>modify it.
> >>
> >>As I understand it, these factors account for the resistors placed on
> >>the motherboard, which are needed to bring all voltages back into the
> >>measurable 0V-4V range. Am I correct?
> >
> >
> > I do NOT know the exact function of factors, maybe you are right, it is
> > used to bring into some voltage range. I may delete the exposed
> > interface
> > vol_factor in /proc later.
> >
>=20
> Yes, I assume that the 'factors' will be fixed, and you can remove them i=
n /proc
> later.
>=20
> >
> >
> >>Is so, this does indeed not belong to the driver and has to be
> >
> > removed.
> >
> >>Such computation has always been performed in userspace by libsensors,
> >>for all drivers. The reason for this is that libsensors can do almost
> >>any mathematical operation, not only apply factors. As a matter of
> >
> > fact,
> >
> >>the W83792D chip needs more than factors for -5V and -12V (an
> >
> > additional
> >
> >>offset is needed), and unless I am missing something, your driver
> >>doesn't handle that. There is also a kernel development policy which
> >>states that conversions should always be moved outside of the kernel
> >>when possible, and this is exactly what libsensors is there for.
> >>
> >>As a side note, I'm already not certain that restricting the access to
> >>these values in the Windows world makes sense, but I am certain that
> >
> > it
> >
> >>makes no sense in the Linux world. The goal of open-source tools is to
> >>give the users the possibility to change whatever them want to, and
> >>certainly not to put restrictions to what they are allowed to do. And
> >
> > at
> >
> >>any rate there is no room for such a restriction mechanism in the
> >>libsensors framework.
> >
> >
> > In my w83792d.c I calculate the voltages according to the data sheet of
> > 792,
> > Please refer to the page 39(Chapter 8.6), page 41(Chapter 8.7), page 61
> > (Chapter 8.28 and 8.29) of 792 Data Sheet.
> > Do you mean that I should multiply these factors in user space, instead
> > of
> > doing that in the driver w83792d.c?
> > But I find that in the driver w83781d.c, it also do the translation in
> > kernel
> > by using such macros:
> > #define IN_TO_REG(val)  (SENSORS_LIMIT((((val) * 10 + 8)/16),0,255))
> > #define IN_FROM_REG(val) (((val) * 16 + 5) / 10)
> >
>=20
> These macros are not a full conversion, but simply multiply/divide by 10
> with some rounding and limit checks.
> The sysctl and /proc interfaces don't use floating point, so any floating
> point numbers are scaled by 10 (or 100 or 1000) to become integers.
>=20
>=20
> > Would you please give me an example on how to move the translate into
> > user space?
> > Is it what MDS said:"adjust computation it can be done in
> > /etc/sensors.conf"
> >
> >
>=20
> The best way is to learn is play with 'sensors' and editing sensors.conf.
> If you have linux running on a system with an already-supported chip,
> you should be able to do this easily.
>=20
> >
> >>As a side note, the voltage factors were used in your driver for the
> >>measured values only, not for the limits (unless I missed something)
> >
> > so
> >
> >>it was not working correctly anyway.
> >
> >
> > Yes, the voltage factors in my driver is only for the measured value,
> > NOT for the limits, that's because in the Datasheet of 792, the factors
> > for the measured values are different from for the limits, Please refer
> > to
> > the page 39(Chapter 8.6), page 41(Chapter 8.7), page 61 (Chapter 8.28
> > and 8.29).
> >
> > In the driver of w83781d.c I find that the voltage factors are both for
> > the measured values and the limits. Do you have any suggestions for my
> > 792 driver about it?
> >
>=20
> Since the factors are only for the measured values, your implementation i=
s fine.
> Adjustments in userspace (through /etc/sensors.conf) would apply to
> both the measured values and the limits, so  it would not be
> possible to adjust the 'factors' without the separate /proc values
> for the factors; otherwise the limits would change as well. But as I said,
> hopefully the factors are fixed, and the /proc interface for the factors
> can be removed.
>=20
>=20
> >
> >
> >>>And I will need your help at that time. For example, to add 792
> >>>related codes into the script program "sensors-detect" because I
> >
> > know
> >
> >>>very few about Perl. :-)
> >>
> >>The sensors-detect script is supposed to already identify the W83792D
> >>chip (since lm_sensors 2.9.0). If it doesn't, let us know and we'll
> >
> > fix
> >
> >>it.
> >
> > The version of lm_sensors I'm working is 2.9.0. And I find there are
> > some codes about 792 in script sensors-detect, But it seems that it does
> > NOT
> > work, because it can NOT find W83792D chip. Neither do the version 2.8.8
> > The attachment is the detect result log, you may refer to it and check
> > the
> > script again.
> >
> >
> >
> >>What will obviously require an update though is libsensors. I suppose
> >>you will provide a patch together with the driver itself? Seems hard
> >
> > to
> >
> >>properly test the driver and especially its interaction with "sensors"
> >>without this.
> >
> > As to libsensors, I know very few about it, Could you give me a simple
> > introduction about it? Such as the function of it, and how to update it
> > for me, etc.
> >
>=20
> Please read doc/developers/new_drivers. This gives a brief summary.
> If you add support for libsensors and 'sensors', as Jean said,
> it will greatly help your ability to debug the driver.
> If you need more help, please ask us.
> It is best if you do the userspace changes, however if you do not,
> we will eventually do it ourselves.
>=20
> >
> > Thanks
> > Best Regards
> > Chunhao
> > 2005-1-25
> >
> >
> >
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3DThe privileged confidential information contai=
ned in this
> email is intended for use only by the addressees as indicated by the orig=
inal
> author of this email. If you are not the addressee indicated in this emai=
l or
> are not responsible for delivery of the email to such person, please kind=
ly
> reply the sender indicating accordingly and delete all copies of it from =
your
> computer and network server immediately. We thank you for your cooperatio=
n.
> It is advisable that any unauthorized use of confidential information of
> Winbond is strictly prohibited; and any information in this email that do=
es
> not relate to the official business of Winbond shall be deemed as neither=
 given
> nor endorsed by
> Winbond.=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DIf your computer is unable to deco=
de Chinese font,
> please ignore the following message. They essentially repe
> at the&nbsp; English statement
> above.=C2=A5=C2=BB=C2=ABH=C2=A5=C3=B3=C2=A4=C2=BA=C2=A9=C3=92=C2=A7t=C2=
=B5=C3=98=C2=A8=C2=B9=C2=B9q=C2=A4l=C2=AA=C2=BA=C2=B0]=C2=B2=C2=A3=C2=A9=C3=
=8A=C2=BE=C3=B7=C2=B1K=C2=A9=C3=8A=C2=B8=C3=AA=C2=B0T,
> =C2=B6=C3=88=C2=B1=C3=82=C3=85v=C2=AD=C3=AC=C2=B5o=C2=ABH=C2=A4H=C2=AB=C3=
=BC=C2=A9w=C2=A4=C2=A7=C2=A6=C2=AC=C2=ABH=C2=A4H=C2=A8=C3=BA=C2=BE\=C2=A4=
=C2=A7=C2=A5=C3=8E.
> =C2=B0=C2=B2=C2=A8=C3=8F=C2=B1z=C2=A8=C3=83=C2=ABD=C2=B3Q=C2=AB=C3=BC=C2=
=A9w=C2=A4=C2=A7=C2=A6=C2=AC=C2=ABH=C2=A4H=C2=A9=C3=8E=C2=A6]=C2=A5=C3=B4=
=C2=A6=C3=B3=C2=AD=C3=AC=C2=A6]=C2=A6b=C2=A5=C2=BC=C2=B8g=C2=B1=C3=82=C3=85=
v=C2=AA=C2=BA=C2=B1=C2=A1=C2=A7=C3=8E=C2=A4=C2=A7=C2=A4U=C2=A6=C2=AC=C2=A8=
=C3=AC=C2=A5=C2=BB=C2=AB
> H=C2=A5=C3=B3, =C2=BD=C3=90=C2=B1z=C2=A7i=C2=AA=C2=BE=C2=AD=C3=AC=C2=B5o=
=C2=ABH=C2=A4H=C2=A8=C3=83=C2=A5=C3=9F=C2=A7Y=C2=B1N=C2=ABH=C2=A5=C3=B3=C2=
=B1q=C2=B9q=C2=B8=C2=A3=C2=BBP=C2=BA=C3=B4=C2=B8=C3=B4=C2=A6=C3=B8=C2=AAA=
=C2=BE=C2=B9=C2=A4=C2=A4=C2=A4=C2=A9=C2=A5H=C2=AE=C3=B8=C2=B0=C2=A3.
> =C2=B9=C3=AF=C2=A9=C3=B3=C2=B1z=C2=AA=C2=BA=C2=A6X=C2=A7@, =C2=A7=C3=9A=
=C2=AD=C3=8C=C2=A5=C3=BD=C2=A6=C2=B9=C2=ADP=C3=81=C3=82. =C2=AFS=C2=A6=C2=
=B9=C2=B4=C2=A3=C2=BF=C3=B4,
> =C2=A5=C3=B4=C2=A6=C3=B3=C2=A5=C2=BC=C2=B8g=C2=B1=C3=82=C3=85v=C2=BE=C3=
=95=C2=A6=C3=9B=C2=A8=C3=8F=C2=A5=C3=8E=C2=B5=C3=98=C2=A8=C2=B9=C2=B9q=C2=
=A4l=C2=AA=C2=BA=C2=BE=C3=B7=C2=B1K=C2=B8=C3=AA=C2=B0T=C2=AA=C2=BA=C2=A6=C3=
=A6=C2=AC=C2=B0=C2=ACO=C2=B3Q=C3=84Y=C2=AE=C3=A6=C2=B8T=C2=A4=C3=AE=C2=AA=
=C2=BA.
> =C2=ABH=C2=A5=C3=B3=C2=BBP=C2=B5=C3=98=C2=A8=C2=B9=C2=B9q=C2=A4l=C3=80=C3=
=A7=C2=B7~=C2=B5L=C3=83=C3=B6=C2=A4=C2=A7=C2=A4=C2=BA=C2=AEe,=C2=A4=C2=A3=
=C2=B1o=C2=B5=C3=B8=C2=AC=C2=B0=C2=B5=C3=98=C2=A8=C2=B9=C2=B9q=C2=A4l=C2=A4=
=C2=A7=C2=A5=C3=9F=C2=B3=C3=B5=C2=A9=C3=8E=C2=B7N=C2=A8=C2=A3.


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
