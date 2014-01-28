From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 28 Jan 2014 07:12:52 +0000
Subject: Re: [lm-sensors] FanControl can not auto"load"
Message-Id: <20140128081252.24f97fa7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1390846853.4041.38.camel@X4-955>
In-Reply-To: <1390846853.4041.38.camel@X4-955>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Frederic,

On Mon, 27 Jan 2014 19:20:53 +0100, Frederic @ GMX wrote:
> As request, here is some system information :
> But, I beleive the problem is not from theses setting=20
> So, whatever , they are ...
>=20
>       * Motherboard vendor and model :=20
>=20
> Gigabyte GA-880GM-UD2H=20
>=20
>       * Lm_sensors and kernel versions :=20
>=20
> LM v 3.3.2 (from the Debian deposite) / Kernel 3.2.0-4-amd64
>=20
>       * The output of sensors :=20
>=20
> frederic@X4-955:~$ sensors
> k10temp-pci-00c3
> Adapter: PCI adapter
> AM10 Core:    +29.9=B0C  (high =3D +70.0=B0C)
>                        (crit =3D +79.0=B0C, hyst =3D +77.0=B0C)
>=20
> it8720-isa-0228
> Adapter: ISA adapter
> Vcore:        +1.02 V  (min =3D  +0.80 V, max =3D  +1.50 V)
> Vram:         +1.60 V  (min =3D  +1.52 V, max =3D  +1.68 V)
> +3.3V:        +2.83 V  (min =3D  +3.14 V, max =3D  +3.47 V)  ALARM
> +5V:          +5.00 V  (min =3D  +4.76 V, max =3D  +5.24 V)
> +12V:        +12.17 V  (min =3D +11.40 V, max =3D +12.62 V)
> +5V_SNB:      +4.82 V  (min =3D  +0.00 V, max =3D  +6.68 V)
> Vbat:         +3.28 V =20
> CPU Fan:     1569 RPM  (min =3D  500 RPM)
> SYS Fan:     1445 RPM  (min =3D  700 RPM)
> CPU Temp:     +27.0=B0C  (low  =3D +20.0=B0C, high =3D +70.0=B0C)  sensor=
 =3D
> thermistor
> MB Temp:      +28.0=B0C  (low  =3D +20.0=B0C, high =3D +60.0=B0C)  sensor=
 =3D
> thermal diode
> NBr Temp:     +27.0=B0C  (low  =3D +20.0=B0C, high =3D +60.0=B0C)  sensor=
 =3D
> thermistor
> intrusion0:  OK
>=20
> (...)
> So, the problem is Fancontrol don't want to load on the boot sequence.
>=20
> What I done ?
>=20
> On begining all was running fine. Fancontrol adjust my fans.

Did it work reliably multiple times?

> I attemps to update lm-sensors, not from the debian deposite,but from
> the download area , here.

Why did you want to update in the first place? What problem were you
trying to solve?

Distributions have their own way to integrate lm-sensors in the system,
so even if you have to update, it's better to try and find a package
for your distribution.

Did you uninstall the Debian package at this point?

> I follow exactly word by word the process describe in the INSTALL file
> include in the tar file.
> Also, I install the flex and bison packages.
> then, as root, I run :
>=20
>      1. make install
>      2. make user_install (I don't remember where I found/read this
>         command,... maybe in the makefile itself)

"make install" is sufficient, it calls target "user_install" internally
but the user doesn't have to know that.

> No error on these commands.
> But, fancontrol don't drive fans.
> So, I expect if I remove/uninstall this release, everything will be back
> fine :( :(
>=20
> But NO !
>=20
> I deleted the=20
> /usr/local/lib
> /usr/local/bin
> /usr/local/sbin
> /usr/local/ and all other

If you had compiled other packages from source, you may have deleted
unrelated files which is definitely not a good idea.

> Nothing changed after reboot ; fan stay on MAX !
>=20
> So, I restaure previous directories and run :
>=20
>      1. make user_uninstall

Again this target is not documented. "make uninstall" is enough.

> Next reboot, same situation.
>=20
> So, I run Synaptic (which I always use for install/remove/update
> packages) and I remove fancontrol and lm-sensors.
> Then reboot and I install back the both packages from Synaptic.
> I run sensors-detect, pwmconfig. All run fine without error.
>=20
> I run fancontrol as root. Fancontrol drive my fans.
> But on reboot, fancontrol don't start.
> Before all the operation, I never change manualy something for run
> fancontrol on boot.

FWIW I can't see how anything you did may have influenced the starting
of fancontrol at boot time. lm-sensors installs to /usr/local by
default, it wouldn't have messed with your system configuration.

> What I have to check/correct ?

The way services are started at boot time is distribution specific. I
am not familiar with Debian so I can't really help there. I can only
provide generic advice:
* Check that you don't have both /etc/sensors.conf
  and /etc/sensors3.conf.
* Check that you don't have both /etc/modprobe.d/lm_sensors.conf
  and /etc/modprobe.d/lm_sensors.
* Check if the fancontrol daemon is running:
  # ps -ef | grep fancontrol
* Check the system logs for information:
  # grep fancontrol /var/log/*
* If any log file has fancontrol-related messages, open it to get all
  the details.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
