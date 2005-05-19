From: Huang0@Winbond.com.tw (Huang0@Winbond.com.tw)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: A question when test W83792D driver on another motherboard
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE245618@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190C6C@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190C6C@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean and Rudolf

The following message is from one of my colleague, for your reference.

***********************
As the ASUS RD said, writing this port will make the system switch to the i=
2c bus where our 792 chip resides.

According to his information, all ASUS server motherboard use this step to =
do the bus switching job.

Therefore, we might be able to apply the same codes on every server boards =
made by ASUS.

However, we should confirm the way of judging whether a motherboard adopt t=
his step to switch buses.

JS and YS are going to contact ASUS for more information. We will send more=
 detail after it is done.
*************************


Best Regards
Chunhao


> -----Original Message-----
> From: Rudolf Marek [mailto:R.Marek@sh.cvut.cz]
> Sent: 2005=E5=B9=B42=E6=9C=8824=E6=97=A5 19:48
> To: PI14 HUANG0
> Cc: R.Marek@sh.cvut.cz; khali@linux-fr.org; sensors@Stimpy.netroedge.com;
> PI10 LHHsu; PI14 DZSHEN; PI13 CFLi
> Subject: RE: A question when test W83792D driver on another motherboard
>=20
> Hello,
>=20
> WRITE_PORT_UCHAR((PUCHAR)0x04b9, 0x08);
>=20
> This is like "nuclear secret". Please have you any idea what device
> is on port 0x4b9 ? You can take a look either to:
>=20
> cat /proc/ioports or to windows device manager/list devices by IO ports
>=20
> Thanks
>=20
> Rudolf
>=20
>=20
> On Thu, 24 Feb 2005 Huang0@Winbond.com.tw wrote:
>=20
> > Hi Rudolf, Jean
> >
> > Our 792 driver for Windows can work now after the debug, I'd like to
> > send to how they solve this problem, maybe this can help to solve the
> > problem we meet under Linux.
> >
> > Windows driver only add one line code in it's i2c driver, which makes
> > 792 work correctly, the code has been added is:
> > WRITE_PORT_UCHAR((PUCHAR)0x04b9, 0x08);
> >
> > I'd like to send part of the Windows codes for your reference, please
> > check it. If you know how to fix the bug of i2c Linux driver, please te=
ll
> > me, I'd like to debug it.
> >
> > Btw, I have not received the reply from ASUS, when I get it, I will
> > forward it to you.
> >
> > Thanks
> > Best Regards
> >
> > ********************************************
> > NTSTATUS
> > GpdIoctlGetSMBusAddress(
> > 	IN PLOCAL_DEVICE_INFO pLDI,
> > 	IN PIRP pIrp,
> > 	IN PIO_STACK_LOCATION IrpStack,
> > 	IN ULONG IoctlCode  )
> >
> > {
> > 				// NOTE:  Use METHOD_BUFFERED ioctls.
> > 	PULONG pIOBuffer;           // Pointer to transfer buffer
> > 				//      (treated as an array of longs).
> > 	ULONG InBufferSize;         // Amount of data avail. from caller.
> > 	ULONG OutBufferSize;        // Max data that caller can accept.
> > 	ULONG nPort;                // Port number to read
> > 	ULONG DataBufferSize;
> > 	ULONG  BaseAddr;
> > 	ULONG  Result ;
> > 	unsigned char flag,data;
> >
> > 	// Size of buffer for data to be sent to application
> > 	OutBufferSize > IrpStack->Parameters.DeviceIoControl.OutputBufferLengt=
h;
> >
> > 	// NT copies inbuf here before entry and copies this to outbuf after
> > 	// return, for METHOD_BUFFERED IOCTL's.
> > 	pIOBuffer =3D (PULONG)pIrp->AssociatedIrp.SystemBuffer;
> >
> > 	// Check to ensure input buffer is big enough to hold a port number and
> > 	// the output buffer is at least as big as the port data width.
> >
> > 		//intel p2x4
> > 		Result =3D GetSMBusBaseAddr( &BaseAddr, 0x8086 , 0x7113  ,0x90);
> >
> > 		if (Result !=3D 0 )
> > 		{
> > 			flag=3DEnableICHSMBusController(0X8086,0x24c0,0xf2,&data);
> > 			// intel ich5 update 02.20.2003
> > 			Result =3D GetSMBusBaseAddr( &BaseAddr, 0x8086 , 0x24d3  ,0x20);
> > 			if(flag)
> > 				RestoreICHSMBusController(0X8086,0x24c0,0xf2,data);
> > 			if(Result=3D0)
> > 				ChipSetType=3D1;
> > 		}
> >
> > 		if (Result !=3D 0 )
> > 		{
> > 			WRITE_PORT_UCHAR((PUCHAR)0x04b9, 0x08);  /* here!!! */
> > 			flag=3DEnableICHSMBusController(0X8086,0x24c0,0xf2,&data);
> > 			// intel ich5(Server) update 12.22.2003
> > 			Result =3D GetSMBusBaseAddr( &BaseAddr, 0x8086 , 0x25a4  ,0x20);
> > 			if(flag)
> > 				RestoreICHSMBusController(0X8086,0x24c0,0xf2,data);
> > 			if(Result=3D0)
> > 				ChipSetType=3D1;
> > 		}
> > .................
> > }
> >
> >
> > Chunhao
> > 2005-02-24
> >
> >
> > > -----Original Message-----
> > > From: PI14 HUANG0
> > > Sent: 2005=E5=B9=B42=E6=9C=8824=E6=97=A5 14:25
> > > To: 'Rudolf Marek'; 'Jean Delvare'
> > > Cc: sensors@Stimpy.netroedge.com; PI10 LHHsu; PI14 DZSHEN; PI13 CFLi
> > > Subject: RE: A question when test W83792D driver on another motherboa=
rd
> > >
> > > Hi Rudolf, Jean
> > >
> > > Thank you for your reply.
> > >
> > > I will try the commands you gave me after a while, because the PC with
> > > that motherboard is under Windows now. after my test, then I will sen=
d you
> > > the output message in another mail.
> > >
> > > Our 792 Windows driver can NOT work on this motherboard either, one of
> > > my colleague is debugging it under Windows, and we also will contact =
ASUS
> > > with the questions you provided, then forward you the answer.
> > >
> > > Thanks
> > > Best Regards
> > > Chunhao
> > > 2005-02-24
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Rudolf Marek [mailto:R.Marek@sh.cvut.cz]
> > > > Sent: 2005=E5=B9=B42=E6=9C=8823=E6=97=A5 19:21
> > > > To: PI14 HUANG0
> > > > Cc: sensors@Stimpy.netroedge.com; PI10 LHHsu; PI14 DZSHEN; PI13 CFLi
> > > > Subject: RE: A question when test W83792D driver on another motherb=
oard
> > > >
> > > > Hello,
> > > >
> > > > Here is Rudolf speaking.
> > > > I'm the second person who played with hidden 792D.
> > > >
> > > > I think the function fails because nothing listens on that address.
> > > > (Khali/Jean can you confirm?)
> > > >
> > > > you can try:
> > > >
> > > > modprobe i2c-dev
> > > > i2cdetect -l
> > > >
> > > > You will see the bus number you will use in next command.
> > > >
> > > > i2cdetect 0
> > > >
> > > > 0 Is my bus number.
> > > >
> > > > This command will probe i2c addresses to find all clients.
> > > > If you will see XX on that address where should be 792D. Then it is
> > > > hidden.
> > > >
> > > > Asus put some simple multiplexer to hide it. We think they use GPIO=
 lines
> > > > from superIO. Ask what lines to trigger to unhide it.
> > > > (Logical device and what GPIO line from that group)
> > > >
> > > > I hope this helps.
> > > >
> > > > Regards
> > > >
> > > > Rudolf
> > > >
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
> please ignore the following message. They essentially repeat the&nbsp; En=
glish
> statement above.=E3=82=BB=E7=8D=BA=E3=83=B3=E3=81=9A=E2=94=AE=EE=9C=BA=E5=
=9C=B0=C3=BC=E7=AD=BF=EE=98=92=EE=80=99=E7=99=A9=E7=8E=BB=E2=94=A6=E8=AF=80=
=E7=9B=9E=E2=94=A6=E6=88=88=E7=99=9F, =E5=BA=A6=E7=94=AD=E8=88=A6=EE=85=A5=
=E7=A5=87=E7=8D=BA=EE=97=AE=EE=82=B9=EF=B9=9A
> =E3=81=87=CE=9C=E7=8D=BA=EE=97=AE=EE=9F=9D=E7=B6=B7=E3=81=87=E3=83=8E. =
=E5=AE=89=E3=84=8F=E7=9C=A4=EE=9F=8B=E7=8D=B6=E7=A0=86=EE=82=B9=EF=B9=9A=E3=
=81=87=CE=9C=E7=8D=BA=EE=97=AE=E2=94=AA=EE=9B=83=E3=83=B4=EE=9E=96=EE=85=A5=
=EE=9B=83=EE=9B=88=E3=82=BC=E7=AB=92=E7=94=AD=E8=88=A6=EE=80=99=E8=96=84=EE=
=9E=AC=E3=81=87=EE=97=BB
> =CE=9C=EE=9F=8F=E3=82=BB=E7=8D=BA=E3=83=B3, =E5=8F=AB=E7=9C=A4=EE=9C=AF=
=EE=80=9D=EE=85=A5=E7=A5=87=E7=8D=BA=EE=97=AE=EE=9F=8B=E3=83=9F=EE=9C=9F=E7=
=9B=A2=E7=8D=BA=E3=83=B3=E7=9C=96=E7=AD=BF=E7=A6=8F=E7=B1=94=E5=91=BC=E9=9A=
=94=EE=9E=99=E7=8B=9D=E7=AB=9F=E3=81=84=E3=81=89=EE=99=8E=EE=87=8F=E5=9F=83=
. =E7=99=B8=EE=A0=84
> =E7=9C=A4=EE=80=99=EE=9A=BE=EE=9C=86, =D0=B8=EE=85=85=EE=9E=83=EE=9E=85=
=E7=92=93=E8=B0=85. =E7=96=AD=EE=9E=85=E7=9F=97=E7=9C=B6, =E3=83=B4=EE=9E=
=96=E3=82=BC=E7=AB=92=E7=94=AD=E8=88=A6=E8=8F=8A=EE=9E=8F=E3=84=8F=E3=83=8E=
=E5=9C=B0=C3=BC=E7=AD=BF=EE=98=92=EE=80=99=E8=AF=80=E7=9B=9E=E6=88=88=E7=99=
=9F=EE=80=99
> =EF=B8=BD=EE=83=8B=E7=90=8C=E7=A0=86=E8=85=A8=EE=86=BD=E7=AA=BD=E3=82=8E=
=EE=80=99. =E7=8D=BA=E3=83=B3=E7=B1=94=E5=9C=B0=C3=BC=E7=AD=BF=EE=98=92=E7=
=8A=81=E7=A9=A8=E7=A4=9A=E9=97=BD=E3=81=87=E3=81=9A=E7=94=A7,=E3=81=83=E7=
=9C=94=E8=B7=8C=EE=83=8B=E5=9C=B0=C3=BC=E7=AD=BF=EE=98=92=E3=81=87=E3=83=9F=
=E5=88=9D=E2=94=AA=E7=A8=AE
> =C7=8E.
> >

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
