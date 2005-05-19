From: da_master937@hotmail.com (The Master)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: beeping issues
Message-Id: <Sea1-F131BzHSSK5Q1Y0001999d@hotmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030721094037.55d98610.khali@linux-fr.org>
In-Reply-To: <20030721094037.55d98610.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Scroll to bottom for attached original message.

Steps 3, 4, and 5 result in turning my computer off. I didn't attempt any=20
other steps.

I have devised a workaround to the problem which works in my case:

For my respective chip (chip "as99127f-*") I located in sensors.conf the=20
line
set in0_max vid*1.05
and changed it to:
set in0_max vid*1.16

Afterwards I ran the command "sensors -s" as root and the beeping stopped. =
I=20
think the values you have for the motherboards "VCore 1" maximum is=20
incorrect which gave me an "ALARM".

Sensors Stats:
as99127f-i2c-1-2d
Adapter: SMBus I801 adapter at e800
VCore 1:   +1.55 V  (min =3D  +1.28 V, max =3D  +1.56 V)       ALARM
VCore 2:   +1.55 V  (min =3D  +1.28 V, max =3D  +1.40 V)
+3.3V:     +3.37 V  (min =3D  +3.13 V, max =3D  +3.45 V)
+5V:       +5.02 V  (min =3D  +4.72 V, max =3D  +5.24 V)
+12V:     +11.55 V  (min =3D +10.79 V, max =3D +13.19 V)
-12V:     -12.08 V  (min =3D  -0.00 V, max =3D  -0.00 V)
-5V:       -4.58 V  (min =3D  -0.00 V, max =3D  -0.00 V)
fan1:        0 RPM  (min =3D 3000 RPM, div =3D 2)
fan2:        0 RPM  (min =3D  750 RPM, div =3D 8)
fan3:     2934 RPM  (min =3D 3000 RPM, div =3D 2)              ALARM
MBoard:      +35=B0C  (limit =3D  +60=B0C)
CPU:       +42.4=B0C  (limit =3D +120=B0C, hysteresis =3D +100=B0C)
temp3:    +255.4=B0C  (limit =3D +120=B0C, hysteresis =3D +100=B0C)
vid:      +1.350 V
alarms:
beep_enable:
          Sound alarm enabled

Algorithm: Non-I2C SMBus adapter

Those are the sensors stats after my modification was applied. Even though =

sensors now declares ALARM, the computer is perfectly quiet.

The only trouble is everytime my comp is turned on, I must type "sensors -s=
"=20
to stop beeping.

Thanks,

da_master937@hotmail.com

>From: Jean Delvare <khali@linux-fr.org>
>Reply-To: sensors@stimpy.netroedge.com
>To: da_master937@hotmail.com, digo@digo-home.de, pgaige@cadesis.com
>CC: sensors@stimpy.netroedge.com
>Subject: beeping issues
>Date: Mon, 21 Jul 2003 09:40:37 +0200
>MIME-Version: 1.0
>Received: from mallaury.noc.nerim.net ([62.4.17.101]) by=20
>mc7-f26.law1.hotmail.com with Microsoft SMTPSVC(5.0.2195.5600); Mon, 21 Ju=
l=20
>2003 00:39:59 -0700
>Received: from arrakis.delvare (delvare.adsl.nerim.net [62.212.110.94])by =

>mallaury.noc.nerim.net (Postfix) with SMTPid BACE462D15; Mon, 21 Jul 2003 =

>09:39:57 +0200 (CEST)
>X-Message-Info: JGTYoYF78jEHjJx36Oi8+Q1OJDRSDidP
>Message-Id: <20030721094037.55d98610.khali@linux-fr.org>
>X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
>Return-Path: khali@linux-fr.org
>X-OriginalArrivalTime: 21 Jul 2003 07:40:00.0213 (UTC)=20
>FILETIME=3D[4A354850:01C34F5B]
>
>
>Hi folks,
>
>The three of you reported a similar problem when using lm_sensors. You
>complained about your PC beeping as soon as you load the w83781d module.
>All of you have an Asus motherboard (P4B533, P4B266 and P4S8X,
>respectively) with an AS99127F monitoring chipset.
>
>We lack documentation about the AS99127F, which explains why we are
>having difficulties understanding why what happens happens.
>
>I would like you do to some tests to help us find out what the problem
>is. Here is a wishlist:
>
>1* The output of sensors (while the PC is beeping).
>2* The output of "cat /proc/sys/dev/sensors/as99127f-i2c-0-2d/beep" (or
>whatever the file is at for you).
>3* Does the beeping stop if you echo "0" to that file?
>4* Does the beeping stop if you echo "0 32768" to that file?
>5* Does the beeping stop if you echo "0 0" to that file?
>6* The output of "cat /proc/sys/dev/sensors/as99127f-i2c-0-2d/alarms"
>(or whatever the file is at for you).
>7* The output of "i2cdump 0 0x2d" (or whatever the values are supposed
>to be on your system). You better unload w83781d before running this
>command.
>
>Thanks for your help, I hope we'll find some way to solve the problem.
>
>--
>Jean Delvare
>http://www.ensicaen.ismra.fr/~delvare/

_________________________________________________________________
MSN 8 helps eliminate e-mail viruses. Get 2 months FREE*. =20
http://join.msn.com/?page=FEatures/virus
