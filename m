From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 01 Oct 2007 21:50:26 +0000
Subject: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!
Message-Id: <20071001235026.09c55243@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1642847378@web.de>
In-Reply-To: <1642847378@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Mon, 1 Oct 2007 14:39:44 -0700, Juerg Haefliger wrote:
> Aha, that explains it. Can you apply the attached patch and reload the
> driver? Could you also please post the output of 'lsmod'?
> 
> ...juerg
> 
> --- dme1737.c.orig      2007-10-01 14:34:13.508278000 -0700
> +++ dme1737.c   2007-10-01 14:35:14.041684000 -0700
> @@ -493,8 +493,8 @@ static u8 dme1737_read(struct i2c_client
> 
>                 if (val < 0) {
>                         dev_warn(&client->dev, "Read from register "
> -                                "0x%02x failed! Please report to the driver "
> -                                "maintainer.\n", reg);
> +                                "0x%02x failed (%d)! Please report to the "
> +                                "driver maintainer.\n", reg, val);
>                 }
>         } else { /* ISA device */
>                 outb(reg, client->addr);
> @@ -513,8 +513,8 @@ static s32 dme1737_write(struct i2c_clie
> 
>                 if (res < 0) {
>                         dev_warn(&client->dev, "Write to register "
> -                                "0x%02x failed! Please report to the driver "
> -                                "maintainer.\n", reg);
> +                                "0x%02x failed (%d)! Please report to the "
> +                                "driver maintainer.\n", reg, res);
>                 }
>         } else { /* ISA device */
>                 outb(reg, client->addr);

Unfortunately, most SMBus master drivers return "-1" on error rather
than a sensible error code, so this probably won't help you much. You
would have to fix the underlying bus driver too - this needs to be done
someday anyway.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
