From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: RFC - PATCH for s3c2410 i2c missing support
Message-Id: <sldB94sL.1111758051.0268430.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050325122653.GA14551@home.fluff.org>
In-Reply-To: <20050325122653.GA14551@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Ben,

> > Hm, do you actually need mangling? Protocol mangling is something we
> > added because it was needed in some weird cases, not because we liked
> > it. It's not considered a wanted feature that i2c_adapters should
> > implement whenever possible. It should really only be implemented when
> > there is a concrete need. In my understanding, the need for mangling
> > means that some chip is not properly conforming with the I2C standard.
>
> I added it as the headers seem to suggest that
> I2C_FUNC_PROTOCOL_MANGLING is indicative of support
> for I2C_M_NOSTART. Addition of I2C_M_REV_DIR_ADDR was
> just to make this fuller.

OK. If you actually need I2C_M_NOSTART, then that was exactly the right
thing to do.

> > Hmm, why? The i2c-core deals properly with NULL algo_control. Poiting to
> > a function which returns 0 will be exactly the same than having no
> > function defined at all, but eats a few bytes of memory and wastes time
> > as well.
>
> Ok, just noticed at least one other bus driver seems to
> implement it (i2c-iop3xx). I can remove this easily.

Please do.

I would welcome additional patches fixing the drivers which define it for
no reason (i2c-algo-sibyte, saa7134-i2c, bttv-i2c, w9968cf).

> My home mailsystem is now fixed, so all messages to the list
> can be read again. Mail lost between 22nd and 24th.

Ouch, sorry to learn that. You can consult the archives in case you think
you missed something specific. If you want the originals of anything,
just ask.

Thanks,
--
Jean Delvare
