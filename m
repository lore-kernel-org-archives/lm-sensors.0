From: Huang0@Winbond.com.tw (Huang0@Winbond.com.tw)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: w83792d_driver-1.0.1.patch: Winbond W83792D driver for linux-2.4
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE246157@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE245CA3@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE245CA3@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi MDS

I can see the 792 driver in the CVS, thank you for your work,
It's also a pleasure to me working with you and the other members of
lm_sensors group.


Best Regards

Chunhao


> -----Original Message-----
> From: Mark Studebaker [mailto:mds@mds.gotdns.com]
> Sent: 2005=E5=B9=B43=E6=9C=8811=E6=97=A5 02:56
> To: PI14 HUANG0
> Cc: sensors@Stimpy.netroedge.com; PI10 LHHsu; PI13 CFLi; PI14 DZSHEN
> Subject: Re: w83792d_driver-1.0.1.patch: Winbond W83792D driver for linux=
-2.4
> (patch to lm_sensors-2.9.0)
>=20
> Reviewed, briefly tested (forcing driver on a w83782d chip) and checked i=
n to
> CVS.
> I'll have some comments and test results in a follow-up email.
>=20
> Thanks for the contribution and hard work.
> It's been a pleasure working with you, and especially gratifying
> to establish contact with a leading hardware sensors company.
> I hope we can continue to work together.
>=20
> mds
>=20
> Huang0@Winbond.com.tw wrote:
> > Hi Jean, MDS
> >
> >
> > Please commit it into CVS for us when you confirm that the driver is ok=
ay
> now.
> > If there are still some small bugs in the driver, you may fix it for us=
 :-)
> > After you commit it, please just give us a response.
> >
> > If you have any questions, please don't hesitate to tell us.:-)
> >
> > Thanks
> > Best Regards
> > Chunhao
> > 2005-03-07
> >
> >
> >
> >>-----Original Message-----
> >>From: PI14 DZSHEN
> >>Sent: 2005=E5=B9=B43=E6=9C=887=E6=97=A5 10:41
> >>To: 'khali@linux-fr.org'; 'mds4@verizon.net'
> >>Cc: 'sensors@Stimpy.netroedge.com'; PI10 LHHsu; PI13 CFLi; PI14 HUANG0;=
 PI14
> >>DZSHEN
> >>Subject: w83792d_driver-1.0.1.patch: Winbond W83792D driver for linux-2=
.4
> >>(patch to lm_sensors-2.9.0)
> >>
> >>
> >>This is the update for the original patch.
> >>
> >>Many thanks
> >>
> >>techeng
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
> at the&nbsp; English statement above.=E3=82=BB=E7=8D=BA=E3=83=B3=E3=81=9A=
=E2=94=AE=EE=9C=BA=E5=9C=B0=C3=BC=E7=AD=BF=EE=98=92=EE=80=99=E7=99=A9=E7=8E=
=BB=E2=94=A6=E8=AF=80=E7=9B=9E=E2=94=A6=E6=88=88=E7=99=9F,
> =E5=BA=A6=E7=94=AD=E8=88=A6=EE=85=A5=E7=A5=87=E7=8D=BA=EE=97=AE=EE=82=B9=
=EF=B9=9A=E3=81=87=CE=9C=E7=8D=BA=EE=97=AE?=E7=B6=B7=E3=81=87=E3=83=8E. =E5=
=AE=89=E3=84=8F=E7=9C=A4?=E7=8D=B6=E7=A0=86=EE=82=B9=EF=B9=9A=E3=81=87=CE=
=9C=E7=8D=BA=EE=97=AE=E2=94=AA=EE=9B=83=E3=83=B4?=EE=85=A5=EE=9B=83=EE=9B=
=88=E3=82=BC
> =E7=AB=92=E7=94=AD=E8=88=A6=EE=80=99=E8=96=84?=E3=81=87=EE=97=BB=CE=9C?=
=E3=82=BB=E7=8D=BA=E3=83=B3, =E5=8F=AB=E7=9C=A4=EE=9C=AF=EE=80=9D=EE=85=A5=
=E7=A5=87=E7=8D=BA=EE=97=AE?=E3=83=9F=EE=9C=9F=E7=9B=A2=E7=8D=BA=E3=83=B3=
=E7=9C=96=E7=AD=BF=E7=A6=8F=E7=B1=94=E5=91=BC=E9=9A=94?=E7=8B=9D=E7=AB=9F=
=E3=81=84=E3=81=89
> =EE=99=8E=EE=87=8F=E5=9F=83. =E7=99=B8?=E7=9C=A4=EE=80=99=EE=9A=BE=EE=9C=
=86, =D0=B8=EE=85=85??=E7=92=93=E8=B0=85. =E7=96=AD?=E7=9F=97=E7=9C=B6, =E3=
=83=B4?=E3=82=BC=E7=AB=92=E7=94=AD=E8=88=A6=E8=8F=8A?=E3=84=8F=E3=83=8E=E5=
=9C=B0=C3=BC=E7=AD=BF=EE=98=92=EE=80=99=E8=AF=80=E7=9B=9E
> =E6=88=88=E7=99=9F=EE=80=99=EF=B8=BD=EE=83=8B=E7=90=8C=E7=A0=86=E8=85=A8=
=EE=86=BD=E7=AA=BD=E3=82=8E=EE=80=99. =E7=8D=BA=E3=83=B3=E7=B1=94=E5=9C=B0=
=C3=BC=E7=AD=BF=EE=98=92=E7=8A=81=E7=A9=A8=E7=A4=9A=E9=97=BD=E3=81=87=E3=81=
=9A=E7=94=A7,=E3=81=83=E7=9C=94=E8=B7=8C=EE=83=8B=E5=9C=B0=C3=BC=E7=AD=BF=
=EE=98=92=E3=81=87=E3=83=9F
> =E5=88=9D=E2=94=AA=E7=A8=AE=C7=8E.
> >
>=20


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
