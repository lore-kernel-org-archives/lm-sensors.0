From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 17 Dec 2013 18:10:53 +0000
Subject: Re: [lm-sensors] I2C support for AMD Hudson-1
Message-Id: <20131217181053.GE7071@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7812737514354543519=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20131217063226.GD25105@phys.ethz.ch>
 <20131217180131.GB2840@roeck-us.net>
In-Reply-To: <20131217180131.GB2840-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Christian Herzog <herzog-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--===============7812737514354543519==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="orO6xySwJI16pVnm"
Content-Disposition: inline


--orO6xySwJI16pVnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> > I'm currently beta testing a pretty cool embedded board for router
> > applications etc. (http://www.pcengines.ch/apu.htm) that sports a Hudson-1 FCH
> > which is pretty similar to the Hudson-2 your module supports but sufficiently
> > different so that i2c-piix4 doesn't work.
> > I found a patched i2c-piix4 source that adds support for the Hudson-1 and it
> > works beautifully: http://www.men.de/products/13SC24-90.html#t=overview
> > Now I'm wondering if you would be willing to get this patch into lm-sensors
> > and also the kernel.
> > If there's anything I can do to help, please let me know.

Can't say anything about the patch since it requires registration to get
it :(

What you/someone can do:

* get the patch
* port it to a recent kernel and verify it still works
* read Documentation/SubmittingPatches
* send the patch

Regards,

   Wolfram


--orO6xySwJI16pVnm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSsJOtAAoJEBQN5MwUoCm28a0P/je/+MJ7b5WSrEIZmGncg7Nw
kyh63oCDeeZOa2qv16C3nvVtCHcjy2eydHYWahSkM62oZMLBUGiBumjv/5/30pj/
oQSM4H3N9BOzgnhLdYGwO2ZAGkSsTGbXBPbubpc8s2DF3f16Y0jyHzY/nn6nvzq1
GOXxZnaisdasE4vTX0nLJ4B7o9PUe71YhDGcM8Vj5T+XUl5UHy8FoxzShyRMZnpo
xEN7+Ay1KwJCwhS8f6AHq4nay+KrPCW6rxLZqZXDKu21Nvbyu0QfRC2Pr98B715o
HyXbNKRTCnYep2t2ZuHc4/lo37f5j7m2Fhux3ew2MZpGehKAk/wuExb2et3z08Oh
oHESEDBE/OerIrRo2C5r9xRvHq6aRHHU8BE610Sjtk7PvxpBVNKWO7DxfrqY0t8X
TPOyL4ByU85WKF3XClwKXs9dMqlvfAxEqtSsrVxXFa+ZgFT+H/GwUSObtZQTlmXX
VV6/FGUPa4oA7w9w12hU9YEXEluTIdTWPd+9VQLltagIfpxcaT5zVkd7e9RgVHcX
K6HF+75/30XR+HMBCDIpX3qgwWAD4dsP4IuQXUnMx8diWY8TNSVFpYCQLm+roBMy
e4GuhGVrqovPtKHVc/SmfrI47t/eSJYEXWEvnYM3/sm8TsqIkDl+HIAiYH0jeLVQ
pgjv30K41iGGoWwRFHnF
=TP7q
-----END PGP SIGNATURE-----

--orO6xySwJI16pVnm--


--===============7812737514354543519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7812737514354543519==--
