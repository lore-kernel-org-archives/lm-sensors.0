From: dieter.jurzitza@t-online.de (Dieter Jurzitza)
Date: Tue, 28 Mar 2006 19:50:16 +0000
Subject: [lm-sensors] Question on my mainboard
Message-Id: <200603282150.16130.dieter.jurzitza@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Dear listmembers,
I am using several Tyan Tiger 2460 motherboards since quite a while. And I =
am=20
observing a strange behaviour someone in the list (might) have a clue about.

I am reading the sensors data periodically every 10 seconds. After an=20
undefined time (maybe one week, maybe one day, maybe three weeks) sensors=20
"hangs" after start and cannot be killed any more. A manual call to sensors=
=20
ends in a hang as well (of sensors, the board is running on).

What is my configuration:
I am loading=20
MODULE_0=3Di2c-amd756
MODULE_1=3Di2c-isa
MODULE_2=3Dw83781d
MODULE_3=EEprom
MODULE_4=3Dw83627hf
(in this sequence).

By recommendation from Tyan I use the line:
options w83781d force_w83782d=3D0,0x2d force_subclients=3D0,0x2d,0x48,0x49 =

force_w83627hf=3D0,0x2c force_subclients=3D0,0x2c,0x4a,0x4b init=3D0

in /etc/modprobe.conf.local

I have a script watchtemp that is started at boot that calls sensors every =
10=20
seconds; at boot it is called once with the parameter DAEMON, later on only=
=20
once with watchtemp what gives me a temperature display on the screen.

If someone finds the time to look into it and may give me a hint - greatly =

appreciated. I cannot force the behaviour described above - it just happens=
=20
to occur after a while.

Besides the many "SuSEisms" in the script it (might) be useful for someone =

because it is very simple. If of interest I could provide a rpm / srpm for =

SuSE installing all the required components at the right places.

I am using sensors version 2.10.0 with libsensors version 2.10.0 on SuSE 9.=
3=20
SMP.

Many thanks for your efforts in advance,
take care



Dieter Jurzitza




--=20
-----------------------------------------------------------

                               |
                                \
                 /\_/\           |
                | ~x~ |/-----\   /
                 \   /-       \_/
  ^^__   _        /  _  ____   /
 <??__ \- \_/     |  |/    |  |
  ||  ||         _| _|    _| _|

if you really want to see the pictures above - use some font
with constant spacing like courier! :-)
-----------------------------------------------------------
-------------- next part --------------
A non-text attachment was scrubbed...
Name: watchtemp
Type: application/x-shellscript
Size: 2731 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060328=
/72b1c2ad/watchtemp.bin
