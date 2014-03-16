From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 16 Mar 2014 21:39:06 +0000
Subject: Re: [lm-sensors] hp dc7900
Message-Id: <20140316223906.76141623@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <53220AB5.8010809@sojka.co>
In-Reply-To: <53220AB5.8010809@sojka.co>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, 16 Mar 2014 19:33:03 +0100, Grzegorz S=F3jka wrote:
> On 03/16/14 12:17, Jean Delvare wrote:
> > The Super-I/O shouldn't be that small, actually it is generally one of
> > the largest chips on the board. You'd be looking for a chip with "SMSC"
> > clearly readable on top of it, like:
> > http://i00.i.aliimg.com/photo/v0/559896002/IC_CHIP_LPC47N350_NE_SMSC_QF=
P.jpg_220x220.jpg
> I did not found anything like this. I did not disassemble the pc. Its=20
> SFF so some parts of MB are covered by other components. What I was able =

> to read is the markings on the following chip:
>=20
> WINBOND
> WPCD376HAKFG
> 917SG291580312FG
>=20
> Does it help or should I look for something else?

It is completely possible that this is the chip with ID 0x0b00. We
guess vendor IDs based on other chips we know, but vendors can trade
schematics and we've seen this in the past.

Anyway we don't have a datasheet or even the start of a clue for that
chip either, so I'm sorry but there's nothing we can do.

--=20
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
