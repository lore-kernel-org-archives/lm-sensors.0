From: Ben Gamari <bgamari.foss@gmail.com>
Date: Sun, 08 Dec 2013 20:53:04 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon/adt7411: Add devicetree bindings
Message-Id: <87ob4rysi7.fsf@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0295844438924156907=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1386532718-13586-1-git-send-email-bgamari.foss@gmail.com> <1386532718-13586-2-git-send-email-bgamari.foss@gmail.com> <52A4D74F.7010701@roeck-us.net>
In-Reply-To: <52A4D74F.7010701-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

--===============0295844438924156907==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Guenter Roeck <linux@roeck-us.net> writes:

> On 12/08/2013 11:58 AM, Ben Gamari wrote:
>> There isn't reallly any configuration necessary so the bindings are
>> consequently quite simple.
>>
>> Signed-off-by: Ben Gamari <bgamari.foss@gmail.com>
>> ---
>
> i2c devices don't require explicit bindings unless driver specific bindings are needed.
> Please see Documentation/devicetree/bindings/i2c/trivial-devices.txt for details.
> You might want to consider adding the device into the trivial-devices.txt file instead.
>
Thanks! I was not aware of this. Patch coming.

How does the devicetree code handle the vendor prefix in the compatible
field? For instance, the AD7414 has compatible="ad,ad7414" yet the
driver never mentions "ad", only "ad7414". Is the vendor prefix stripped
off while searching for compatible drivers?

On that note, it seems that adt7461 is listed twice in this file; once
as "adi,adt7461" and again as "adt7461". Is this expected?

Thanks again.

Cheers,

- Ben



--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQEcBAEBAgAGBQJSpNwwAAoJEErkyLZmeNiD2+MH/01cdZtZq2I0tQXnr2xfA31r
zkQe5WfapGYLTVKnuDp8hymNATvsmzYzRDo3SiCdYoAbBnPUO44GWhQ2NLVeHvNq
ixkW5WH9AG2NVFuElcH7V+ia3G1rIjLTBcLlVsGLLubs5rN5CmkB4wkUE1vpwnd0
fvGnY4Icff9GBAeL6DJO/3OGMLaOsBPm9V+MO9BtnUG5ET1QU4PBv5xDpWwkGw75
x06YmHtITITLfyo+s+yil32ayaYAqxKZFekOWbiM8zPSpc6YbAm5ZmXZPauvp4Ui
VTxTWoPZpQOZ1FbPuypQY1rfajyct/v+qnpR3FULvC5DOzOTWQavWI4L9j0eo7c=
=XSF2
-----END PGP SIGNATURE-----
--=-=-=--


--===============0295844438924156907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0295844438924156907==--
