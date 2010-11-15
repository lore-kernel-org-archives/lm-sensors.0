From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 15 Nov 2010 15:13:13 +0000
Subject: Re: [lm-sensors] Const buffers for SMBus/I2C block write functions
Message-Id: <20101115161313.0bada1a5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201011151514.18969.roman.fietze@telemotive.de>
In-Reply-To: <201011151514.18969.roman.fietze@telemotive.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Roman,

On Mon, 15 Nov 2010 15:14:18 +0100, Roman Fietze wrote:
> Hello List,

You're writing to the wrong list. I2C matters are discussed on the
linux-i2c list.

> 
> Wouldn't it help in some places, when the block write functions would
> take a const buffer pointer?

When you post again on linux-i2c, make sure you explain the actual
benefit of the change. "It would help in some places" isn't going to
fly, especially when you don't even seem to be sure.

> 
> Please see the diff below.
> 
> 
> Index: include/linux/i2c-dev.h
> =================================> --- include/linux/i2c-dev.h	(revision 5881)
> +++ include/linux/i2c-dev.h	(working copy)
> @@ -258,7 +258,7 @@
>  }
>  
>  static inline __s32 i2c_smbus_write_block_data(int file, __u8 command, 
> -                                               __u8 length, __u8 *values)
> +                                               __u8 length, const __u8 *values)
>  {
>  	union i2c_smbus_data data;
>  	int i;
> @@ -296,7 +296,7 @@
>  }
>  
>  static inline __s32 i2c_smbus_write_i2c_block_data(int file, __u8 command,
> -                                               __u8 length, __u8 *values)
> +                                               __u8 length, const __u8 *values)
>  {
>  	union i2c_smbus_data data;
>  	int i;
> 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
