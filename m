From: Harald Judt <h.judt@gmx.at>
Date: Thu, 01 Aug 2013 09:08:27 +0000
Subject: Re: [lm-sensors] w83627ehf: Wrong values reported after resuming from suspend/hibernation
Message-Id: <51FA258B.3020002@gmx.at>
List-Id: <lm-sensors.vger.kernel.org>
References: <50856051.5070803@gmx.at>
In-Reply-To: <50856051.5070803@gmx.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am 01.08.2013 00:11, schrieb Guenter Roeck:
> On Mon, Jul 29, 2013 at 05:27:35PM +0200, Harald Judt wrote: [ ...
> ]
>> 
>> -- `Experience is the best teacher.'
>> 
> 
>> From c3961cf2fa1d6975b9bcffeb746c57bda09e7489 Mon Sep 17 00:00:00
>> 2001 From: Harald Judt <h.judt@gmx.at> Date: Mon, 29 Jul 2013
>> 17:00:27 +0200 Subject: hwmon: (nct6775) Add support for
>> hibernate
>> 
> Hi Harald,
> 
> Signed-off-by: is missing. Ok if I add your Signed-off to the patch
> ?
> 
> Thanks, Guenter

Sure, no problem, I didn't think about that. Also, even though
deprecated, probably a similar patch would be needed for the original
w83627ehf.c. I could create, test and send you another such patch
today in the evening or tomorrow. Otherwise,

Signed-off-by: Harald Judt <h.judt@gmx.at>

- -- 
`Experience is the best teacher.'

PGP Key ID: 0xBA3AC516
Fingerprint: 569E 0ADA 440A 8B11 D1A2 AB47 8238 0256 BA3A C516
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJR+iWIAAoJEII4Ala6OsUWHlkH+gOmHw6Q3DYKP5yTD3wXq4yH
hkb2kdUeWLv2AU8OcN4sV6KNjaMbM8lRBIf3iW70r+I0OXgoo68Y5aDGHxoHUhqw
sH12jMVY/bhINdi8dzqa8KU/3oQ4Cp4vI/3J4wTMax0edvoPOzt7at65w0wwbmVS
IJ1NWdIHyYVJGrcbw5JLUBZGBGyHQjPru1SjlXqUOuxOeSvexDHR4c9+kcEIbA76
oHvQrDLrYG6X3wC8zXZfcpfzqvOJdNv6qVOSlhlQ5766ZCmS28rHNpTqxrRjJshV
V1p5d9SXE02uNgUQZVVFv7hTScVvytM4iv3YFL3Dv+enwR1DojpVS/AHgs568Q4=yiNS
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
