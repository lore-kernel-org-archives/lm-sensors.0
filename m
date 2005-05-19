From: Robert.L.Harris@rdlg.net (Robert L. Harris)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: Sensors wrapup?
Message-Id: <20021115140810.GA15246@rdlg.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org



  I'm reading through the "old news" and current tickets concerning the
tyan 2466.  Using the difinitive sensors.conf from ticket 941 and the
default "modules options" I get this:

root@rharris-build1.acs:~# sensors
w83627hf-i2c-0-2c
Adapter: SMBus AMD768 adapter at 80e0
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.69 V  (min =3D  +1.66 V, max =3D  +1.82 V)             =20
VCore 2:   +1.71 V  (min =3D  +1.66 V, max =3D  +1.82 V)             =20
+3.3V:     +3.34 V  (min =3D  +3.13 V, max =3D  +3.45 V)             =20
+12V:     +11.66 V  (min =3D +10.80 V, max =3D +13.20 V)             =20
-12V:     -12.70 V  (min =3D -13.21 V, max =3D -10.90 V)             =20
CPU1 Fan: 4856 RPM  (min =3D 3000 RPM, div =3D 2)                    =20
CPU2 Fan: 4821 RPM  (min =3D 3000 RPM, div =3D 2)                    =20
Ch Fan 4:    0 RPM  (min =3D 3000 RPM, div =3D 2)                    =20
VRM 1:       +47=B0C  (limit =3D  +60=B0C)                       sensor =3D=
 3904 transistor          =20
AGP:        +5.0=B0C  (limit =3D  +60=B0C, hysteresis =3D  +50=B0C) sensor =
=3D 3904 transistor   ALARM  =20
DDR:        +4.0=B0C  (limit =3D  +60=B0C, hysteresis =3D  +50=B0C) sensor =
=3D 3904 transistor          =20
vid2:     +1.750 V
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled

(I did disable the eeprom as it only gives me a list of how much ram is
in the system).

With this system I've seen people saying they're getting the actual
CPU temps, not just the motherboard temps. =20

Can you give a 'wrapup' of what the current set of options for
/etc/modutils/local should be and or any force_subclients?  If you can't
post a "use XXXXXXXXXXXXXXX" then a how to find the values would be
great.  I tried a number of different compinations that I dug up in
/proc/ and on the boards but nothing ever changed.  There doesn't seem
to be a difinitive "do this with modutils" or "use these
force_subclients" anywhere I can find just "you need to use
force_subclients".

Thanks for all your work,
  Robert


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | PGP Key ID: FC96D405
                              =20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.
FYI:
 perl -e 'print $i=3Dpack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10)=
;'
