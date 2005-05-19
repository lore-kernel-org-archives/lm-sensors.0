From: christophe.dr@free.fr (christophe)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <200502192027.06310.christophe.dr@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141545.03330.christophe.dr@free.fr>
In-Reply-To: <200502141545.03330.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Le samedi 19 F?vrier 2005 19:38, Jean Delvare a ?crit?:
> Hi Christophe,
>
> > 30: 4d ff ff 64 64 64 00 00 00 00 00 00 00 27 41 6a
>
> Device revision 0x6A. ADM1027 is documented as 0x60+, ADT7463 is
> documented as 0x62+, so I would indeed agree that it must be an ADT7463.
> Our driver needs to be updated.
>
> In the meantime you can use force_adt7463.

OK so i need to put something like :

options lm85 force_adt7463=xxx

in the /etc/modprobe.conf... But what is the xxx i need to put ?
"modinfo lm85" says i has to be "List of adapter,address pairs". I can't guess 
what it means... Should i put 0x2e or 060+ or anything else ??? What is this 
list of adapters ? I have read the lm_sensors faq but did not find anything 
about it... Perhaps i missed the right paragraph...

> > I think the adresses 0x50 and 0x51 are for eeprom.
>
> You're correct.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCF5MJoBxdxgioZBIRAmBxAKDF/l+A/ic+rkvId81Xr4jFIdQJqwCdGcyL
cxj2Bw4lyxH7ig8mHrlIO9E=ixHR
-----END PGP SIGNATURE-----
