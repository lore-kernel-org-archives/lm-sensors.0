From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 10 Jun 2012 06:30:27 +0000
Subject: Re: [lm-sensors] ASUS Sabertooth Z77 / nct6775.ko report
Message-Id: <20120610063027.GB10102@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120523123730.6f2d7e36@desktop>
In-Reply-To: <20120523123730.6f2d7e36@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, Jun 09, 2012 at 02:35:18PM -0400, Torbj=F6rn =D6sterdahl wrote:
> I have got a Asus P8Z77-M PRO and have similar experiences.
>=20
> - The standard lm-sensors package that comes with my distribution, (i:3.3=
.1/
> Ubuntu), does not include support for setting PWM fan speeds.
> - By downloading and compiling the nct6775 module from https://github.com/
> groeck/nct6775 these things work to statisfaction.
> - Temperatures as read from the chipset is low. Compared to temperatures
> measured by a thermometer in the case they are lower and does not go up as
> quickly when they system load increases. I.e. my idle system have a chips=
et
> temperature of 28 Degrees - they temperature in the case is meassured to =
32.
> The loaded system reports a chipset temperature of 32 but the thermometer=
 in
> the case reports 44!
> - Case temperature as read from the acpiz module are identical though.

I can't really comment on that. No idea how accurate the sensors are.
Some of the sensors (eg the CPU sensor if measured through PECI) are extrem=
ely
inaccurate at low temperatures.

> - hysteresis values, i.e. pwm3_auto_point1_temp_hyst, behave strange. It =
is
> depenant on the corresponding temp field and often takes negative values.

The hysteresis should show a constant difference to the matching temperatur=
e,
and is displayed as absolute temperature.

For example, assume pwm3_auto_point1_temp_hyst is set to 20000 and pwm3_aut=
o_point1_temp
is set to 60000. If you change pwm3_auto_point1_temp to 30000, pwm3_auto_po=
int1_temp_hyst
should change to -10000. Is that what you see ?

> - In Thermal Cruise mode it sometimes stops the fan completely which I co=
nsider
> unnecessary. I was not able to prevent this.

pwmX_stop_output is the lowest pwm value. It is only used if pwmX_stop_outp=
ut_enable
is set, otherwise the output drops to 0. Can you try this ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
