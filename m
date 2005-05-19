From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:24 +0000
Subject: I2C documentation in Linux 2.6
Message-Id: <20031110191129.40346894.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031109143302.76713452.khali@linux-fr.org>
In-Reply-To: <20031109143302.76713452.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Can you split this into two different email messages, both as patches
> that I can apply to the kernel tree?  That makes it a world easier to
> apply them.

Will do.

> > +  static struct i2c_driver foo_driver = {
> > +    .owner          = THIS_MODULE,
> > +    .name           = "Foo version 2.3 driver",
> > +    .id             = I2C_DRIVERID_FOO, /* usually from i2c-id.h */
> 
> Why is this needed anymore?

I don't say it is. The document is about what is, not about what should
be ;) I don't know why ID's were given in the first place, so I can't
tell you wether we should keep them or not. If you wan't to get rid of
them in 2.6, go for it. If it proves to be safe, I suppose we'll
backport to CVS/2.4.

> > +    .flags          = I2C_DF_NOTIFY,
> 
> Are there any usages of this field besides the I2C_DF_NOTIFY?  In a
> quick grep, it looks like everyone sets this value, so why even have
> this field at all?

i2c-dev has I2C_DF_DUMMY instead, so I wouldn't remove it.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
