From: Ben Dooks <ben-i2c@fluff.org>
Date: Sun, 27 Nov 2011 22:55:14 +0000
Subject: Re: [lm-sensors] [PATCH] i2c multiplexer driver for Proliant
Message-Id: <20111127225514.GO19115@trinity.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAKdnbx7xeygkOK=BR+3vUrWT3GEt=PZrxgrEMvEB5nkOfAF0bg@mail.gmail.com>
In-Reply-To: <CAKdnbx7xeygkOK=BR+3vUrWT3GEt=PZrxgrEMvEB5nkOfAF0bg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Eddi De Pieri <eddi-soWH+0lSOSbR7s880joybQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org


On Fri, Nov 25, 2011 at 11:07:21PM +0100, Eddi De Pieri wrote:
> This patch add support to multiplexed smbus for proliant microserver
> N36L and may be applicable to other configuration based on sb8xx
> southbus.
>=20
> root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -l
> i2c-0=A0=A0 smbus=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SMBus piix4 adapter (SDA0=
)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SMBus adapter
> i2c-1=A0=A0 smbus=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SMBus piix4 adapter (SDA2=
)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SMBus adapter
> i2c-2=A0=A0 smbus=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SMBus piix4 adapter (SDA3=
)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SMBus adapter
> i2c-3=A0=A0 smbus=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SMBus piix4 adapter (SDA4=
)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SMBus adapter
> root@proliant:/usr/src/lm-sensors/eddi#

patch should go inline so it can be reviewed, thanks.

--=20
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
