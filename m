From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 20 Nov 2013 18:38:38 +0000
Subject: Re: [lm-sensors] Ticket #2382
Message-Id: <20131120183838.GB30952@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <528A62DC.9030107@baymicrosystems.com>
In-Reply-To: <528A62DC.9030107@baymicrosystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Nov 20, 2013 at 07:25:09PM +0100, Jean Delvare wrote:
> On Wed, 20 Nov 2013 10:15:29 -0800, Guenter Roeck wrote:
> > On Wed, Nov 20, 2013 at 07:06:41PM +0100, Jean Delvare wrote:
> > > Personally I'd just do the minimum to avoid returning an error. In
> > > other words I'd be fine returning values down to 6 degrees (for the
> > > Atom D510 at least). We know the value is wrong but it can be correct=
ed
> > > in user-space, while if we clamp higher, it can no longer be correcte=
d.
> >=20
> > Seems to me it would be much simpler to just return 0 if the valid bit =
is 0,
> > and not bother returning -EAGAIN in that case. After all, that is what
> > it boils down to, isn't it ?
>=20
> In the specific case of these Atom chips, sort of, yes (although I'd
> return maybe 5000 for continuity with the last known good value, but
> that's not so important in the end, plus there's no guarantee that the
> limit is the same for other Atom CPU models / samples.)
>=20
> However we can't really do that in general, as again there is no Intel
> documentation saying that valid =3D=3D 0 can only mean "temperature too
> low". There may be other causes.
>=20
> Now I really can't remember if we ever had reports of -EAGAIN being
> returned transiently. If the error is always permanent then I'd agree
> that returning 0 (or any other arbitrarily low value) is no worse than
> returning -EAGAIN.
>=20
> Alternatively, as long as we have no clean way to return "lower than X
> but I don't know the exact value" to user-space, it might be more
> simple to just ignore the valid bit and always return the value. In
> ticket #2382 I found that values 1=B0C and 4=B0C would be returned instead
> of the error in that case, it's no worse than returning 0=B0C or an
> arbitrary 5=B0C, and it would come for absolutely no extra code.
>=20
Both are ok with me. Either case it would be a one-line change.

-       return tdata->valid ? sprintf(buf, "%d\n", tdata->temp) : -EAGAIN;
+       return sprintf(buf, "%d\n", tdata->valid ? tdata->temp : 0);

or

-       return tdata->valid ? sprintf(buf, "%d\n", tdata->temp) : -EAGAIN;
+       return sprintf(buf, "%d\n", tdata->temp);

Let me know which one you prefer and I'll submit a patch.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
