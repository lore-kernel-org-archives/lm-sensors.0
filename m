From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 24 Feb 2009 10:20:23 +0000
Subject: Re: [lm-sensors] W83667HG on ASUS P6T6 WS Revolution
Message-Id: <20090224112023.2bd47bf3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <498B944A.3060502@ioerror.us>
In-Reply-To: <498B944A.3060502@ioerror.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 24 Feb 2009 18:09:54 +0800, JGong@nuvoton.com wrote:
> >So I propose the following approach:
> >* Make the driver trust bit 0 of register 0x52 in bank 2. If the bit is
> >  set, create in6 attributes but not temp3 attributes. If it is clear,
> >  create temp3 attributes but not in6 attributes. Issue a debug message
> >  explaining the decision. For the W83667HG only, of course; for older
> >  chips we keep always creating all attributes.
> >* If it is ever found that some motherboard doesn't properly initialize
> >  this configuration bit, try to get the manufacturer to fix the BIOS.
> >  If we fail, either add a per-motherboard override in the driver, or
> >  add a module parameter or a sysfs attribute to let the user override
> >  the default configuration.
>=20
> OK, if we trust the bit 0 and the bit is set, we create in6 not temp3,
> otherwise we create the temp3 not in6. (The bit's default value is 0.)

Yes, exactly.

> But what can we do if the temp3 is created and its value is unacceptable
> like 124.5=B0C?

Well, it remains to be seen if this will ever happen. With your current
patch, both in6 and temp3 are created, so we don't know what was the
initial state of the configuration bit.

> >It would be great to get this solved quickly so that support for the
> >W83667HG makes it into kernel 2.6.30.
>=20
> As soon as we've found a proper solution of this problem, I'll make out
> the patch and recommit it.

I suggest that you make a patch implementing what was said above. Then
Michael will test it and we'll see which of in6 or temp3 will be
created on his board. If in6 the problem is solved (as far as Michael's
system is concerned, at least.) If the incorrect temp3 is displayed
then we will have to think of a workaround. Either we check the
temperature value and discard it if it looks unreasonable, or we let
the user override the configuration manually as I initially proposed. I
think I prefer the second option. Choosing the configuration based on
the monitored values somehow voids the point of monitoring.

Please make sure you include my fan fixes into your patch:
http://lists.lm-sensors.org/pipermail/lm-sensors/2009-January/025232.html

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
