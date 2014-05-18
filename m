From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 18 May 2014 09:02:33 +0000
Subject: Re: [lm-sensors] Dell Latitude E6440 & i8k
Message-Id: <20140518110233.6e58b544@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140518101910.35059ee7@endymion.delvare>
In-Reply-To: <20140518101910.35059ee7@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, 18 May 2014 10:36:16 +0200, Pali Roh=E1r wrote:
> On Sunday 18 May 2014 10:19:10 Jean Delvare wrote:
> > If you download a BIOS update for your laptop from Dell, the
> > SMM code is certainly somewhere in the binary blob which gets
> > flashed to the EEPROM. But extracting that code from there
> > would certainly be challenge.
>=20
> Yes extracting it from bios flashing image was only idea which I=20
> got and I doubt I can do it... (specially when dell bios is=20
> compressed and image itself contains flashing program...)
>=20
> What I now found is this table of SMM commands:
> https://lkml.org/lkml/2008/12/18/44
>=20
> So it looks like SMM data are in some NBSVC.MDM binary. Do you=20
> know something more about it?

No, I don't, sorry.

--=20
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
