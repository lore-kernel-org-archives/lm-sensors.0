From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 02 Oct 2008 15:54:42 +0000
Subject: Re: [lm-sensors] High temperatures on Intel DG31PR
Message-Id: <20081002175442.4ec0ae34@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200809101453.36339.raju@linux-delhi.org>
In-Reply-To: <200809101453.36339.raju@linux-delhi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 2 Oct 2008 20:21:26 +0530, Raj Mathur wrote:
> On Thursday 02 Oct 2008, Jean Delvare wrote:
> > On Thu, 2 Oct 2008 18:12:35 +0530, Raj Mathur wrote:
> > > sensors-detect seems to find the sensors fine (transcript at
> > > bottom). However now I find that some of the temperatures seem to
> > > be unreasonably high.  Please see Sys Temp (76.0C) and Aux Temp
> > > (127.0C) in the sensors output under.
> >
> > 127 degrees C typically means that no thermal sensor is connected to
> > that input. So you can ignore this input.
>=20
> Thanks, that's what I suspected, glad to have it confirmed.
>=20
> > 76 degrees C is admittedly very high, but then again it depends what
> > it is measuring. Don't trust the default labels which may or may not
> > apply to your motherboard. You should compare with what the BIOS
> > says. Also look at the motherboard documentation, in my experience
> > Intel board have a good description of where the thermal sensors are
> > located.
>=20
> The BIOS reports it as "Motherboard Temperature".  It keeps slowly=20
> varying in the 72-76 degrees C range.

OK, so same as what lm-sensors report. So it has to be correct.

> I'm afraid hardware isn't really my domain, so even though I do have the =

> document it doesn't make much sense to me.  What I do gather from from=20
> the technical specs=20
> (http://download.intel.com/support/motherboards/desktop/dg31pr/sb/e140510=
01us.pdf)=20
> is that there are thermal sensors in the CPU(s), the I/O Controller Hub=20
> (ICH7) and the Graphics and Memory Controller Hub (GMCH).  If I=20
> correlate that information with the sensors-detect output and eliminate=20
> the core temperatures, it seems that the 76 degrees C is in the ICH7=20
> (though I could be totally wrong).

Not sure how you "correlate", but I'd rather say 76 degrees C is the
GMCH and 35 degrees C is the ICH. Rationale: the GMCH has a heatsink
while the ICH doesn't.

> In any case, from experience, is a temperature of 76C in the ICH or the=20
> GMCH a cause of concern?  If this is in the normal range for=20
> motherboard temperatures I'll stop worrying about my system running hot=20
> right now :)  If it looks high, I'll ask my hardware supplier to check=20
> the board out for faults.  All advice appreciated.

From the motherboard documentation: "The minimum thermal reporting
threshold for the GMCH is 66 =B0C. The GMCH thermal sensor will report 66
=B0C until the temperature rises above this point." If you want my
opinion, if the sensor they use doesn't bother reporting values below
66 degrees C, this suggests that the normal operating temperature is
more than that. So 76 degrees C would be considered OK.

Maybe you can google for other thermal reports for this motherboard or
similar ones (with the same GMCH). If other users have the same kind of
temperature reported, that must be OK.

(My personal thoughts are that running pieces of hardware at the high
temperatures we see these days is insane but that's a different story.)

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
