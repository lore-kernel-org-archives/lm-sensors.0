From: rramstad@alum.mit.edu (Bob Ramstad)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: lm_sensors SiS730
Message-Id: <200111140007.QAA12886@jerry-garcia.accessgroupinc.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200111132117.NAA12073@jerry-garcia.accessgroupinc.com>
In-Reply-To: <200111132117.NAA12073@jerry-garcia.accessgroupinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Phil, thanks for your help.

I had no problems getting the "sensors" program to work on this m/b
with your instructions and the instructions in the tarballs.

It does appear that sensors.conf may not be entirely correct, but
that's OK for my needs, as I really just want to track change in
temperature over time.

For reference, if interested, I added the following lines to the end
of my /etc/rc.local:

# sensors kernel modules
/sbin/insmod i2c-core
/sbin/insmod i2c-proc
/sbin/insmod i2c-isa
/sbin/insmod it87

The program "sensors" runs fine and gives output like the following:

it87-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.74 V  (min =3D  +1.53 V, max =3D  +1.87 V)
VCore 2:   +3.04 V  (min =3D  +2.25 V, max =3D  +2.75 V)   ALARM
+3.3V:     +3.26 V  (min =3D  +2.96 V, max =3D  +3.60 V)
+5V:       +4.99 V  (min =3D  +4.50 V, max =3D  +5.48 V)
+12V:     +12.00 V  (min =3D +11.36 V, max =3D +13.80 V)
-12V:     -12.10 V  (min =3D -10.80 V, max =3D -13.10 V)
-5V:       -5.15 V  (min =3D  -4.54 V, max =3D  -5.43 V)
Stdby:     +4.89 V  (min =3D  +4.50 V, max =3D  +5.48 V)
in8:       +0.97 V
fan1:     7848 RPM  (min =3D 3000 RPM, div =3D 2)
fan2:     5769 RPM  (min =3D 3000 RPM, div =3D 2)
Temp1/MB:    +26=B0C  (min =3D  +20=B0C, max =3D  +60=B0C)
Temp2/CPU:  -117=B0C  (min =3D  +20=B0C, max =3D  +60=B0C)

I hope this information is helpful -- perhaps this could be edited and
included on the site or in the tarball?

If a better sensors.conf materializes, I'd be interested in trying it
out.

Thanks again!

-- Bob

