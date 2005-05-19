From: Huang0@Winbond.com.tw (Huang0@Winbond.com.tw)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: Failed to backport i2c-ali1563.c from linux-2.6 to 2.4
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE1901B1@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE1900AB@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE1900AB@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Dear Patrick

After a further investigation with i2c-ali1563.c, I find that
only such functions as ali1563_init,ali1563_probe,ali1563_setup,
ali1563_func,ali1563_access, ali1563_transaction have been
executed when I load the related modules.
Some of the other functions have NOT been executed.

I'm NOT familiar with some debug messages written by you,
Such as:
Transaction (pre): STS=00, CNTL1=00, CNTL2=10, CMD=91, ADD@, DAT0=00, DAT1=
=00
Transaction (post): STSD, CNTL1=00, CNTL2=10, CMD=91, ADD@, DAT0=00, DAT1=00

I attached the log message when I load the modules, you may refer
it when you are free, it is quite detailed, maybe you can give me
the help by it. :-)

I also attached my i2c-ali1563.c with a lot of debug messages,
so that you can analyze the log message.


Thanks a lot

Best Regards
Chunhao


> -----Original Message-----
> From: PI14 HUANG0
> Sent: 2005=C4=EA1=D4=C228=C8=D5 09:51
> To: 'Patrick Mochel'
> Cc: 'LM Sensors'; PI14 DZSHEN; PI10 LHHsu; PI13 CFLi
> Subject: RE: Failed to backport i2c-ali1563.c from linux-2.6 to 2.4
>=20
> Hi Patrick
>=20
> Thanks for your reply.
>=20
> > If I get a chance, I'll take a look at it and try to get a 2.4 kernel
> > running, but my time is very limited right now, so I can't make any gua=
rantees.
> OK, I see, I wish you have some free time in the near future. :-)
>=20
> Since I have some time now, as well as the hardware/software platform, ma=
ybe
> you can give me some guidance as possible as you can, so that I can make =
it
> work as soon as possible. :-)
>=20
>=20
> > Why are you using 2.4 anyway? 2.6 is much better in many respects. :)
> There are about two reasons for us to choose 2.4 as our platform:
> (1) Our custom asked us to make Winbond W83792D chip work on linux-2.4,
>   especially on RedHat 9 at first.
> (2) It seems that lm_sensors for 2.6 is NOT so mature as 2.4(maybe, just
>   my personal guess )
>=20
>=20
> Thanks
>=20
> Best Regards
> Chunhao
>=20
>=20
> > -----Original Message-----
> > From: Patrick Mochel [mailto:mochel@digitalimplant.org]
> > Sent: 2005=C4=EA1=D4=C228=C8=D5 01:20
> > To: PI14 HUANG0
> > Subject: RE: Failed to backport i2c-ali1563.c from linux-2.6 to 2.4
> >
> >
> > On Thu, 27 Jan 2005 Huang0@Winbond.com.tw wrote:
> >
> > > Hi Patrick Mochel
> > >
> > > I want to backport your i2c-ali1563.c from linux-2.6 to 2.4,
> > > Would you please give me some help? Please refer to the follwing
> > > content for more information.
> >
> > I've seen your original messages, since you've cc'd me. I'm glad that y=
ou
> > took on the task of backporting the driver. I unfortunately do not work
> > with 2.4 much, and don't know anything about the i2c subsystem (the
> > ali1563 driver was my first work in it). If I get a chance, I'll take a
> > look at it and try to get a 2.4 kernel running, but my time is very
> > limited right now, so I can't make any guarantees.
> >
> > Why are you using 2.4 anyway? 2.6 is much better in many respects. :)
> >
> >
> > 	Patrick


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
ing message. They essentially repeat the&nbsp; English statement above.=A5=
=BB=ABH=A5=F3=A4=BA=A9=D2=A7t=B5=D8=A8=B9=B9q=A4l=AA=BA=B0]=B2=A3=A9=CA=BE=
=F7=B1K=A9=CA=B8=EA=B0T, =B6=C8=B1=C2=C5v=AD=EC=B5o=ABH=A4H=AB=FC=A9w=A4=A7=
=A6=AC=ABH=A4H=A8=FA=BE\=A4=A7=A5=CE. =B0=B2=A8=CF=B1z=A8=C3=ABD=B3Q=AB=FC=
=A9w=A4=A7=A6=AC=ABH=A4H=A9=CE=A6]=A5=F4=A6=F3=AD=EC=A6]=A6b=A5=BC=B8g=B1=
=C2=C5v=AA=BA=B1=A1=A7=CE=A4=A7=A4U=A6=AC=A8=EC=A5=BB=ABH=A5=F3, =BD=D0=B1z=
=A7i=AA=BE=AD=EC=B5o=ABH=A4H=A8=C3=A5=DF=A7Y=B1N=ABH=A5=F3=B1q=B9q=B8=A3=BB=
P=BA=F4=B8=F4=A6=F8=AAA=BE=B9=A4=A4=A4=A9=A5H=AE=F8=B0=A3. =B9=EF=A9=F3=B1z=
=AA=BA=A6X=A7@, =A7=DA=AD=CC=A5=FD=A6=B9=ADP=C1=C2. =AFS=A6=B9=B4=A3=BF=F4,=
 =A5=F4=A6=F3=A5=BC=B8g=B1=C2=C5v=BE=D5=A6=DB=A8=CF=A5=CE=B5=D8=A8=B9=B9q=
=A4l=AA=BA=BE=F7=B1K=B8=EA=B0T=AA=BA=A6=E6=AC=B0=ACO=B3Q=C4Y=AE=E6=B8T=A4=
=EE=AA=BA. =ABH=A5=F3=BBP=B5=D8=A8=B9=B9q=A4l=C0=E7=B7~=B5L=C3=F6=A4=A7=A4=
=BA=AEe,=A4=A3=B1o=B5=F8=AC=B0=B5=D8=A8=B9=B9q=A4l=A4=A7=A5=DF=B3=F5=A9=CE=
=B7N=A8=A3.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-ali1563.rar
Type: application/octet-stream
Size: 4273 bytes
Desc: i2c-ali1563.rar
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050128=
/7b40275f/i2c-ali1563.obj
