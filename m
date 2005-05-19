From: jzhao@mountainviewdata.com (jack)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: Hi, would you help me about lm87?
Message-Id: <000a01c16736$4d826290$0a09010a@cn.mvd>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

      Ticket #: 718 Timestamp: 2001-11-05 22:23:20-08 Version/Environment: =
lm_sensors 2.6.0 linux 2.4.5=20
      Subject: Some errors in lm87 sensors? Category: unsorted=20
      Contact: jzhao@mountainviewdata.com  Client Machine: 211.99.247.66 St=
atus: Unconfirmed/Unexamined=20
      Problem in detail:=20
My hardware is supermicro=A1=E4s 370DER, and only one CPU.

http://www.supermicro.com/product/motherboards/rcc_he_sl/370DER.htm

When I run sensor to get the PC health, I get the output as following:

lm87-i2c-0-2d
Adapter: SMBus OSB4 adapter at 0580
Algorithm: Non-I2C SMBus adapter
2.5V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)
Vccp1:     +1.29 V  (min =3D  +2.55 V, max =3D  +2.84 V)   ALARM
3.3V:      +3.35 V  (min =3D  +3.12 V, max =3D  +3.47 V)
5V:        +5.05 V  (min =3D  +4.73 V, max =3D  +5.26 V)
12V:      +12.25 V  (min =3D +11.37 V, max =3D +12.62 V)
Vccp2:     +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)
fan1:        0 RPM  (min =3D 3000 RPM, div =3D 2)          ALARM
fan2:        0 RPM  (min =3D 3000 RPM, div =3D 2)          ALARM
temp1:    +42.0=B0C   (min =3D +10=B0C, max =3D +60=B0C)
CPU_Temp: +128.0=B0C   (min =3D +10=B0C, max =3D +60=B0C)  FAULT
vid:       +1.30 V

lm87-i2c-0-2e
Adapter: SMBus OSB4 adapter at 0580
Algorithm: Non-I2C SMBus adapter
2.5V:      +3.29 V  (min =3D  +1.41 V, max =3D  +1.57 V)   ALARM
Vccp1:     +1.68 V  (min =3D  +2.55 V, max =3D  +2.84 V)   ALARM
3.3V:      +3.35 V  (min =3D  +3.12 V, max =3D  +3.47 V)
5V:        +5.05 V  (min =3D  +4.73 V, max =3D  +5.26 V)
12V:      +12.18 V  (min =3D +11.37 V, max =3D +12.62 V)
Vccp2:     +1.49 V  (min =3D  +1.53 V, max =3D  +1.70 V)   ALARM
fan1:     4017 RPM  (min =3D 3000 RPM, div =3D 2)
fan2:        0 RPM  (min =3D 3000 RPM, div =3D 2)          ALARM
temp1:    +45.0=B0C   (min =3D +10=B0C, max =3D +60=B0C)
CPU_Temp: +55.0=B0C   (min =3D +10=B0C, max =3D +60=B0C)
vid:       +1.70 V

But I get data from BIOS is :
cpu1       56C
cpu2       N/A
Overheat   85C
cpu1 vcore 1.69
cpu2 vcore 1.29
+3.3v      3.35
+5v        5.07
+12v       12.25v
cpu fan1   4066
cpu fan2   N/A
chasis fan1N/A
chasis fan2N/A

Would you give me any advice?
I need this output to be correct very much.
Thank you !



    =20
      Reply from support:=20
(unresolved/unanswered)
    =20

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20011107/=
e155dc41/attachment.html
