From: Vianney Lejeune <via.lej@free.fr>
Date: Thu, 26 Mar 2009 16:52:44 +0000
Subject: [lm-sensors] Can't get pwmconfig working on my Asus P5B-VM running
Message-Id: <25E4D3E5-3EF0-41EB-8F76-730332819C91@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello !

	I use an Asus P5B-VM motherboard (w83627ehf chipset) running Debian =20
Etch kernel 2.6.18. I disabled Asus Q-Fan control in the BIOS.  The =20
fan runs at full speed and are connected to a 3 or 4-pins connector. =20
I'm unable to control any of the fan using pwmconfig (the outputs are =20
below).

What should I do to control my fans ?

=3D=3D=3D>
server23:/# sensors
w83627dhg-isa-0290
Adapter: ISA adapter
Vcore:     +1.16 V  (min =3D  +1.00 V, max =3D  +1.60 V)
+12V:     +11.99 V  (min =3D +11.40 V, max =3D +12.62 V)
+3.3V:     +3.26 V  (min =3D  +3.14 V, max =3D  +3.47 V)
+5V:       +4.99 V  (min =3D  +4.76 V, max =3D  +5.25 V)
Front Case Fan:
            727 RPM  (min =3D  675 RPM, div =3D 16)
CPU Fan:   827 RPM  (min =3D  753 RPM, div =3D 16)
Rear Case Fan:
            540 RPM  (min =3D  502 RPM, div =3D 8)
MB Temp:     +46=B0C  (high =3D   +60=B0C, hyst =3D   +50=B0C)
CPU Temp:  +42.5=B0C  (high =3D +60.0=B0C, hyst =3D +55.0=B0C)
=3D=3D=3D>

and pwmconfig:

=3D=3D=3D>
server23:/# pwmconfig
This program will search your sensors for pulse width modulation (pwm)
controls, and test each one to see if it controls a fan on
your motherboard. Note that many motherboards do not have pwm
circuitry installed, even if your sensor chip supports pwm.

We will attempt to briefly stop each fan using the pwm controls.
The program will attempt to restore each fan to full speed
after testing. However, it is ** very important ** that you
physically verify that the fans have been to full speed
after the program has completed.

Found the following devices:
    hwmon0/device is w83627dhg

Found the following PWM controls:
    hwmon0/device/pwm1
    hwmon0/device/pwm2
    hwmon0/device/pwm3
    hwmon0/device/pwm4

Giving the fans some time to reach full speed...
Found the following fan sensors:
    hwmon0/device/fan1_input     current speed: 746 RPM
    hwmon0/device/fan2_input     current speed: 827 RPM
    hwmon0/device/fan3_input     current speed: 1088 RPM
    hwmon0/device/fan4_input     current speed: 0 ... skipping!
    hwmon0/device/fan5_input     current speed: 0 ... skipping!

Warning!!! This program will stop your fans, one at a time,
for approximately 5 seconds each!!!
This may cause your processor temperature to rise!!!
If you do not want to do this hit control-C now!!!
Hit return to continue:

Testing pwm control hwmon0/device/pwm1 ...
   hwmon0/device/fan1_input ... speed was 746 now 746
     no correlation
   hwmon0/device/fan2_input ... speed was 827 now 811
     no correlation
   hwmon0/device/fan3_input ... speed was 1088 now 1088
     no correlation

No correlations were detected.
There is either no fan connected to the output of hwmon0/device/pwm1,
or the connected fan has no rpm-signal connected to one of
the tested fan sensors. (Note: not all motherboards have
the pwm outputs connected to the fan connectors,
check out the hardware database on http://www.almico.com/forumindex.php)

Did you see/hear a fan stopping during the above test (n)? n

Testing pwm control hwmon0/device/pwm2 ...
   hwmon0/device/fan1_input ... speed was 746 now 727
     no correlation
   hwmon0/device/fan2_input ... speed was 827 now 827
     no correlation
   hwmon0/device/fan3_input ... speed was 1088 now 1088
     no correlation

No correlations were detected.
There is either no fan connected to the output of hwmon0/device/pwm2,
or the connected fan has no rpm-signal connected to one of
the tested fan sensors. (Note: not all motherboards have
the pwm outputs connected to the fan connectors,
check out the hardware database on http://www.almico.com/forumindex.php)

Did you see/hear a fan stopping during the above test (n)? n

Testing pwm control hwmon0/device/pwm3 ...
   hwmon0/device/fan1_input ... speed was 746 now 746
     no correlation
   hwmon0/device/fan2_input ... speed was 827 now 819
     no correlation
   hwmon0/device/fan3_input ... speed was 1088 now 1074
     no correlation

No correlations were detected.
There is either no fan connected to the output of hwmon0/device/pwm3,
or the connected fan has no rpm-signal connected to one of
the tested fan sensors. (Note: not all motherboards have
the pwm outputs connected to the fan connectors,
check out the hardware database on http://www.almico.com/forumindex.php)

Did you see/hear a fan stopping during the above test (n)? n

Testing pwm control hwmon0/device/pwm4 ...
   hwmon0/device/fan1_input ... speed was 746 now 727
     no correlation
   hwmon0/device/fan2_input ... speed was 827 now 819
     no correlation
   hwmon0/device/fan3_input ... speed was 1088 now 1074
     no correlation

No correlations were detected.
There is either no fan connected to the output of hwmon0/device/pwm4,
or the connected fan has no rpm-signal connected to one of
the tested fan sensors. (Note: not all motherboards have
the pwm outputs connected to the fan connectors,
check out the hardware database on http://www.almico.com/forumindex.php)

Did you see/hear a fan stopping during the above test (n)? n

Testing is complete.
Please verify that all fans have returned to their normal speed.

The fancontrol script can automatically respond to temperature changes
of your system by changing fanspeeds.
Do you want to set up its configuration file now (y)? n
=3D=3D=3D>

Regards,
Vianney




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
