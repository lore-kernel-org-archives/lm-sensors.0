From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 05 Mar 2014 14:09:00 +0000
Subject: Re: [lm-sensors] sensors.conf for Gigabyte B75-D3V
Message-Id: <20140305150900.4b6159fb@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <005901cf33ae$ccc48130$664d8390$@gmx.de>
In-Reply-To: <005901cf33ae$ccc48130$664d8390$@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Dominik,

On Wed, 5 Mar 2014 09:55:43 +0100, Dominik Egert wrote:
> Hello,
>=20
> i've corrected the errors and the beeping stopped. - Thank you for helping
> me out.=20
> Also I answered your questions. - See below.
> And I somehow mixed up the temps. - Should be correct now.
>=20
> I've attached the new config file.

I've added it to the wiki as:
http://www.lm-sensors.org/wiki/Configurations/Gigabyte/B75-D3V
Thanks for your contribution.

I only dropped the coretemp section (because the driver already
provides sensible labels) and pkg section (because the driver will be
removed upstream.)

> (...)
> It always shows 25. - No matter if room-temp is at 5 or at 30.=20
> I guess this is no sensible reading.

FWIW 25=B0C is the typical neutral point of thermistor based
measurements. So it can simply mean that the input is unused.

> > > (...)
> > > ############
> > > # Voltages
> >=20
> > I am curious how you found the mappings and scaling factors?
>=20
> It seems the typical scaling factors for it87xx-chips on gigabyte-boards.
> At least that's what I found on the net.
> So I gave it a shot and tested the calculators on different inputs until I
> got sensible readings.
> Then I took my multimeter and checked if the values matched or were close=
 to
> the calculated values.

You could try starting from scratch with my guide:
http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling
And see if you come up with the same results.

--=20
Jean Delvare
http://jdelvare.nerim.net/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
