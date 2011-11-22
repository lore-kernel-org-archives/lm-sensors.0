From: Trevor Shiwnath <trevor_shiwnath@hotmail.com>
Date: Tue, 22 Nov 2011 14:03:38 +0000
Subject: [lm-sensors] Cross Compiling for ARM
Message-Id: <BLU162-W147C2EEC02769A3F8016868EC80@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2412258391830753971=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============2412258391830753971==
Content-Type: multipart/alternative;
	boundary="_8eaccfd7-7eba-4696-a2ff-f046fa709bd3_"

--_8eaccfd7-7eba-4696-a2ff-f046fa709bd3_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello=2C

This is my first time sending an email to a mailing list=2C so please bare =
with me. I have an Embedded ARM-Linux system running kernel version 2.6.27 =
and I wanted to cross compile lm-sensors version 3.3.1 onto it. I am a litt=
le familiar with cross compiling and editing makefiles for my device. When =
I change "CC" in the make file from gcc to arm-linux-gcc=2C it compiles fin=
e=2C but when I transfer the program files onto my Embedded system and atte=
mpt to run "sensors"=2C it tells me "sensors: '/lib/libsensors.so.4' is not=
 an ELF file". What could I possibly change in the makefile to make the lib=
raries compile properly with the ARM-Linux environment?

Thanks to anyone who reads this.
 		 	   		  =

--_8eaccfd7-7eba-4696-a2ff-f046fa709bd3_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style>
</head>
<body class=3D'hmmessage'><div dir=3D'ltr'>
Hello=2C<br><br>This is my first time sending an email to a mailing list=2C=
 so please bare with me. I have an Embedded ARM-Linux system running kernel=
 version 2.6.27 and I wanted to cross compile lm-sensors version 3.3.1 onto=
 it. I am a little familiar with cross compiling and editing makefiles for =
my device. When I change "CC" in the make file from gcc to arm-linux-gcc=2C=
 it compiles fine=2C but when I transfer the program files onto my Embedded=
 system and attempt to run "sensors"=2C it tells me "sensors: '/lib/libsens=
ors.so.4' is not an ELF file". What could I possibly change in the makefile=
 to make the libraries compile properly with the ARM-Linux environment?<br>=
<br>Thanks to anyone who reads this.<br> 		 	   		  </div></body>
</html>=

--_8eaccfd7-7eba-4696-a2ff-f046fa709bd3_--


--===============2412258391830753971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2412258391830753971==--
