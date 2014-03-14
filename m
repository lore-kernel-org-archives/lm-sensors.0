From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 14 Mar 2014 06:53:17 +0000
Subject: Re: [lm-sensors] hp dc7900
Message-Id: <20140314075317.19c7f576@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <53220AB5.8010809@sojka.co>
In-Reply-To: <53220AB5.8010809@sojka.co>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Grzegorz,

On Thu, 13 Mar 2014 20:44:53 +0100, Grzegorz S=F3jka wrote:
> I'm using HP dc7900 Small Form Factor Business PC as a small home=20
> server. Since the machine runs 24/7 I would like it to automatically=20
> shut down in case of overheating or a fan failure. I managed to obtain=20
> temperatures for both CPU cores (via coretemp). Unfortunately I'm not=20
> able to monitor fans speed. The sensors-detect script detected also:
>=20
> Trying family `SMSC'...                                     Yes
> Found unknown chip with ID 0x0b00
>=20
> Unfortunately I have no idea what is it and how to use it.
>=20
> Does anyone know how to configure lm_sensors to obtain fans speed=20
> readings on my machine??

I think we've seen this ID many times in the past, but we don't know
what chip it is and/or we don't have a datasheet. If you can have a
physical look at the board and find the chip name, that would be a
start.

Not all LPC chips include hardware monitoring features though. Does the
BIOS display any fan speed on this system?

--=20
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
