From: mr-smoke@spinning-plates.eu.org (Romain Riviere)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: Ticket 1382 : Update
Message-Id: <1062320735.17620.96.camel@marla.spinning-plates.eu.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1061487346.2223.4.camel@marla.spinning-plates.eu.org>
In-Reply-To: <1061487346.2223.4.camel@marla.spinning-plates.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey Jean :)
Thanx for your quick replies, sorry mine aren't that quick :P

> I suspect that the Mandrake kernel *already* contains an i2c and/or
> lm_sensors patches that conflict with the more recent ones you were
> trying to use. The drivers/sensors/sensors.c file is gone from our
> distribution by now (as is sensors_init_all).

Ok. I was suspecting the Mandrake kernel... after a while, I've learnt
that their kernels have sometimes lost most of their "vanilla"
flavour...

2 more questions :
- has anyone found a reliable way to read the via686a's output ? it's
offset by approx. 5?C here...
- I've been meaning to use rivatv together with i2c/lm-sensors, cuz I've
got a GeForce256 based card here. For some reason though, I can't
compile rivatv itself :

In file included from rivatv.h:9,
                 from i2c-riva.c:28:
rivatv-kcompat.h: In function `kcompat_i2c_client_get':
rivatv-kcompat.h:116: warning: implicit declaration of function
`i2c_inc_use_client'
rivatv-kcompat.h: In function `kcompat_i2c_client_put':
rivatv-kcompat.h:126: warning: implicit declaration of function
`i2c_dec_use_client'

i2c-riva.c: At top level:
i2c-riva.c:242: unknown field `inc_use' specified in initializer
i2c-riva.c:242: warning: initialization makes integer from pointer
without a cast

Any known fix for that one ?

Merci d'avance et @ bient?t !
Romain
