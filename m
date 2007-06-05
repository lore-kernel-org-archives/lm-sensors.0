From: Keith Romberg <romberg@ucar.edu>
Date: Tue, 05 Jun 2007 12:50:40 +0000
Subject: Re: [lm-sensors] Intel SRSH4 Motherboard Sensors
Message-Id: <46655C20.7080606@ucar.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <465336B0.2030304@ucar.edu>
In-Reply-To: <465336B0.2030304@ucar.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I am happy to report success.  First off I would like to thank everyone=20
that helped.  I am using kernel 2.6.21 with the ipmi experimental patch=20
from http://bmcsensors-26.sourceforge.net/.  The main issue was loading=20
the right modules in the right order.  Here is what I loading in=20
/etc/rc.local:

#########################################################################
# I2C adapter drivers
modprobe i2c-piix4
modprobe eeprom
modprobe ipmp_si
modprobe ipmi_msghandler
modprobe ipmisensors

# sleep 2 # optional
/usr/bin/sensors -s # recommended
##########################################################################

Here is the output of sensors:

romberg@smaug > sensors
bmc-isa-0000
Adapter: ISA adapter
in1:       +0.39 V  (min =3D  +1.43 V, max =3D  +1.87 V)
in2:       +2.23 V  (min =3D  +2.54 V, max =3D  +3.45 V)
in3:       +2.23 V  (min =3D -13.81 V, max =3D -10.21 V)
in4:       -1.64 V  (min =3D +10.21 V, max =3D +13.80 V)
in5:       +3.53 V  (min =3D  +4.26 V, max =3D  +5.75 V)
in6:       +4.99 V  (min =3D  +2.77 V, max =3D  +3.78 V)
in7:       +3.72 V  (min =3D  +2.80 V, max =3D  +3.79 V)
in8:       +2.96 V  (min =3D  +2.14 V, max =3D  +3.15 V)
in9:       +3.74 V  (min =3D  +1.07 V, max =3D  +1.43 V)
fan1:        0 RPM  (min =3D 1920 RPM)
fan2:     3840 RPM  (min =3D 1920 RPM)
fan3:     3750 RPM  (min =3D 1830 RPM)
fan4:     3600 RPM  (min =3D 1830 RPM)
fan5:     4200 RPM  (min =3D 1830 RPM)
fan6:     4200 RPM  (min =3D 1830 RPM)
temp1:     -12.8=B0C  (high =3D    +5=B0C, hyst =3D   -13=B0C)
temp2:    +138.0=B0C  (high =3D    +8=B0C, hyst =3D    +0=B0C)
temp3:     +41.0=B0C  (high =3D    +8=B0C, hyst =3D    +0=B0C)
temp4:     +39.0=B0C  (high =3D    +8=B0C, hyst =3D    +0=B0C)
temp5:     +39.0=B0C  (high =3D    +8=B0C, hyst =3D    +0=B0C)
temp6:     +40.0=B0C  (high =3D    +4=B0C, hyst =3D    +0=B0C)
temp7:     +27.0=B0C  (high =3D    +5=B0C, hyst =3D    +0=B0C)

The voltages look fine or I do not see anything too out of the norm.=20
fan1's rpms for some reason is not reported.  The fan is spinning fine=20
and no fan faults are reported on the case status panel.  For temp1 and=20
temp2, I have no idea what they are.  The CPUs are temp3 through temp6.=20
  I am guessing temp7 is a hard drive.  The system has a Dell PERC 3DC=20
raid controller with a single 108GB raid5 array.

Overall I am happy that I can at least now monitor the CPU temps.  Now I=20
just need to find a nice graphical client since xsensors does not work=20
with BMC based systems.

Keith

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
