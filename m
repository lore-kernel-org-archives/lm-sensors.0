From: ponto <hugoandregomes@gmail.com>
Date: Sat, 29 Aug 2009 16:46:35 +0000
Subject: [lm-sensors] lm_sensors problem
Message-Id: <ff68bccf0908290946s44775ac4t6b1b1dfd52c1ca23@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

i've used sensors-detect and it gave me:

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `coretemp':
 * Chip `Intel Core family thermal sensor' (confidence: 9)

Do you want to overwrite /etc/conf.d/lm_sensors? (YES/no):
Copy prog/init/lm_sensors.init to /etc/rc.d/lm_sensors
for initialization at boot time.
You should now start the lm_sensors service to load the required
kernel modules.

and sensors started to give me:

sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +56.0=B0C  (high =3D +100.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +60.0=B0C  (high =3D +100.0=B0C, crit =3D +100.0=B0C)

acpitz-virtual-0
Adapter: Virtual device
temp1:       +60.0=B0C  (crit =3D +94.0=B0C)

was not suppose to give the fan's rpm's and so and so?


oh, pwmconfig does outputs me this:
pwmconfig
# pwmconfig revision 5630 (2009-01-29)
This program will search your sensors for pulse width modulation (pwm)
controls, and test each one to see if it controls a fan on
your motherboard. Note that many motherboards do not have pwm
circuitry installed, even if your sensor chip supports pwm.

We will attempt to briefly stop each fan using the pwm controls.
The program will attempt to restore each fan to full speed
after testing. However, it is ** very important ** that you
physically verify that the fans have been to full speed
after the program has completed.

/usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed

as this have to do with the supose missing values on lm sensors?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
