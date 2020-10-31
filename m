From: Paul Wise <pabs3@bonedaddy.net>
Date: Sat, 31 Oct 2020 03:49:35 +0000
Subject: stuck thermal sensor on Thinkpad X201t
Message-Id: <1099fad0c122502f376f9c5069ba6cdb99f46980.camel@bonedaddy.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-c2x7yO7giVLwrPg+3AV2"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--=-c2x7yO7giVLwrPg+3AV2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I recently had an issue with a stuck thermal sensor on a Thinkpad X201t.
I'm sending this mail so there is a record of the solution that I used
and to get an idea of what caused the issue and why my solution worked.

The sensors command constantly showed 128=C2=B0C for one sensor:

   $ sensors acpitz-acpi-0
   acpitz-acpi-0
   Adapter: ACPI interface
   temp1:       +128.0=C2=B0C  (crit =3D +100.0=C2=B0C)

The Linux kernel was adding this message to dmesg every few seconds:

   kernel: thermal thermal_zone0: critical temperature reached (128 C), shu=
tting down

Despite the message, the system wasn't being shut down, probably
because the other sensors were normal and within the range.

These symptoms occurred after my system shut down due to overheating.

Annoyingly these symptoms were persisting between reboots.

On the Debian support IRC channel, someone else mentioned that they
solved a similar issue by rebooting into Windows but I don't have
Windows available.

I also did some searching on the web and got the feeling that I should
try removing power. So I shut down, removed the battery for 5 minutes,
inserted battery, started up, entered BIOS, exited BIOS, booted Linux
and the sensor was now showing normal values and had no dmesg warnings.

Does anyone know why a thermal shutdown would cause just one of the
sensors to be stuck like this and why removing power fixed it?

--=20
bye,
pabs

https://bonedaddy.net/pabs3/

--=-c2x7yO7giVLwrPg+3AV2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEYQsotVz8/kXqG1Y7MRa6Xp/6aaMFAl+c3swACgkQMRa6Xp/6
aaMQghAAvVGaGViC6mvugr9SLdkmu5VSCbboTuCyTTN+guc7FuXZDWT7Ty/wiTYU
yyqZmur1w8/DZ/rD+AMjF6XDRuz/KJ7bW0fdR80lKuFKDxhKIcObbOnatasLTc/x
MAAhAjtKLUrfo1w8YH7P9Tj1zDWC6B+gfzsnqCMVN9EDX+lbnNcSX3MOITh/GVyM
TRzItMw3g3m6br4GWQ40ijhTke1lowFQp4fGYDxW+PCq/G9ApTggsFdjt6k1H61Y
Pw6IKqKPf+XmEhz9+nwWPxp6PiwE0zw9Zl1knYs/DA3Q5DeBnhswz1428500rLWW
NO3P/nrGOTRfsR0ZZrqAk+il/FlpxjQJnNiWiGGR+WLrxlqfcbE0WNYbgeSjGVP5
fXPbk9YfWhpWh89S480lcMy1MmgPKWbfbJpijPQ/QO4fCZsTegUJC99loCz7LhCm
JVsV/1fs/Z9HXs3uvwI/bpryeaLoTLOm8AobRpNWSwn+TJLmWlEXEWMlWRQOgICs
M9d72oBgzwv0mmtJNnFM29KmAwMcksOYj6Fi02gEKpTDC1BwZs4CroN4FwcRvSMG
4U0g6NVPS/SiQ1HyuTGp8cZgXf4QP1rdPV3eaqBdAs8rZ9xLSYxOCG8LKCJoH6Bx
cRjOfw2Hc+nipM2oONBe0kioKtgPobJFoQeMyfd4q0D9eDjpnac=
=zSYJ
-----END PGP SIGNATURE-----

--=-c2x7yO7giVLwrPg+3AV2--
