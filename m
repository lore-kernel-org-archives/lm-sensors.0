From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Ported driver for PC87360 for 2.6 Kernel
Message-Id: <20040911203309.20ea9d34.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <5F0794098965D51199B700508B69580905449CB2@exchange1.chalfont.kingstoninmedia.com>
In-Reply-To: <5F0794098965D51199B700508B69580905449CB2@exchange1.chalfont.kingstoninmedia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> I have ported the PC87360 driver to the 2.6 kernel.  It is required
> for, and only tested on, a Tyan GS10, running SuSE 9.1.  I have also
> made some modifications.  It will be used with Nagios.  It would be
> advisable if someone can check the code over, I haven't ported a
> driver to 2.6 before, and I'm not familiar with these drivers.  I can
> easily arrange testing.

Nice. I am the original author of the driver but have no hardware to
test it. It's always better when the developers can test their code
themselves.

Did you have a chance to test the 2.4 driver?

> Modifications include:-
>=20
> A parameter to select the secondary device.  This was done prior to
> porting.

I don't get you. What do you mean?

> Voltages changed to give mV.

Yes, this is a requirement to comply with i2c/sysfs-interface.

> The ability to set the voltage
> multiplier, which is divided by 1000 to allow for non-integer values,
> and is in line with the use of mV.

I am not sure I get you. What is this multiplier you are talking about?

> The setting of an off-set to allow for negative voltages.

This does not belong to the driver. The chip does not monitor negative
voltages. All required conversions belong to libsensors.

> The FSCM registers can be set as a parameter, to overcome
> inappropriate BIOS settings.

This would better be done from userspace using isaset IMHO. Or, even
better, fixed in the faulty BIOS. Fixing problems where they are not is
asking for even more problems later.

> The fan divisors can be set.

Why do you need this? The driver already dynamically choose the best
clock divider for you.

> In the Kconfig file, /usr/src/linux/drivers/i2c/chips/Kconfig, the
> following lines should be added:-
>=20
> config SENSORS_PC87360
> 	tristate "PC87360"
> 	depends on I2C && EXPERIMENTAL
> 	select I2C_SENSOR
> 	help
> 	  If you say yes here you get support for the Nat Semi PC8736X
> series
> 	  of sensor chips: the PC87360, PC87363, PC87364, PC87365,
> 	  PC87366
>=20
> 	  This driver can also be built as a module.  If so, the module
> 	  will be called pc87360.
>=20
>=20
> In the Makefile, /usr/src/linux/drivers/i2c/chips/Makefile, the
> following line should be added after the
> obj-$(CONFIG_SENSORS_W83L785TS)	+=3D w83l785ts.o line:-
> 	obj-$(CONFIG_SENSORS_PC87360)	+=3D pc87360.o

Well, better provide a patch including these changes (together with the
new driver itself). This is the easiest way for testers to test your
contribution.

> In the file /etc/sysconfig/lm_sensors
>=20
> MODULE_0=3Di2c-i801
> MODULE_1=3Di2c-isa
> MODULE_2=EEprom
> MODULE_3=3D"pc87360 secondary=3D1 fanspeedcandm=3D0x036c"

This is motherboard/distro dependant and does not belong to the kernel.

What does "fanspeedcandm" stand for?

> When testing I found that the status bits changed correctly, however
> these do not seem to be reflected in the alarm indication.  I suspect
> that it may be that some settings in some other registers require
> setting.  I started to do this, however this could lead to unexpected
> results if some of the output pins are connected and as a consequence
> of changing the values in a register there could be unintended system
> resets.  A similar effect can be achieved in the bash script if
> required.  I had a quick look at the Watch dog Timer, however the
> address registers have not been set by the BIOS.

Which status bits are you talking about? The driver uses register TEVSTS
for temperatures, VEVSTS0/1 for voltages/temperatures(thermistor-based)
and FMCSR0/1/2 for fans. These bits should match the limits comparisons
and the alarm indications should be a direct representation of these
bits. If this isn't the case then this is a bug in the driver. Please
give details if you think this is the case.

I don't get the idea of your bash script. It seems to duplicate what
libsensors/sensors do.

I will get a look at your ported code after you answer my questions and
as time permits.

Thanks.

--=20
Jean "Khali" Delvare
http://khali.linux-fr.org/
