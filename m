From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 20 Apr 2014 18:42:52 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] sensors: Add support for temp[1-*]_min_hyst and temp[1-*]_lcrit_hyst
Message-Id: <5354152C.70006@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140420145723.09af01de@endymion.delvare>
In-Reply-To: <20140420145723.09af01de@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 04/20/2014 05:57 AM, Jean Delvare wrote:
> Add support for sysfs attributes temp[1-*]_min_hyst and
> temp[1-*]_lcrit_hyst.
> ---

Test results with lm77:

lm77-i2c-9-49
Adapter: i2c-diolan-u2c at bus 003 device 013
temp1:        +22.5=B0C  (low  =3D +10.0=B0C, hyst =3D +12.0=B0C)
                        (high =3D +64.0=B0C, hyst =3D +62.0=B0C)
                        (crit =3D +80.0=B0C, hyst =3D +78.0=B0C)

Looks good ...

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
