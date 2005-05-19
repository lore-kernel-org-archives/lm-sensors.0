From: frodol@dds.nl (frodol@dds.nl)
Date: Thu, 19 May 2005 06:23:28 +0000
Subject: Fw: I would like to subscribe to your mailing list & other (fwd)
Message-Id: <200201151735.g0FHZms02909@shire.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <E16QQ4h-000Ldi-00@f6.mail.ru>
In-Reply-To: <E16QQ4h-000Ldi-00@f6.mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Kirill Smelkov wrote:
From kirill_smelkov@mail.ru Tue Jan 15 13:40:05 2002
Received: by morannon.frodo.local (8.11.3/8.11.3) id g0FCe4N14730 ; Tue, 15=
 Jan 2002 13:40:05 +0100
Return-Path: <kirill_smelkov@mail.ru>
Delivered-To: frodol@dds.nl
Received: from pop3.dds.nl [213.196.1.122]
	by localhost with POP3 (fetchmail-5.4.4)
	for frodo@localhost (single-drop); Tue, 15 Jan 2002 13:40:05 +0100 (CET)
Received: (qmail 24150 invoked from network); 15 Jan 2002 12:38:18 -0000
Received: from unknown (HELO mx2.port.ru) ([194.67.57.12]) (envelope-sender=
 <kirill?smelkov@mail.ru>)
          by mail.io.nl (qmail-ldap-1.03) with SMTP
          for <frodol@dds.nl>; 15 Jan 2002 12:38:18 -0000
Received: from f7.int ([10.0.0.104] helo=F7.mail.ru)
	by mx2.port.ru with esmtp (Exim 3.14 #1)
	id 16QSr4-000LdU-00; Tue, 15 Jan 2002 15:38:18 +0300
Received: from mail by f7.mail.ru with local (Exim 3.14 #1)
	id 16QSr4-000FOt-00; Tue, 15 Jan 2002 15:38:18 +0300
Received: from [217.146.195.97] by win.mail.ru with HTTP;
	Tue, 15 Jan 2002 15:38:18 +0300
From: "Kirill Smelkov" <kirill_smelkov@mail.ru>
To: frodol@dds.nl
Cc: phil@netroedge.com, kmalkki@cc.hut.fi, mdsxyz123@yahoo.com
Subject: Fw: I would like to subscribe to your mailing list & other
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [217.146.195.97]
Date: Tue, 15 Jan 2002 15:38:18 +0300
Reply-To: "Kirill Smelkov" <kirill_smelkov@mail.ru>
Content-Type: text/plain; charset=3Dkoi8-r
Content-Transfer-Encoding: 8bit
Message-Id: <E16QSr4-000FOt-00@f7.mail.ru>

I've tried to send this to sensors@stimpy.netroedge.com but failed.
So i hope you will read it.

-----Original Message-----
From: "Kirill Smelkov" <kirill_smelkov@mail.ru>
To: sensors@stimpy.netroedge.com
Date: Tue, 15 Jan 2002 12:40:11 +0300
Subject: I would like to subscribe to your mailing list & other

>=20
> Hello. I would like to subscribe to lm_sensors mailing list.
> Could it be possible?
>=20
> Also i include my first question. If someone could help -- it will be gre=
at.
>=20
> Hi Folks.
>=20
> Recently we tried to get lm_sensors 2.6.2 working on our i810e motherboar=
d but
> unfortunately a problem occured.
>=20
> ------------------------------------
> Here follows the problem description:
>=20
> We want to get an I2C driver for graphics related stuff found in intel bo=
ards
> such as DDC bus & I2C bus which is usually
> connected to tv encoders.
>=20
> the kernel driver related to this stuff (as i suppose) is named i2c-i810.=
c and
> supports only next pci sub id's:
> 0x7121
> 0x7123
> 0x1132
>=20
> As i think we have the next version of 0x7123 chip (CGC rev 03). Here is a
part
> of lspci & lspci -n output
>=20
> 00:00.0 Host bridge: Intel Corporation 82810E GMCH [Graphics Memory Contr=
oller
> Hub] (rev 03)
> 00:01.0 VGA compatible controller: Intel Corporation 82810E CGC [Chipset
> Graphics Controller] (rev 03)
>=20
> 00:00.0 Class 0600: 8086:7124 (rev 03)
> 00:01.0 Class 0300: 8086:7125 (rev 03)
>=20
> the problem is that this hardware is not supported by driver.
>=20
> I've tried to add 7125 support to the driver -- it loads, operates, but no
> devices are found on any bus
> (though monitor & tv encoder should respond) by the program "i2cdetect":
>=20
>=20
> Script started on Tue Jan 15 11:48:02 2002
> =1B]0;root@smolensk:
> /opt/terminus/src/i810-tv/related/lm_sensors-2.6.2/prog/detect=07[root@sm=
olensk
> detect]# ./i2cdetect=20
> Error: No i2c-bus specified!
> Syntax: i2cdetect I2CBUS
>   I2CBUS is an integer
>   Installed I2C busses:
>     i2c-0	smbus    	SMBus I801 adapter at 5000      	Non-I2C SMBus adapter
>=20
>     i2c-1	i2c       	I810/I815 I2C Adapter           	Bit-shift algorithm
>=20
>     i2c-2	i2c       	I810/I815 DDC Adapter           	Bit-shift algorithm
>=20
> =1B]0;root@smolensk:
> /opt/terminus/src/i810-tv/related/lm_sensors-2.6.2/prog/detect=07[root@sm=
olensk
> detect]# ./i2cdetect 1
>   WARNING! This program can confuse your I2C bus, cause data loss and wor=
se!
>   I will probe file /dev/i2c-1
>   You have five seconds to reconsider and press CTRL-C!
>=20
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX=20
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX=20
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX=20
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX=20
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX=20
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX=20
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX=20
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX=20
>=20
> [...]
>=20
> and the same for i2c-2 bus
>=20
> Script done on Tue Jan 15 11:57:18 2002
>=20
> Note that an i2cdetect scan takes about 5 minutes with 100% cpu load.
>=20
> Accoring to intel documentation the driver preforms (to my unexpirienced =
view)
> right operations
> (i mean GPIOA & GPIOB are correct & other constants are ok)
>=20
> PLEASE CONSIDER HELP WITH OUR PROBLEM
>=20
>=20
>      Regards Kirr.
>=20
>=20



--=20
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~fr=
odol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually follow=
ed
  by the installation of Linux or some other Unix-like operating system.
