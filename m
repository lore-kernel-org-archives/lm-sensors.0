From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 18 Jun 2010 13:52:42 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (k8temp) Bypass core swapping on
Message-Id: <20100618155242.6a0996bf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100527163317.5b7c627d@hyperion.delvare>
In-Reply-To: <20100527163317.5b7c627d@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Andreas,

On Fri, 18 Jun 2010 10:01:26 +0200, Andreas Herrmann wrote:
> On Thu, May 27, 2010 at 10:33:17AM -0400, Jean Delvare wrote:
> > Commit a2e066bba2aad6583e3ff648bf28339d6c9f0898 introduced core
> > swapping for CPU models 64 and later. I recently had a report about
> > a Sempron 3200+, model 95, for which this patch broke temperature
> > reading. It happens that this is a single-core processor, so the
> > effect of the swapping was to read the temperature value for a core
> > that didn't exist, leading to an incorrect value (-49 degrees C.)
> >=20
> > Disabling core swapping on singe-core processors should fix this.
> >=20
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Tested-by: Rick Moritz <rhavin@gmx.net>
> > Cc: Andreas Herrmann <andreas.herrmann3@amd.com>
> > Cc: stable@kernel.org
> > ---
> > Andreas, please comment on this. Is my fix correct for all single-core
> > processors? I have to admit I am surprised that nobody reported this
> > bug in well over a year if it affects all AM2 and AM3 socket Sempron
> > processors.
>=20
> Acked-by: Andreas Herrmann <andreas.herrmann3@amd.com>
>=20
> The BKDG says
>=20
>   Thermal Sensor Core Select (ThermSenseCoreSel)=E2=80=94Bit 2. This bit =
selects the CPU whose
>      temperature is reported in the CurTemp field. This bit only applies =
to dual core processors.
>      For single core processors CPU0 Thermal Sensor is always selected. .=
..
>=20
> k8temp_probe() correctly detected that SEL_CORE can't be used on single
> core CPU. Thus k8temp did never update the temperature values stored
> in temp[1][x] and -49 degrees was reported. For single core CPUs we
> must use the values read into temp[0][x].
>=20
> Your patch fixes this.

Thanks. My patch is in linux-next now, and I'll push it to Linus (and
then stable branches) by newt week.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
