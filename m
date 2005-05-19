From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Support DB Entry 1770
Message-Id: <20040912103143.342d64ad.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <007201c49733$ef934970$0a01a8c0@enterprise>
In-Reply-To: <007201c49733$ef934970$0a01a8c0@enterprise>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> =3D> /var/log/syslog <=3D
> Sep 11 19:27:45 defiant kernel: i2c-core: driver w83781d registered.
> Sep 11 19:27:45 defiant kernel: i2c_adapter i2c-0: found normal isa
> entry for adapter 9191, addr 0290
> Sep 11 19:27:45 defiant kernel: i2c_adapter i2c-0: Detection of
> w83781d chip failed at step 2 (0x61 !=3D 0x60 at 0x295)

Still the same values (which technically correspond to register
addresses). I checked the datasheets and it happens that these
regiesters belong to a so-called "auto-increment" range. This basically
means that reading any register in this range will automatically
increase the address pointer, those value we are reading from I/O
address 0x295.

I think I am now starting to understand what's going on. Something else
is trying to access the chip at the very moment we are, most probably
the BIOS. Why it does, I don't know. I thought that Asus started to
implement such silly behaviors only recently, but it seems not. The
SMBus locks you were experiencing speak for themselves.

So, first of all, I have to tell you know that you should expect
problems if you go on with using the w83781d driver on your system. It
is likely that from times to times some readings will be completely
wrong (BIOS reads interfering with yours). You could also experiment
random reboots/halts (your reads interfering with the BIOSes).

Why the sensors-detect script doesn't seem to be affected is above me.
It didn't fail to detect the chip once, did it?

> Ok, I see the "found force" in
> "/var/log/syslog" and "/var/log/debug".  But there's "Ignoring
> 'force'" in  "/var/log/syslog" and "/var/log/messages".  It is looking
> on adapter 0 not 9191 as I specified.  And "sensors" reports "No
> sensors found!".
>=20
> <SHELL>
>=20
> <defiant> [2004-09-11@15:45:02] ~ -> modprobe w83781d force=9191,0x290
>=20
> =3D> /var/log/syslog <=3D
> Sep 11 15:45:30 defiant kernel: i2c-core: driver w83781d registered.
> Sep 11 15:45:30 defiant kernel: i2c_adapter i2c-0: found force
> parameter for adapter 9191, addr 0290
> Sep 11 15:45:30 defiant kernel:  : Ignoring 'force' parameter for
> unknown chip atadapter 0, address 0x290
>=20
> =3D> /var/log/messages <=3D
> Sep 11 15:45:30 defiant kernel:  : Ignoring 'force' parameter for
> unknown chip atadapter 0, address 0x290
>=20
> =3D> /var/log/debug <=3D
> Sep 11 15:45:30 defiant kernel: i2c-core: driver w83781d registered.
> Sep 11 15:45:30 defiant kernel: i2c_adapter i2c-0: found force
> parameter for adapter 9191, addr 0290
>=20
> </SHELL>

Oh, OK, I see it now. I completely missed that exit point. This is where
the detection fails from the beginning. It only complains (in the form
of a log message) when forced. I missed that detail so far, sorry.

> The option below is the only one that seems to get this to work, and
> it appears to work fine when forced (i.e. "sensors" reports correct
> data).

Yeah, forcing will skip detection and optionally identification as well.

> <SHELL>
>=20
> <defiant> [2004-09-11@15:50:42] ~ -> modprobe w83781d
> force_w83781d=9191,0x290
> <defiant> [2004-09-11@15:50:48] ~ ->
> =3D> /var/log/syslog <=3D
> Sep 11 15:50:48 defiant kernel: i2c-core: driver w83781d registered.
> Sep 11 15:50:48 defiant kernel: i2c_adapter i2c-0: found force
> parameter for adapter 9191, addr 0290
> Sep 11 15:50:48 defiant kernel: i2c_adapter i2c-0: client [w83781d]
> registered to adapter
> Sep 11 15:50:48 defiant kernel: registering 0-0290
>=20
> =3D> /var/log/debug <=3D
> Sep 11 15:50:48 defiant kernel: i2c-core: driver w83781d registered.
> Sep 11 15:50:48 defiant kernel: i2c_adapter i2c-0: found force
> parameter for adapter 9191, addr 0290
> Sep 11 15:50:48 defiant kernel: i2c_adapter i2c-0: client [w83781d]
> registered to adapter
> Sep 11 15:50:48 defiant kernel: registering 0-0290
>=20
> <defiant> [2004-09-11@15:50:52] ~ -> sensors
> w83781d-isa-0290
> Adapter: ISA adapter
> VCore 1:   +2.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)       ALARM
> VCore 2:   +2.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)       ALARM
> +3.3V:     +3.57 V  (min =3D  +2.82 V, max =3D  +3.79 V)       ALARM
> +5V:       +4.87 V  (min =3D  +0.97 V, max =3D  +3.44 V)       ALARM
> +12V:     +12.10 V  (min =3D +11.80 V, max =3D  +0.00 V)
> -12V:     -12.02 V  (min =3D  -0.45 V, max =3D  -2.00 V)
> -5V:       -4.89 V  (min =3D  -0.00 V, max =3D  -0.00 V)
> CPU Fan:  3708 RPM  (min =3D 21093 RPM, div =3D 2)
> M/B Temp:    +29 C  (high =3D   -64 C, hyst =3D   -95 C)
> CPU Temp:   +0.0 C  (high =3D    +0 C, hyst =3D    +0 C)
> vid:      +3.500 V
> alarms:
> beep_enable:
>           Sound alarm disabled
>=20
> <defiant> [2004-09-11@15:50:54] ~ ->
> =3D> /var/log/syslog <=3D
> Sep 11 15:50:54 defiant kernel: Starting device update
>=20
> =3D> /var/log/debug <=3D
> Sep 11 15:50:54 defiant kernel: Starting device update
>=20
> </SHELL>

Readings look rather good except CPU Temp. Limits look completely broken
though.

From other post:

> Actually, the data "appears" to be read correctly but temp2 is not
> correct.  Also an ALARM where there should be none (in3).  A result of
> forcing?

This is just a guess, but the problem with temp2 could be caused by the
BIOS concurent accesses.

The ALARM bits stay up until read, so you can usually see them once
after the cause has disappeared. This is by chip design. If it does not
disappear after one more read, then there is something wrong (possibly
the BIOS breaking things when reading in our back again.

You may want to check in the BIOS setup screen if there is some option
to disable "active hardware monitoring" or whatever they called that.
You may also want to upgrade BIOSes and see if it helps.

I will update the ticket in the sensors ticket DB, thanks.

--=20
Jean "Khali" Delvare
http://khali.linux-fr.org/
