From: Rudolf Marek <r.marek@assembler.cz>
Date: Mon, 10 Mar 2008 22:00:46 +0000
Subject: Re: [lm-sensors] Kernel driver w83793
Message-Id: <47D5AF8E.5040300@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Jochen,

Thank you for your very detailed and accurate report. If I understand corre=
ctly,
even when there are some temperature channels disabled, but the temp-to-fan
mapping exist, they will still influence the output temperature correct?

And because the driver assumes the mapping is correct and disabled channels=
 are
disabled, you couldn't change that without a driver modification.

It would be nice if you could run following commands and save output for me.
Please do that when the driver is unloaded (if in kernel, just make sure th=
at
there is no access to /sys interface)

You will also need a i2c-dev (module)

i2cdump -l

should list the bus mappings. Please pick internal chipset (i2c-i801 bus)
i2c/smbus  bus, I will use 0 as bus number bellow. You will also need a dev=
ice
address. you can obtain it via the sensors-detect command or via

i2cdetect 0

Carefull! this i2cdetect/sensors-detect is sometimes dangerous to run on
production system! (you may also get the address form the
sys/class/hwmon/hwmon1/device symlink.

I assume it is 0x2d

Please do following and save the dump to file (use > redirect)

i2cdump -y 0 0x2d b 0x0 0x0
i2cdump -y 0 0x2d b 0x1 0x0
i2cdump -y 0 0x2d b 0x2 0x0

(if the driver is loaded and you cant unload it -f will do the trick)

I think we can add some detection of this situation and maybe force the
mapping of disabled channels to none. I will analyze your chip configuratio=
n in
detail once I will get it.

I'm CCing to the list, you don't need to be subscribed.

Thanks
Rudolf


> since you are the maintainer of this driver, and I'm actually not
> subscribed to any linux development lists, I'm writing this directly to
> you:
>=20
> I recently got a new server (Siemens Primergy Econel 200 S2) which uses
> above chip for temperature and fan control. Kernel is 2.6.24.3 on a Gentoo
> system.
>=20
> The server has 4 internal fans which are:
> - power supply (-, fan9)
> - left chassis (pwm7, fan7)
> - rear chassis (pwm4, fan1)
> - CPU fan in front of the processors (pwm4, fan2)
>=20
> In parentheses the control/feedback pairs are given.
>=20
> The rear fan and the processor fan are controlled by pwm4, and were
> running at about 1800 rpm constantly, the left chassis fan and power
> supply fan were running at about 1600 rpm. In total this is quite noisy
> :-)
>=20
> After a bit of reading and disabling the bits in temp?_auto_channels_pwm
> I could control the left chassis fan, bringing it down to a more silent
> form running at about 1000-1200 rpm.
>=20
> Controlling the CPU-fans was still not possible, they always stayed at a
> level of 1800 rpm.
>=20
> The strange thing I noticed: There are device nodes for pwm[123457], but
> only temp[1256]_auto_channels_pwm.
>=20
> So I modified the driver and kicked out the detection to get all 6
> available channels.
>=20
> With the modified driver I could see that channels 3+4 were still set to
> control the CPU-fans (auto_channels_pwm was set to 8), with a pwm-level in
> auto_point1_pwm) of 148. Disabling the assignment of these channels to
> pwm4 gave control to reduce the power level to a much more silent one,
> and now I also have a chance to correctly set a pleasant noise profile.
>=20
> So it seems as if the detection of available input channels is wrong or
> should be skipped since even channels without input sensors can (and will)
> control fan speeds.
>=20
> The only change inside the driver was commenting the code for setting
> data->has_temp, and forcing it to a value of 0x3f.
>=20
> Feel free to contact me if you need more specific information.
>=20
>=20
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFH1a+O3J9wPJqZRNURAhH5AKCAqg31ihQHs3M0d7iNy9v70uGu1QCfU2V6
zu4Q8Qng86QXVlPKyduofEU=DF4X
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
