From: grant_lkml@dodo.com.au (Grant Coady)
Date: Sun, 04 Sep 2005 15:18:00 +0000
Subject: [lm-sensors] lm78 on ep-61lxa-m not detected (#2042)
Message-Id: <sqslh1h1u14jiu62avhi7nbrbmvbqsmbs2@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <lcdlh19r75vv5je60he27tap49ggekrvfu@4ax.com>
In-Reply-To: <lcdlh19r75vv5je60he27tap49ggekrvfu@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,
On Sun, 4 Sep 2005 15:04:41 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>
>Oh, did I mention that you needed to load i2c-isa then?

root@silly:~# modprobe i2c_isa
root@silly:~# sensors
lm78-isa-0290
Adapter: ISA adapter
VCore 1:   +2.03 V  (min =3D  +0.13 V, max =3D  +0.77 V)   ALARM
VCore 2:   +1.49 V  (min =3D  +0.27 V, max =3D  +0.03 V)   ALARM
+3.3V:     +3.34 V  (min =3D  +0.45 V, max =3D  +0.38 V)   ALARM
+5V:       +5.08 V  (min =3D  +3.87 V, max =3D  +2.15 V)   ALARM
+12V:     +11.55 V  (min =3D  +0.12 V, max =3D  +5.84 V)   ALARM
-12V:     -10.29 V  (min =3D  -0.11 V, max =3D  -4.67 V)   ALARM
-5V:       -4.65 V  (min =3D  -1.69 V, max =3D  -0.10 V)   ALARM
fan1:        0 RPM  (min =3D   -1 RPM, div =3D 2)          ALARM
fan2:        0 RPM  (min =3D   -1 RPM, div =3D 2)          ALARM
fan3:        0 RPM  (min =3D 337500 RPM, div =3D 2)          ALARM
temp:      +25.0?C  (high =3D   +65?C, hyst =3D   +12?C)
vid:       +3.50 V
alarms:   Chassis intrusion detection                  ALARM

?? me puzzled, I had that in before, but not after the force command=20
you asked for, sorry.  Reboot and try again...

root@silly:~# modprobe i2c_isa
root@silly:~# modprobe lm78
root@silly:~# sensors
No sensors found!
root@silly:~# rmmod lm78
root@silly:~# modprobe lm78 force_lm78=9191,0x290
root@silly:~# sensors
lm78-isa-0290
Adapter: ISA adapter
VCore 1:   +2.03 V  (min =3D  +0.13 V, max =3D  +0.77 V)   ALARM
VCore 2:   +1.49 V  (min =3D  +0.27 V, max =3D  +0.03 V)   ALARM
+3.3V:     +3.33 V  (min =3D  +0.45 V, max =3D  +0.38 V)   ALARM
+5V:       +5.08 V  (min =3D  +3.87 V, max =3D  +2.15 V)   ALARM
+12V:     +11.55 V  (min =3D  +0.12 V, max =3D  +5.84 V)   ALARM
-12V:     -10.24 V  (min =3D  -0.11 V, max =3D  -4.67 V)   ALARM
-5V:       -4.65 V  (min =3D  -1.69 V, max =3D  -0.10 V)   ALARM
fan1:        0 RPM  (min =3D   -1 RPM, div =3D 2)          ALARM
fan2:        0 RPM  (min =3D   -1 RPM, div =3D 2)          ALARM
fan3:        0 RPM  (min =3D 337500 RPM, div =3D 2)          ALARM
temp:      +25.0?C  (high =3D   +65?C, hyst =3D   +12?C)
vid:       +3.50 V
alarms:   Chassis intrusion detection                  ALARM

Okay!  Thank you.  Above is uncalibrated, so it looks good.

Perhaps I'll throw in auto-fan-div, whatever, 'cos I can test it now.

Cheers,
Grant.

