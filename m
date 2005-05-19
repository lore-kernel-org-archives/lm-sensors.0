From: Huang0@Winbond.com.tw (Huang0@Winbond.com.tw)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE1906E6@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean, MDS

I have one more question:
Now, I have both linux-2.6.10 and linux-2.6.11-rc3 installed in my PC,
I'm going to use the first one as my porting platform.

Provided that I have successfully ported w83792d.c from linux-2.4 to 2.6,
How should I add it into the linux kernel tree linux-2.6.10 for test?
I have tried the following steps:
(1)Add a file w83792d.c into the directory
  /usr/src/linux-2.6.10/drivers/i2c/chips/
(2) modify /usr/src/linux-2.6.10/drivers/i2c/chips/Makefile (add 792 part)
(3) modify /usr/src/linux-2.6.10/.config (add 792 part)
(4) make modules(or "make") [note: current dir is /usr/src/linux-2.6.10/ ]
But it failed, it seems that only the above operations are NOT enough,=20
Would you please tell me in detail on how to build the porting
environment under linux-2.6?
I'm very sorry that I have few experience about it.

Btw, the Documentation/i2c/writing-clients in linux-2.6.10 and linux-2.6.11=
-rc3
is NOT for linux-2.6, but for linux-2.4. You need to update it.


Thanks
Best Regards

Chunhao
2005-02-04


> -----Original Message-----
> From: PI14 HUANG0
> Sent: 2005=E5=B9=B42=E6=9C=884=E6=97=A5 11:06
> To: 'Jean Delvare'; 'Mark Studebaker'
> Cc: LM Sensors; PI10 LHHsu; PI14 DZSHEN; PI13 CFLi
> Subject: RE: We will port w83792d.c to linux-2.6
>=20
> Hi Jean, MDS
>=20
>=20
> > This is good news. That said, we don't really have to wait for you to
> > finish porting to 2.6 before we commit your 2.4 driver to lm_sensors
> > CVS. Both sides are mostly independent. I guess we can commit the 2.4
> > driver as soon as MDS is happy with your code (I admit I don't have
> > much time to review it myself).
>=20
> I agree that 792 driver for 2.4 and 2.6 are independent, one of my
> colleagues will help me to test the 792 driver for linux-2.4, when he
> get another ASUS motherboard with 792 chip a few days later.
>=20
> I think there should NOT be many bugs in 792 driver for 2.4 after the rev=
iew
> of MDS and me, and wish to commit it into CVS as soon as possible. But my=
 manager
> suggested that I commit it only after a full test, so that we can avoid s=
ome
> na=C3=AFve
> bugs, I agree with him now, but this will lead to the delay in committing
> the 792 driver.
>=20
>=20
> > Yes, you should always stick to whatever the latest 2.6 tree is. That w=
ay
> > you are certain that your code with comply with the latest evolution of
> > the 2.6 i2c core.
> >
> > When the driver is ready, you will have to send it to Greg KH, in the
> > form of a patch against the latest linux 2.6-mm version. Hopefully,
> > changes won't be too big between the latest standard 2.6 tree and the
> > 2.6-mm version, so you won't have much to change at this point. You may
> > work directly with the latest -mm version if you want, but these are
> > typically less stable that the regular versions, so I wouldn't
> > recommend them as a development environment.
>=20
> I agree with you, now I'm compiling the kernel linux-2.6.10, which is sta=
ble.
> I have checked that there are few difference in some bus drivers between
> linux-2.6.10 and linux-2.6.11-rc3.
>=20
>=20
> > I tried to make Documentation/i2c/porting-clients as accurate as
> > possible, but I may have missed recent changes done to the i2c subsystem
> > in 2.6. If you find errors or missing information, please let me know so
> > that I can update the document.
>=20
> OK, no problem.:-)
>=20
> > Also note that the sysfs interface to hardware monitoring chips in 2.6 =
is
> > more standardized than the procfs one in 2.4 was, and you really have to
> > stick to that standard. See Documentation/i2c/sysfs-interface for
> > details. If you have questions about this or find an error in this
> > document, let us know as well.
>=20
> Yes, after the examination to the sysfs-interface of W83627THF(it is on my
> motherboard), I find it's really different with the interface of linux-2.4
>=20
> And we have one question:
> we want to add some other sys-interfaces about Winbond Smart FanI and Fan=
II,
> for example, in the 792 driver of linux-2.4, I added such interfaces:
> fan_cfg,
> pwm_flag,
> pwm[1-3],
> thermal_cruise,
> fan_tolerance,
> sf2_levels_fan[1-3],
> sf2_points_fan[1-3]
> [Note: Please refer to the mail and attached pictures sent by me on 2005-=
01-24]
> If I also want to add these interfaces into 792 driver for linux-2.6,
> How should I stick to the standard Documentation/i2c/sysfs-interface?
> Because it seems that it has no description about SmartFan.
>=20
> Thanks
> Best Regards
>=20
> Chunhao
> 2005-02-04


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
