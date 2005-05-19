From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: RFC - PATCH for s3c2410 i2c missing support
Message-Id: <AsAgfm0D.1111756693.6956970.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050325122653.GA14551@home.fluff.org>
In-Reply-To: <20050325122653.GA14551@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Ben,

> This patch (as requested by J Delvare) adds the
> following bits which have been missing from the
> s3c2410-i2c.c bus driver, as well as a couple of
> other minor changes:
>
> 1) add a .functionality field to our algo, and
>    report the facilities.

Thanks, this will let me go on with core cleanups of the functionalities
handling.

> 2) Add I2C_M_REV_DIR_ADDR handling for our start
>    code, to better support our reported value
>    from the .functionality probe (the use of
>    I2C_FUNC_PROTOCOL_MANGLING)

Hm, do you actually need mangling? Protocol mangling is something we
added because it was needed in some weird cases, not because we liked
it. It's not considered a wanted feature that i2c_adapters should
implement whenever possible. It should really only be implemented when
there is a concrete need. In my understanding, the need for mangling
means that some chip is not properly conforming with the I2C standard.

> 3) change the call to dev_err() to dev_dbg() in
>    the code that checks for an ack off the
>    start condition. This avoids the `flood` of
>    output when using i2cdetect

Makes sense.

> 4) Add a .algo_control field which points to a
>    function returning zero.

Hmm, why? The i2c-core deals properly with NULL algo_control. Poiting to
a function which returns 0 will be exactly the same than having no
function defined at all, but eats a few bytes of memory and wastes time
as well.

> 5) Add an `.owner = THIS_MODULE` to the adapter

I had not noticed it was missing, you're absolutely right.

Thanks,
--
Jean Delvare
