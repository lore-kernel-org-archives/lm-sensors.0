From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 09 Feb 2011 10:19:08 +0000
Subject: Re: [lm-sensors] coretemp output changed after loading acpi_cpufreq
Message-Id: <20110209111908.692aa160@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D526303.6060506@umail.ru>
In-Reply-To: <4D526303.6060506@umail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 09 Feb 2011 12:48:51 +0300, Owl wrote:
> gentoo ~ # uname -a
> Linux gentoo 2.6.36-gentoo-r7 #1 SMP Fri Jan 14 14:34:23 MSK 2011 i686=20
> Intel(R) Atom(TM) CPU N550 @ 1.50GHz GenuineIntel GNU/Linux
>=20
> gentoo ~ # sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +18.0=B0C  (crit =3D +100.0=B0C)
>=20
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +22.0=B0C  (crit =3D +100.0=B0C)
>=20
> gentoo ~ # modprobe acpi_cpufreq
> gentoo ~ # sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +37.0=B0C  (crit =3D +100.0=B0C)
>=20
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +41.0=B0C  (crit =3D +100.0=B0C)
>=20
> It's normal?

Definitely not.

> I think, second output is much closer to BIOS values.

This reminds me of
https://bugzilla.kernel.org/show_bug.cgi?id=17291

That case was a little different (problem was reportedly introduced by
cpuidle drivers, rather than solved by cpufreq) but both share the fact
that apparently digital thermal sensors in Intel CPUs are very
sensitive to the CPU state. The root cause may be the same.

Len, any idea how to investigate and hopefully fix this?

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
