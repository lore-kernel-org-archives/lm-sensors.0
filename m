From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 24 Apr 2013 13:38:56 +0000
Subject: Re: [lm-sensors] [PATCHv1 1/3] hwmon: Add support for GMT G762/G763 PWM fan controller
Message-Id: <20130424133856.GA18851@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1366753420.git.arno@natisbad.org>
 <63961d39aee9db94767f28fd441312bec2029473.1366753420.git.arno@natisbad.org>
 <20130424053758.GC8710@lunn.ch>
 <87obd4wb4e.fsf@natisbad.org>
In-Reply-To: <87obd4wb4e.fsf@natisbad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Arnaud Ebalard <arno@natisbad.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Jean Delvare <khali@linux-fr.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, devicetree-discuss@lists.ozlabs.org, Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Simon Guinot <simon.guinot@sequanux.org>, Olivier Mouchet <olivier.mouchet@gmail.com>

On Wed, Apr 24, 2013 at 11:06:57AM +0200, Arnaud Ebalard wrote:
> Hi Andrew,
>=20
> Andrew Lunn <andrew@lunn.ch> writes:
>=20
> >> +struct g762_data {
> >> +	struct i2c_client *client;
> >> +	struct device *hwmon_dev;
> >> +
> >> +	/* update mutex */
> >> +	struct mutex update_lock;
> >> +
> >> +	/* board specific parameters. */
> >> +	u32 clk; /* default 32kHz */
> >> +
> >> +	/* g762 register cache */
> >> +	bool valid;
> >> +	unsigned long last_updated; /* in jiffies */
> >> +
> >> +	u8 set_cnt;  /* RPM cmd in close loop control */
> >> +	u8 act_cnt;  /* formula: cnt =3D (CLK * 30)/(rpm * P) */
> >> +	u8 fan_sta;  /* bit 0: set when actual fan speed is more than
> >> +		      *        25% outside requested fan speed
> >> +		      * bit 1: set when no transition occurs on fan
> >> +		      *        pin for 0.7s
> >> +		      */
> >> +	u8 set_out;  /* output voltage/PWM duty in open loop control */
> >> +	u8 fan_cmd1; /*   0: FG_PLS_ID0 FG pulses count per revolution
> >> +		      *      0: 2 counts per revolution
> >> +		      *      1: 4 counts per revolution
> >> +		      *   1: PWM_POLARITY 1: negative_duty
> >> +		      *                   0: positive_duty
> >> +		      * 2,3: [FG_CLOCK_ID0, FG_CLK_ID1]
> >> +		      *         00: Divide fan clock by 1
> >> +		      *         01: Divide fan clock by 2
> >> +		      *         10: Divide fan clock by 4
> >> +		      *         11: Divide fan clock by 8
> >> +		      *   4: FAN_MODE 1:close-loop, 0:open-loop
> >> +		      *   5: OUT_MODE 1:PWM, 0:DAC
> >> +		      *   6: DET_FAN_OOC enable "fan ooc" status
> >> +		      *   7: DET_FAN_FAIL enable "fan fail" status
> >> +		      */
> >> +	u8 fan_cmd2; /* 0,1: FAN_STARTV 0,1,2,3 -> 0,32,64,96 dac_code
> >> +		      * 2,3: FG_GEAR_MODE
> >> +		      *         00: div =3D 1
> >> +		      *         01: div =3D 2
> >> +		      *         10: div =3D 4
> >> +		      *   4: Mask ALERT# (g763 only)
> >> +		      */
> >
> > You could consider using regmap for holding this cache.
> >
> > http://elceurope2012.sched.org/event/100619b669ce5767341624253aa03659?i=
frame=3Dno&w=900&sidebar=3Dyes&bg=3Dno#.UXdspHLQ5jM
> >
> > http://elinux.org/ELCE_Europe_2012_Presentations
>=20
> Interesting. As I am not yet familiar w/ regmap I would prefer having
> the driver accepted during merge window with current data structure and
> then convert it to regmap. But I will take a look (e.g. will study
> fca1dd03 for instance). Thanks for the pointers.=20
>=20
I have not had time for a detailed review, but adding regmap support will n=
ot be
a requirement.

Note that it is too late for 3.10, so the driver will have to wait for 3.11.

> >> +/*
> >> + * Helpers to import hardware characteristics from .dts file and over=
load
> >> + * default config values.
> >> + */
> >> +
> >> +#ifdef CONFIG_OF
> >
> > Can the driver be used without device tree? Would it be simpler to
> >  just add depends OF in the Kconfig entry?
>=20
> It can be used if the default params (or those configured by u-boot I
> guess) fit your needs. I think it would be fairly easy to extend the
> driver later to expose g762_config struct to allow parameters to be set
> w/o using OF. If someone wants to do that, I think it is better to not
> depend on OF in Kconfig at the moment but I have not strong argument
> other that that one. I'll let you decide.
>=20
Agreed. As long as there are major platforms not supporting device tree,
and as long as device tree overlays are not supported, it must not be made
mandatory. Especially for I2C and SPI devices I reserve the right to be able
test the hardware on an X86 system and not require a reboot to do so.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
