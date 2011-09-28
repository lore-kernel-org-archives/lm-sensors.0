From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Wed, 28 Sep 2011 13:57:05 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Document Atom E660
Message-Id: <D6D887BA8C9DFF48B5233887EF04654109ED10F2CE@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110928143042.7ddd0c0a@endymion.delvare>
In-Reply-To: <20110928143042.7ddd0c0a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

> >
> > if (c->x86_model =3D 0x1c || c->x86_model =3D 0x27) {
> >
> > This fetches me 90 and I have confirmed it with the Hardware folks here.
>=20
> OK, I'll do this. What about model 0x26? Wouldn't 90=B0C be a better
> default for them too?

The TjMax is 90 for 0x26 also. I have tested this on my old 0x26 core.
But, we have to add one more || inside the 'if' :-(
Also, we have to add these cpu models inside the switch-case inside
get_tjmax, in order for the flow to reach adjust_tjmax.

>=20
> And please tell your hardware friends to implement
> MSR_TEMPERATURE_TARGET in future Atom product lines, it makes our life
> so much easier...

I will try my best :-)

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
