From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 06 Oct 2012 16:53:48 +0000
Subject: Re: [lm-sensors] Intel 5500 temperature
Message-Id: <20121006185348.51ca4d59@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121006131253.59beb17a@endymion.delvare>
In-Reply-To: <20121006131253.59beb17a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, 6 Oct 2012 09:43:39 -0700, Guenter Roeck wrote:
> On Sat, Oct 06, 2012 at 01:12:53PM +0200, Jean Delvare wrote:
> > I have the same chipset on my Asus Z8NA-D6 board and decided to look
> > into this. There seems to be a thermal sensor in this chipset and
> > following Intel's documentation I wrote a driver for it. You can
> > download it at:
> >   http://khali.linux-fr.org/devel/misc/i5500_temp/
> > Generic installation instructions are available at:
> >   http://khali.linux-fr.org/devel/misc/INSTALL
> >=20
> > Unfortunately it turns out the driver doesn't work for me. It returns a
> > constant temperature of 36.5=B0C. I've tested on a few other systems at
> > work, with the same disappointing result. I have read the datasheet
> > again but can't find what I got wrong, if anything.
> >=20
> > I'm still sharing my work, in case it works on other systems, or
> > someone looking at my code can figure out what I missed.
>
> Nothing obvious afaics. Do you get reasonable values for the limits ?

Yes, I get the default limit values mentioned in the datasheet:

intel5500-pci-00a3
Adapter: PCI adapter
temp1:        +36.5=B0C  (high =3D +100.0=B0C, hyst =3D +90.0=B0C)
                       (crit =3D +110.0=B0C)

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
