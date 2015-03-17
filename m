From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 17 Mar 2015 13:44:47 +0000
Subject: Re: [lm-sensors] Problem with IT8620E
Message-Id: <55082FCF.3050805@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <55080544.5020202@alexander-bruns.de>
In-Reply-To: <55080544.5020202@alexander-bruns.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 03/17/2015 03:43 AM, Alexander Bruns wrote:
> Hi,
>
> I have a Mainboard from Gigabyte which is this one:
>
> GA-Z97X-Gaming G1 WIFI-BK
>
> I am running the board with gentoo-linux and 3.18.3 Kernel
>
>
> It has ITE 8620 onboard:
>
[ ... ]
>
> I try to use it like stated in the device overview as ITE 8728
>
> --------------------------- 8< Schnipp 8< ---------------------------
> holodeck ~ # cat /etc/modprobe.d/lm_sensors.conf
> options it87 force_id=3D0x8728
> --------------------------- 8< Schnapp 8< ---------------------------
>
>
>
>
> Here is my Output of sensors:
>
> --------------------------- 8< Schnipp 8< ---------------------------
> holodeck ~ # sensors
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:        +27.8=B0C  (crit =3D +105.0=B0C)
> temp2:        +29.8=B0C  (crit =3D +105.0=B0C)
>
> it8728-isa-0a30
> Adapter: ISA adapter
> in0:          +0.05 V  (min =3D  +0.00 V, max =3D  +3.06 V)
> in1:          +2.02 V  (min =3D  +0.00 V, max =3D  +3.06 V)
> in2:          +2.03 V  (min =3D  +0.00 V, max =3D  +3.06 V)
> in3:          +2.00 V  (min =3D  +0.00 V, max =3D  +3.06 V)
> in4:          +0.01 V  (min =3D  +0.00 V, max =3D  +3.06 V)
> in5:          +1.73 V  (min =3D  +0.00 V, max =3D  +3.06 V)
> in6:          +1.51 V  (min =3D  +0.00 V, max =3D  +3.06 V)
> 3VSB:         +3.38 V  (min =3D  +0.00 V, max =3D  +6.12 V)
> Vbat:         +2.98 V
> fan1:         627 RPM  (min =3D   10 RPM)
> fan2:         607 RPM  (min =3D   10 RPM)
> fan3:           0 RPM  (min =3D    0 RPM)
> fan4:           0 RPM  (min =3D    0 RPM)
> fan5:           0 RPM  (min =3D    0 RPM)
> temp1:        +34.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sens=
or =3D thermistor
> temp2:        +51.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sens=
or =3D thermistor
> temp3:       -128.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sens=
or =3D Intel PECI
> intrusion0:  ALARM
> --------------------------- 8< Schnapp 8< ---------------------------
>
>
> Now the Problem:
>
> The Board has the possibility to connect 5 Case Fans and 2 CPU Fans
>
> I have 1 CPU-Fan and 3 Case Fans.
>
> CPU-Fan has 4 power-lanes, case-fans have all 3 power-lanes
> where 4 are possible
>
> fan1 above in sensors-output is the same as SYS_FAN2, so a case-fan
> fan2 above in sensors-output is the same as SYS_FAN3, so a case-fan.
>
> I tried to stop the fans to see which one of the two shown by sensors
> is which one in the hardware I have.
>
> So one case-fan is missing and !!! CPU-Fan is missing here.
>

You could try to connect the cpu fan to the other cpu fan connector to see
if it shows up.

> I also tried to apply this patch to the kernel:
> http://www.spinics.net/lists/lm-sensors/msg43167.html
>
> I then see in sensors the same output, but instead of
> it8728-isa-0a30
> I see
> it8620-isa-0a30
>
The only real difference is to add support for the new ID, so this is
not surprising.

Besides the fan problem, the CPU temperature display is wrong as well.

> So I would like to do tests for you te get a working
> patch for ITE 8620E

 From the above, I think we have to conclude that the 8620 isn't as close
to the 8728 as we would like, and that we do not have enough information
about the 8620 to add support for it to the kernel.

Unfortunately, the chip was made by ITE specifically for Gigabyte,
and neither ITE nor Gigabyte are likely to release the datasheet.
Unless someone steps up and provides the information we would need,
I see little chance that we will be able to make the necessary changes
to the driver.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
