From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 10 Jun 2012 15:42:33 +0000
Subject: Re: [lm-sensors] ASUS Sabertooth Z77 / nct6775.ko report
Message-Id: <20120610154233.GC10367@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120523123730.6f2d7e36@desktop>
In-Reply-To: <20120523123730.6f2d7e36@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, Jun 10, 2012 at 04:25:02AM -0400, Torbj=F6rn =D6sterdahl wrote:
> Sam 2012-06-09 klockan 23:30 -0700 skrev Guenter Roeck:
> > On Sat, Jun 09, 2012 at 02:35:18PM -0400, Torbj=F6rn =D6sterdahl wrote:
> > > I have got a Asus P8Z77-M PRO and have similar experiences.
> > >=20
> > > - The standard lm-sensors package that comes with my distribution, (i=
:3.3.1/
> > > Ubuntu), does not include support for setting PWM fan speeds.
> > > - By downloading and compiling the nct6775 module from https://github=
.com/
> > > groeck/nct6775 these things work to statisfaction.
> > > - Temperatures as read from the chipset is low. Compared to temperatu=
res
> > > measured by a thermometer in the case they are lower and does not go =
up as
> > > quickly when they system load increases. I.e. my idle system have a c=
hipset
> > > temperature of 28 Degrees - they temperature in the case is meassured=
 to 32.
> > > The loaded system reports a chipset temperature of 32 but the thermom=
eter in
> > > the case reports 44!
> > > - Case temperature as read from the acpiz module are identical though.
> >=20
> > I can't really comment on that. No idea how accurate the sensors are.
> > Some of the sensors (eg the CPU sensor if measured through PECI) are ex=
tremely
> > inaccurate at low temperatures.
> >=20
> > > - hysteresis values, i.e. pwm3_auto_point1_temp_hyst, behave strange.=
 It is
> > > depenant on the corresponding temp field and often takes negative val=
ues.
> >=20
> > The hysteresis should show a constant difference to the matching temper=
ature,
> > and is displayed as absolute temperature.
> >=20
> > For example, assume pwm3_auto_point1_temp_hyst is set to 20000 and pwm3=
_auto_point1_temp
> > is set to 60000. If you change pwm3_auto_point1_temp to 30000, pwm3_aut=
o_point1_temp_hyst
> > should change to -10000. Is that what you see ?
>=20
> Yes. It reflects my observations.=20
>=20
> My expectation was that I should set the 'hysteresis' to determine how
> sensitive the circuit reacted to deviations from the target temperature.
> Now it appears that it does not matter if I set it or not, though.=20
>=20
That is pretty much what it should do. For example, if you set temp to 5000=
0 and temp_hyst
to 45000, the respective pwm value should increase at 50 degrees C and decr=
ease at 45 degrees C.
It will still react at those well defined temperatures, but the pwm value (=
and thus fan speed)
does not start to go up and down quickly if the temperature is around 50 de=
grees C.

If you think that does not work, please let me know. You'd have to observe =
the pwm value
around the switchover temperature for a while.

> >=20
> > > - In Thermal Cruise mode it sometimes stops the fan completely which =
I consider
> > > unnecessary. I was not able to prevent this.
> >=20
> > pwmX_stop_output is the lowest pwm value. It is only used if pwmX_stop_=
output_enable
> > is set, otherwise the output drops to 0. Can you try this ?
>=20
> Yes. That works. Perfect.=20
>=20
Excellent.

> > Thanks,
> > Guenter
>=20
> Another oddity is that sometimes(!?) I am not able to set values using
> sudo, i.e. 'sudo echo "1"
> > /sys/class/hwmon/hwmon2/device/pwm3_stop_output_enable'. It does not
> matter if I use 'sys/devices/platform' or '/sys/class/hwmon/hwmon2/' I
> often need to change to a root console first. Since I have not set any
> root password I am using 'sudo -i' which works nicely.=20
>=20
Should never work, really. As explained in the other e-mail, root permissio=
ns
don't extend to redirections.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
