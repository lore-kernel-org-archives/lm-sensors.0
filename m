From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 27 Mar 2013 23:46:15 +0000
Subject: Re: [lm-sensors] Gigabyte E240N, it87 module, fan speed control not working, readings may bad
Message-Id: <20130327234615.GA28671@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <51522BDC.6070103@sirc.hu>
In-Reply-To: <51522BDC.6070103@sirc.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Mar 27, 2013 at 09:27:45PM +0100, Hajdu Tam=E1s M=E1rk wrote:
> Hi,
>=20
> Thanks for the info, maybe I just needed to write it down to really
> get it working:)
> I have figured it out that system fan is pwm2 (maybe it's temp shows
> -70, because there is no system thermometer) and after enable is set
> to 1 it is controllable via pwm2, so now I can write a script that
> reads hddtemp and set's it to the right value.
>=20
You should be able to use the "fancontrol" script as starting point.

Guenter

> Thanks!
> Tam=E1s
>=20
> 2013-03-27 19:29 keltez=E9ssel, Guenter Roeck =EDrta:
> >On Wed, Mar 27, 2013 at 06:14:07PM +0100, Hajdu Tam=E1s M=E1rk wrote:
> >>Hi,
> >>
> >>If it is not connected shouldn't it report N/A or something like
> >>that? Also it is strange the out of 3 temp sensors the second one
> >How would it know ? That is why the configuration file supports the "ign=
ore"
> >statement. Also, why is it strange ? There is no requirement that a boar=
d vendor
> >MUST connect sensors in a certain order.
> >
> >>shows -70 degrees:
> >># cat /sys/class/hwmon/hwmon1/device/temp1_input
> >>33000
> >># cat /sys/class/hwmon/hwmon1/device/temp2_input
> >>-70000
> >># cat /sys/class/hwmon/hwmon1/device/temp3_input
> >>46000
> >>If I get the meaning of the readings well, that 46 Celsius is the
> >>core temperature. It would be a bit surprising if that is true,
> >>cause there is no load on the machine and the CPU is taken back to
> >>750 Mhz, I would expect a lower value there too.
> >>
> >That really depends on your CPU. Yo could try to compare it with the out=
put
> >of the core temperature sensor if your CPU supports one.
> >
> >>The pwmX_enable values are 0,2,2 though I can echo anything to it, I
> >>can't make the fan stop or change it's speed.
> >>
> >Setting a value to 1 should enable manual control. 2 is automatic, 0 tur=
ns it
> >off entirely. CPU fans can not be turned off, so if one fan is the CPU f=
an
> >it would not be surprising that it can not be turned off.
> >
> >>The reason I want to this is that I have made a special case for the
> >>machine and the fan I have connected to the system fan is only
> >>responsible for HDD cooling, it should controlled by the hddtemp
> >>values. But anyway it would be better to have control over the cpu
> >>cooling as well cause I think it is overcooled now, which is simply
> >>wasting energy.
> >>
> >>Cheers,
> >>Tam=E1s
> >>
> >>
> >>2013-03-27 03:24 keltez=E9ssel, Guenter Roeck =EDrta:
> >>>On Wed, Mar 27, 2013 at 12:14:36AM +0100, Hajdu Tam=E1s M=E1rk wrote:
> >>>>Hi,
> >>>>
> >>>>I have a Gigabyte E240N mainboard (integrated amd cpu and gpu),
> >>>>which by pwmconfig reported to use it87 module. This is for first
> >>>>sight works, but one out of 3 temperature reading is always -70
> >>>>degrees (though it is the temp3, which I don't know what), other two
> >>>Most likely it is not connected to anything.
> >>>
> >>>>seems to good. Also the fan speed readings seems to be ok (I am not
> >>>>100% sure). What it really does, that hwmon1 is created and there
> >>>>are changing values so at least it is partially working.
> >>>>I have tried to use pwmconfig to configure and also tried to echo
> >>>>values I could think of, but I could not set (nor pwmconfig could)
> >>>>it's speed.
> >>>Fan control may be in automatic mode. That is the case if pwmX_enable
> >>>returns 2. If so, you are most likely better off by leaving it alone.
> >>>
> >>>Guenter
> >>>
> >>
>=20
>=20
> --=20
> =DCdv: *Tam=E1s*.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
