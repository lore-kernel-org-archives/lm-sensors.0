From: Huang0@Winbond.com.tw (Huang0@Winbond.com.tw)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: A probelm of loading module i2c-ali1563.o
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE0EA317@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <265EC8B67800A345A8FB8CA013220F0119E39D@wehqml01>
In-Reply-To: <265EC8B67800A345A8FB8CA013220F0119E39D@wehqml01>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean & Mochel

I backported the i2c-ali1563.c from 2.6 to 2.4. It can be compiled on my
Linux now. After I get a motherboard with ALI M1563(tomorrow or the day aft=
er
tomorrow), I will test it to see whether lm_sensors(w83792D) works well.

If i2c-ali1563.c for linux 2.4 can work well, I'd like to send it to you.
Would you please review the codes or test(if you have ALI M1563) it for me?


Thanks

Best Regards
Chunhao


> -----Original Message-----
> From: PI14 HUANG0
> Sent: 2005=E5=B9=B41=E6=9C=8819=E6=97=A5 15:35
> To: 'Jean Delvare'
> Cc: mochel@digitalimplant.org; PI10 LHHsu; PI14 DZSHEN; LM Sensors; PI13 =
CFLi
> Subject: RE: A probelm of loading module i2c-ali1563.o
>=20
> Dear Jean
>=20
> This is Chunhao.
>=20
> I download the i2c-ali1563.c from linux-2.6.11-rc1 and read some
> of the codes.
>=20
> I wonder whether there is a plan for LM_Sensors Group to backport
> it from 2.6 to 2.4? Because I have little knowledge and experience
> about bus drivers. And I think there should be many guys in LM_Sensors
> Group who have experience about it.
>=20
> It will be good if lm_sensors group will backport it. :-)
> Btw, Is there anyone who already began to do this job?
>=20
>=20
> Thanks
>=20
> Best Regards
> Chunhao
>=20
>=20
> > -----Original Message-----
> > From: Jean Delvare [mailto:khali@linux-fr.org]
> > Sent: 2005=E5=B9=B41=E6=9C=8814=E6=97=A5 16:59
> > To: PI14 HUANG0
> > Cc: mochel@digitalimplant.org; PI10 LHHsu; PI14 DZSHEN; LM Sensors; PI1=
3 CFLi
> > Subject: RE: A probelm of loading module i2c-ali1563.o
> >
> >
> > Hi Chunhao,
> >
> > > We found the source of i2c-ali1563.c on the internet:
> > > http://www.kernel-websource.com/linux266/source-i2c-ali1563.htm
> > > Could you confirm it when you are free?
> >
> > Picking the sources from some random website doesn't sound really good
> > ;) I would use this one:
> >
> http://linux.bkbits.net:8080/linux-2.5/anno/drivers/i2c/busses/i2c-ali1563
> > .c@1.12
> >
> > At least you'll be sure the file is correct and up-to-date. If you want
> > the file itself, which I think you can't download from bitkeeper's web
> > interface, then you should simply download linux-2.6.11-rc1.
> >
> > > I tried to get the source
> > > from LM-Sensors CVS, but failed to login for several times:
> >
> > I did not experience any problem recently. Try again later, if it still
> > doesn't work you may contact Philip Edelbrock but since it works for me
> > the problem might be on your side and not on the server side.
> >
> > > If we have to backport i2c-ali1563 to Linux 2.4 by myself,
> > > Could you give me some guides about it?
> >
> > I am not an expert in bus drivers, so say the least. All I can tell is
> > that the Linux 2.6 i2c-ali1563 driver is based on the Linux 2.6
> > i2c-ali15x3, i2c-ali1535, and i2c-i801 drivers. This means that if you
> > compare these drivers with their lm_sensors CVS counterparts and report
> > the differences to the i2c-ali1563 driver, you should get a driver that
> > works with lm_sensors CVS. If you have more technical questions, I guess
> > that the various folks who wrote and ported these bus drivers will be of
> > more help to you than I can be myself.
> >
> > --
> > Jean Delvare
> >
> >
> >
> > >
> > >
> > >Best Regards
> > >Chunhao
> > >
> > >
> > >> -----Original Message-----
> > >> From: Jean Delvare [mailto:khali@linux-fr.org]
> > >> Sent: 2005=C3=84=C3=AA1=C3=94=C3=8213=C3=88=C3=95 20:07
> > >> To: PI13 CFLi; sensors@Stimpy.netroedge.com
> > >> Cc: Patrick Mochel; PI10 LHHsu; PI14 DZSHEN; PI14 HUANG0
> > >> Subject: Re: A probelm of loading module i2c-ali1563.o
> > >>
> > >>
> > >> Hi,
> > >>
> > >> > While I'm trying to load the module of the south bridge chip (ULI =
M1563
> > >> > B1), it shows
> > >> >[root@localhost busses]# insmod ./i2c-ali15x3.o
> > >> >./i2c-ali15x3.o: init_module: No such device
> > >>
> > >> Expected, since the M1563 is not supported by this driver.
> > >>
> > >> > Is there any module named "i2c-ali1563"? I only found "i2c-ali15x3=
".
> > >> >
> > >> > Does i2c-2.8.8 support this chipset of ULi?
> > >>
> > >> There is an i2c-ali1563 driver specifically written by Patrick Moche=
l for
> > >> the M1563, but only available for Linux 2.6 at the moment:
> > >> http://archives.andrew.net.au/lm-sensors/msg26537.html
> > >>
> > >> You would need to port it back to 2.4 (i.e. to lm_sensors CVS). Patr=
ick
> > >> seems to think this would be easy.
> > >>
> > >> --
> > >> Jean Delvare
> > >
> >
> >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D> > =3D=3D=3D=3D=3D=3D=3D=3D=3DThe priv=
ileged confidential information contained in this
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
> > please ignore the following message. They essentially repeat the  Engli=
sh
> > statement above.=C2=A5=C2=BB=C2=ABH=C2=A5=C3=B3=C2=A4=C2=BA=C2=A9=C3=92=
=C2=A7t=C2=B5=C3=98=C2=A8=C2=B9=C2=B9q=C2=A4l=C2=AA=C2=BA=C2=B0]=C2=B2=C2=
=A3=C2=A9=C3=8A=C2=BE=C3=B7=C2=B1K=C2=A9=C3=8A=C2=B8=C3=AA=C2=B0T,
> > =C2=B6=C3=88=C2=B1=C3=82=C3=85v=C2=AD=C3=AC=C2=B5o=C2=ABH=C2=A4H=C2=AB=
=C3=BC=C2=A9w=C2=A4=C2=A7=C2=A6=C2=AC=C2=ABH=C2=A4H=C2=A8=C3=BA=C2=BE\=C2=
=A4=C2=A7=C2=A5=C3=8E.
> >
> =C2=B0=C2=B2=C2=A8=C3=8F=C2=B1z=C2=A8=C3=83=C2=ABD=C2=B3Q=C2=AB=C3=BC=C2=
=A9w=C2=A4=C2=A7=C2=A6=C2=AC=C2=ABH=C2=A4H=C2=A9=C3=8E=C2=A6]=C2=A5=C3=B4=
=C2=A6=C3=B3=C2=AD=C3=AC=C2=A6]=C2=A6b=C2=A5=C2=BC=C2=B8g=C2=B1=C3=82=C3=85=
v=C2=AA=C2=BA=C2=B1=C2=A1=C2=A7=C3=8E=C2=A4=C2=A7=C2=A4U=C2=A6=C2=AC=C2=A8=
=C3=AC=C2=A5=C2=BB=C2=AB
> > H=C2=A5=C3=B3, =C2=BD=C3=90=C2=B1z=C2=A7i=C2=AA=C2=BE=C2=AD=C3=AC=C2=B5=
o=C2=ABH=C2=A4H=C2=A8=C3=83=C2=A5=C3=9F=C2=A7Y=C2=B1N=C2=ABH=C2=A5=C3=B3=C2=
=B1q=C2=B9q=C2=B8=C2=A3=C2=BBP=C2=BA=C3=B4=C2=B8=C3=B4=C2=A6=C3=B8=C2=AAA=
=C2=BE=C2=B9=C2=A4=C2=A4=C2=A4=C2=A9=C2=A5H=C2=AE=C3=B8=C2=B0=C2=A3.
> > =C2=B9=C3=AF=C2=A9=C3=B3=C2=B1z=C2=AA=C2=BA=C2=A6X=C2=A7@, =C2=A7=C3=9A=
=C2=AD=C3=8C=C2=A5=C3=BD=C2=A6=C2=B9=C2=ADP=C3=81=C3=82. =C2=AFS=C2=A6=C2=
=B9=C2=B4=C2=A3=C2=BF=C3=B4, =C2=A5=C3=B4=C2=A6=C3=B3=C2=A5=C2=BC=C2=B8g=C2=
=B1=C3=82=C3=85v=C2=BE=C3=95=C2=A6=C3=9B=C2=A8=C3=8F=C2=A5=C3=8E=C2=B5=C3=
=98=C2=A8=C2=B9=C2=B9
> > q=C2=A4l=C2=AA=C2=BA=C2=BE=C3=B7=C2=B1K=C2=B8=C3=AA=C2=B0T=C2=AA=C2=BA=
=C2=A6=C3=A6=C2=AC=C2=B0=C2=ACO=C2=B3Q=C3=84Y=C2=AE=C3=A6=C2=B8T=C2=A4=C3=
=AE=C2=AA=C2=BA.
> > =C2=ABH=C2=A5=C3=B3=C2=BBP=C2=B5=C3=98=C2=A8=C2=B9=C2=B9q=C2=A4l=C3=80=
=C3=A7=C2=B7~=C2=B5L=C3=83=C3=B6=C2=A4=C2=A7=C2=A4=C2=BA=C2=AEe,=C2=A4=C2=
=A3=C2=B1o=C2=B5=C3=B8=C2=AC=C2=B0=C2=B5=C3=98=C2=A8=C2=B9=C2=B9q=C2=A4l=C2=
=A4=C2=A7=C2=A5=C3=9F=C2=B3=C3=B5=C2=A9=C3=8E=C2=B7N=C2=A8=C2=A3.

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
