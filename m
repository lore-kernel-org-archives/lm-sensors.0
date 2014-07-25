From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 25 Jul 2014 16:58:10 +0000
Subject: Re: [lm-sensors] Sensors configuration for Intel D201GLY2 motherboard
Message-Id: <20140725165810.GA7672@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAKWkBZiTFXYvuq8jH8y2+HzxtY2GdJD17_c=3k9PZBLvoFcSNA@mail.gmail.com>
In-Reply-To: <CAKWkBZiTFXYvuq8jH8y2+HzxtY2GdJD17_c=3k9PZBLvoFcSNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Jul 25, 2014 at 05:45:30PM +0200, Jean Delvare wrote:
> Hi Eric,
>=20
> Please leave the list Cc'd.
>=20
> On Fri, 25 Jul 2014 15:55:06 +0200, =C9ric Le Bras wrote:
> > 2014-07-25 9:31 GMT+02:00 Jean Delvare <jdelvare@suse.de>:
> > > On Wed, 23 Jul 2014 11:08:14 +0200, =C9ric Le Bras wrote:
> > > >     label temp1 "Sys temp"
> > > >     label temp2 "unknown"
> > > >     label temp3 "unknown"
> > >
> > > If you don't know, just don't put labels, "unknown" doesn't add much
> > > value. One of these is most certainly the CPU temperature, I'm
> > > surprised it's not obvious. What does the output of "sensors
> > > -c /dev/null" say?
> >=20
> > temp2 sensor is labeled as CPU diode, so it is somewhat related to CPU
> > temp. However there is another measure reported by "coretemp" circuit,
> > which reports the exact temperature displayed by the BIOS. So what is
> > exactly temp2?
>=20
> Coretemp is a digital reading straight from the CPU. Reacts very fast,
> good accuracy at high temperatures, but very poor accuracy at low
> temperatures. The readings from the W83627DHG chip, OTOH, are analog
> temperature measurements using diodes or thermistors. So both coretemp
> and temp2 are the CPU temperature, just measured differently.
>=20
> > Temp3 has a weird behaviour. It lowers when the CPU load increases. I
> > enclosed a graph generated with sensord. The curve for temp3 has an
> > "inversed" profile, compared to other temps.
>=20
> That does not mean it's wrong. You should draw the fan speed together
> with the temperatures. Higher CPU temperature will typically result in
> a faster spinning fan, which in turn can lower the temperature of
> other parts of the system. This is even more likely for a system
> without a CPU fan where the CPU cooling is achieved by the case fan.
>=20
Is it possible that temp3 is the temperature reported by the CPU through
PECI and the chip reports the raw PECI value for some reason ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
