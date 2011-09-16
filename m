From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 16 Sep 2011 17:00:26 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <20110916190026.708526ee@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 12 Sep 2011 18:18:00 +0200, Jean Delvare wrote:
> On my Core Duo T2600, the output looks like:
>=20
> coretemp-isa-0000
> Core 0:      +54.0=B0C  (high =3D +47.0=B0C, hyst =3D +64.0=B0C)  ALARM
>                       (crit =3D +100.0=B0C)
> Core 1:      +55.0=B0C  (high =3D +47.0=B0C, hyst =3D +64.0=B0C)  ALARM
>                       (crit =3D +100.0=B0C)
>=20
> High at 47=B0C by default seems unreasonable, and hyst > high even more
> so. But at least the ALARM flags are consistent with these limits.

BTW, the high and hyst values on this CPU appear to be random. Today
they are 89=B0C and 96=B0C. Very odd.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
