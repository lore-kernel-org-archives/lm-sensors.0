From: Jean-Denis Girard <jd.girard@sysnux.pf>
Date: Wed, 17 Aug 2011 05:25:55 +0000
Subject: Re: [lm-sensors] Alix 2D2
Message-Id: <4E4B50E3.1070004@sysnux.pf>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E4A9BEE.5030108@sysnux.pf>
In-Reply-To: <4E4A9BEE.5030108@sysnux.pf>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

Le 16/08/2011 06:47, Guenter Roeck a écrit :
> First question is what you mean with "for some time now". days ? weeks ?
> months ? years ? since 3.0 ? 2.6.39 ? 2.4.16 ?

Unfortunately I don't know, but it is more than one year. It did work in
2.6.32.2, I'm sure it didn't work in 2.6.38, 2.6.39.

> Would be great if you can point to the most recent working kernel.

Sorry, I didn't notice when it stopped to work.

> 
> Second, please provide output of "i2cdetect 0" (i2c-dev needs to be
> loaded for this to work). That should show us if the sensor is still
> detected on the i2c bus.

[admin@ix100 ~]$ sudo i2cdetect 0
Error: Could not open file `/dev/i2c-0': No such device

> 
> If it is, please also provide output of "i2cdump 0 0x4c".
> 
> For the lm90 module, please make sure that it is really loaded. You can
> verify this with the "lsmod" command.

lsmod gives:
Module                  Size  Used by
lm90                    7852  0
i2c_dev                 3324  0
scx200_acb              3388  0
...

This is what I see in my logs
i2c /dev entries driver
i2c-core: driver [lm90] registered


Thanks,
- -- 
Jean-Denis Girard

SysNux                  Systèmes  Linux  en Polynésie française
http://www.sysnux.pf/   Tél: +689 50 10 40 / GSM: +689 79 75 27
-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAk5LUOIACgkQuu7Rv+oOo/g54gCgojlaqS9wDdgG5ZSud1vIe2hS
So0AnibVSCsLuJVQf8F7/jCBIaSpL0aL
=0qG7
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
