From: Eddi De Pieri <eddi@depieri.net>
Date: Wed, 07 Dec 2011 14:57:29 +0000
Subject: Re: [lm-sensors] [PATCH] i2c multiplexer driver for Proliant
Message-Id: <CAKdnbx48We9=i9QrY9LG1HV-opHqTjBR1w2xu_kpyAkOahvvdA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAKdnbx7xeygkOK=BR+3vUrWT3GEt=PZrxgrEMvEB5nkOfAF0bg@mail.gmail.com>
 <20111127225514.GO19115@trinity.fluff.org> <CAKdnbx4u6+_WJjjMJ3jnDLSU8eJ0yXX0Mg-dcr=3F4FaOd2R=g@mail.gmail.com>
 <20111203162757.GA24302@ericsson.com> <CAKdnbx54R9t-mS9-EvyT-618wVp-YH0YDO++=m5t-JqR6h=GCw@mail.gmail.com>
 <20111203180819.2ddbcb3a@endymion.delvare> <CAKdnbx5V=qfa5dshRudHx+M3o8Eb6qJXCVG+ZBaBwCeKaoQYNA@mail.gmail.com>
 <20111206093906.21dccf8d@endymion.delvare>
In-Reply-To: <20111206093906.21dccf8d-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

On Tue, Dec 6, 2011 at 9:39 AM, Jean Delvare <khali@linux-fr.org> wrote:

> The SMBus multiplexing as it exists on the SB800 is very
> different from what was implemented for the Tyan S4882 and S4985 boards.

Well...
- the Tyan use PCA9556 to select the multiplexed bus...

- SB800 (and SB700) seems to select lines writing the port number
using a particolar protocol.

> In fact, now that I have a SB800 datasheet, I better understand what
> you were doing and how it should be implemented.

> I don't even think you
> need the multiplexer framework for the SB800.

Are you sure?

SB7/8xx has two i2c bus smbus(0) should be accessible to the user
smbus(1) should be reserved to the chipset

> it has 4 almost independent SMBus ports.

smbus(0) may be connected to different physical port.... but each port
may be routed by the OEM to different function... so these port aren't
really independent.

how to probe this? perhaps by reading DMI?

> 1* Turn piix4_adapter to an array, so that it can hold up to 4
> =A0 i2c_adapter structures.
> 2* Add a mutex to prevent concurrent access to the register set. It
> =A0 should be initialized in piix4_setup_sb800(), taken at the very
> =A0 beginning of piix4_access() and released at the very end of this
> =A0 function.
> 3* Add support for ports 1, 2 and 3 of the SB800.

I tried to apply your suggestion... but... I don't really have the
knowledges to do what you wrote...

I need your help :(

Regards

Eddi

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
