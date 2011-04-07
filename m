From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Apr 2011 13:00:07 +0000
Subject: Re: [lm-sensors] w83795 fan control not working
Message-Id: <20110407150007.51dd1c06@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Darren,

I am redirecting this discussion to the right mailing list.

On Wed, 06 Apr 2011 16:41:07 -0700, Darren Hart wrote:
> I haven't been able to control the fan speed using the w83795 driver.
> The BIOS "Quiet" setting appears to be braindead as it runs quietly for
> a while and then switches to near full throttle for a minute or so and
> then returns to the previous state (this is with the system basically
> idle). The temperatures (from w83795adg-i2c-0-2f) never reach anything
> approaching critical:

At least, if the BIOS has a "Quiet" setting, this suggests that the
hardware is designed for fan speed control.

Do you see any message in the kernel logs when the fan switches to high
speed?

>=20
> Quiet State:
> temp1:       +83.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>              (crit =3D +127.0=B0C, hyst =3D +127.0=B0C)  sensor =3D therm=
al diode

This is very hot.

> temp5:       +40.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>              (crit =3D +75.0=B0C, hyst =3D +70.0=B0C)  sensor =3D thermis=
tor
> temp7:       +29.5=B0C  (high =3D +95.0=B0C, hyst =3D +92.0=B0C)
>              (crit =3D +95.0=B0C, hyst =3D +92.0=B0C)  sensor =3D Intel P=
ECI
> temp8:       +25.5=B0C  (high =3D +95.0=B0C, hyst =3D +92.0=B0C)
>              (crit =3D +95.0=B0C, hyst =3D +92.0=B0C)  sensor =3D Intel P=
ECI
>=20
> Loud State:
> ...
> OK, waited 10 minutes and it didn't want to scream at me. But if memory
> serves, there is only a variance of a few degrees before the fans kick
> in.

None of the measurements above is anywhere close to its set limits, so
this behavior isn't caused by an alarm raised by the W83795ADG.

> I'm hoping to use pwmconfig/fancontrol with the w83795 driver to restore
> some sanity to the fan usage. I tried with V 0.7 on the Ubuntu 10.10
> server kernel (vmlinuz-2.6.35-22-server) as well as with the current
> version in the linux-2.6.git tree (2.6.39-rc1+). I'm running on the
> following hardware with a pair of Intel Xeon X5680 CPUs.
>=20
> SUPERMICRO MBD-X8DTL-iF-O Motherboard
> http://www.supermicro.com/products/motherboard/QPI/5500/X8DTL-iF.cfm
>=20
> On the following kernel:
> linux-2.6.39-rc1+: 99759619b27662d1290901228d77a293e6e83200
>=20
> With the experimental fan control enabled for the w83795:
> $ grep 83795 .config
> CONFIG_SENSORS_W83795=3Dm
> CONFIG_SENSORS_W83795_FANCTRL=3Dy
>=20
> The module is loaded:
> $ lsmod | grep 83795
> w83795                 43879  0=20
> pwmconfig reports the following:
>=20
> ---------------------------
> Found the following devices:
>    hwmon0/device is max1617

This would be very surprising and smells like a misdetection. Which
could, in turn, explain (some of) your problems. What the use of the
adm1021 driver suggested by sensors-detect? I presume that the output
for the supposed max1617 chip in "sensors" is plain wrong? I would
advise that you do not load the adm1021 driver.

>    hwmon1/device is w83627dhg

Super-I/O (multifunction) chip, probably not used for monitoring.
Unloading the w83627ehf driver would make running pwmconfig much easier.

>    hwmon2/device is w83795adg <--- So it found the device
>=20
> Found the following PWM controls:
>    hwmon1/device/pwm1
>    hwmon1/device/pwm2
>    hwmon1/device/pwm3
>    hwmon2/device/pwm1
> hwmon2/device/pwm1 stuck to 125 <--- This doesn't look good.
> Manual control mode not supported, skipping hwmon2/device/pwm1.

Indeed. This suggests that the driver wasn't able to switch this fan
output to manual mode. The strange thing is that it works for me, with
the same chip on a different board (lm-sensors 3.3.0, kernel 2.6.38.2.)

>    hwmon2/device/pwm2 <--- Which fans does it control?

The next steps in pwmconfig should tell. One thing worth noting is that
you have 6 fan inputs used on the W83795ADG, but the chip has only two
fan control outputs. So it is impossible that you have one control per
fan. On my board, pwm1 controls both CPU fans and pwm2 controls all 6
case fans.

>=20
> Giving the fans some time to reach full speed...
> Found the following fan sensors:
>    hwmon1/device/fan1_input     current speed: 0 ... skipping!
>    hwmon1/device/fan2_input     current speed: 0 ... skipping!
>    hwmon1/device/fan3_input     current speed: 0 ... skipping!
>    hwmon1/device/fan5_input     current speed: 0 ... skipping!
>    hwmon2/device/fan1_input     current speed: 0 ... skipping!
>    hwmon2/device/fan2_input     current speed: 1931 RPM <-- cpu fan
>=20
> Note, the CPUs are very close together and to the rear chassis fan, this
> prevents me from installing both CPU fans. I opted to keep the larger
> (quieter) chassis fan adjacent to the second CPU over the second smaller
> CPU fan.
>=20
>    hwmon2/device/fan3_input     current speed: 0 ... skipping!
>    hwmon2/device/fan4_input     current speed: 2652 RPM <-- small chassis=
 fan
>    hwmon2/device/fan5_input     current speed: 1814 RPM <-- large chassis=
 fan
>    hwmon2/device/fan6_input     current speed: 0 ... skipping!
>=20
> ---------------------------
>=20
> The fans didn't change speed during the pwmconfig run. I did allow it to
> switch all the pwm controls to manual mode.

Does the board manual say whether the case fans are supposed to be
controllable, or only the CPU fans?

>=20
> Fans 2, 4, and 5 below should be connected via the w83795 driver as far a=
s I can tell:
> $ rage-ipmi.sh sensor
> FAN 1            | na         | RPM        | na    | na        | na      =
  | na        | na        | na        | na       =20
> FAN 2            | 1936.000   | RPM        | ok    | 400.000   | 576.000 =
  | 784.000   | 33856.000 | 34225.000 | 34596.000=20
> FAN 3            | na         | RPM        | na    | na        | na      =
  | na        | na        | na        | na       =20
> FAN 4            | 2704.000   | RPM        | ok    | 400.000   | 576.000 =
  | 784.000   | 33856.000 | 34225.000 | 34596.000=20
> FAN 5            | 1764.000   | RPM        | ok    | 400.000   | 576.000 =
  | 784.000   | 33856.000 | 34225.000 | 34596.000=20
> FAN 6            | na         | RPM        | na    | na        | na      =
  | na        | na        | na        | na       =20
> CPU1 Vcore       | 0.952      | Volts      | ok    | 0.776     | 0.800   =
  | 0.824     | 1.352     | 1.376     | 1.400    =20
> CPU2 Vcore       | 0.952      | Volts      | ok    | 0.776     | 0.800   =
  | 0.824     | 1.352     | 1.376     | 1.400    =20
> CPU1 DIMM        | 1.520      | Volts      | ok    | 1.288     | 1.312   =
  | 1.336     | 1.656     | 1.680     | 1.704    =20
> CPU2 DIMM        | 1.520      | Volts      | ok    | 1.288     | 1.312   =
  | 1.336     | 1.656     | 1.680     | 1.704    =20
> +1.5 V           | na         | Volts      | na    | na        | na      =
  | na        | na        | na        | na       =20
> +5 V             | 5.056      | Volts      | ok    | 4.416     | 4.448   =
  | 4.480     | 5.536     | 5.568     | 5.600    =20
> +5VSB            | 5.056      | Volts      | ok    | 4.416     | 4.448   =
  | 4.480     | 5.536     | 5.568     | 5.600    =20
> +12 V            | 12.137     | Volts      | ok    | 10.600    | 10.653  =
  | 10.706    | 13.250    | 13.303    | 13.356   =20
> -12 V            | -11.904    | Volts      | ok    | -13.650   | -13.456 =
  | -13.262   | -10.546   | -10.352   | -10.158  =20
> VTT              | 1.112      | Volts      | ok    | 0.808     | 0.816   =
  | 0.824     | 1.320     | 1.336     | 1.352    =20
> +3.3VCC          | 3.264      | Volts      | ok    | 2.880     | 2.904   =
  | 2.928     | 3.648     | 3.672     | 3.696    =20
> +3.3VSB          | 3.264      | Volts      | ok    | 2.880     | 2.904   =
  | 2.928     | 3.648     | 3.672     | 3.696    =20
> VBAT             | 3.096      | Volts      | ok    | 2.880     | 2.904   =
  | 2.928     | 3.648     | 3.672     | 3.696    =20
> CPU1 Temp        | 0x1        | discrete   | 0x0000| na        | na      =
  | na        | na        | na        | na       =20
> CPU2 Temp        | 0x1        | discrete   | 0x0000| na        | na      =
  | na        | na        | na        | na       =20
> System Temp      | 40.000     | degrees C  | ok    | -9.000    | -7.000  =
  | -5.000    | 75.000    | 77.000    | 79.000   =20
> P1-DIMM1A        | 37.000     | degrees C  | ok    | -9.000    | -7.000  =
  | -5.000    | 65.000    | 70.000    | 75.000   =20
> P1-DIMM2A        | na         | degrees C  | na    | na        | na      =
  | na        | na        | na        | na       =20
> P1-DIMM3A        | na         | degrees C  | na    | na        | na      =
  | na        | na        | na        | na       =20
> P2-DIMM1A        | 37.000     | degrees C  | ok    | -9.000    | -7.000  =
  | -5.000    | 65.000    | 70.000    | 75.000   =20
> P2-DIMM2A        | na         | degrees C  | na    | na        | na      =
  | na        | na        | na        | na       =20
> P2-DIMM3A        | na         | degrees C  | na    | na        | na      =
  | na        | na        | na        | na       =20
> Chassis Intru    | 0x0        | discrete   | 0x0000| na        | na      =
  | na        | na        | na        | na       =20
> PS Status        | 0x1        | discrete   | 0x01ff| na        | na      =
  | na        | na        | na        | na       =20
>=20
>=20
> dmesg reports:
> $ dmesg | grep 83795
> [   12.643929] i2c i2c-0: Found w83795adg rev. B at 0x2f
> [   12.883789] w83795 0-002f: PECI agent 1 Tbase temperature: 100
> [   12.903779] w83795 0-002f: PECI agent 2 Tbase temperature: 100
> [ 2288.932629] w83795 0-002f: Failed to read from register 0x030, err -6
> [ 2613.292773] w83795 0-002f: Failed to write to register 0x040, err -6
> [ 2693.333461] w83795 0-002f: Failed to read from register 0x01e, err -11

-6 is -ENXIO, returned by the i2c-i801 driver when a slave I2C device
doesn't answer. -11 is -EAGAIN, meaning arbitration loss, which can
happen on multi-master I2C buses, and I guess IPMI is implemented
exactly that way.

> Am I doing something wrong?

Yes. You are using IPMI and a native Linux driver to access the same
monitoring chip. Both access methods don't know of each other and are
not synchronized.

> Can I provide any additional information to
> help narrow down what might be wrong?

Choose between IPMI and native drivers. If you want to use IPMI on this
board, then you have to forget about the w83795 driver. And about
software-driven fan speed control too, I'm afraid.

Did you look for a BIOS or IPMI firmware update already?

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
