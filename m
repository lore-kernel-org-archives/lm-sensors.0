From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 04 Jan 2006 20:45:34 +0000
Subject: [lm-sensors] Bug in usermode i2c-dev.h
Message-Id: <20060104214534.1a9b338f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <c32efac40601040039x15f54121r44573722a52f492c@mail.gmail.com>
In-Reply-To: <c32efac40601040039x15f54121r44573722a52f492c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dave,

> There is a discrepancy between the i2c_msg structure from the kernel i2c.h:
> 
> struct i2c_msg {
>    __u16 addr; /* slave address        */
>    __u16 flags;
>    __u16 len;     /* msg length           */
>    __u8 *buf;     /* pointer to msg data        */
> };
> 
> and the lm_sensors-2.9.2 usermode i2c-dev.h version of i2c_msg:
> 
> struct i2c_msg {
>         __u16 addr;     /* slave address                        */
>         unsigned short flags;
>         short len;              /* msg length                           */
>         char *buf;              /* pointer to msg data                  */
>         int err;
>         short done;
> };
> 
> The err and done members don't actually exist in the kernel version (I
> checked 2.6.11 and 2.6.15).
> 
> This causes the 2nd and subsequent messages to not lineup when you use
> the I2C_RDWR ioctl.

This was already reported by Hideki Iwamoto in September 2005, and was
fixed in lm_sensors CVS back then.

http://lists.lm-sensors.org/pipermail/lm-sensors/2005-September/013726.html

Now, I wonder if we shouldn't also set flags, len and buf to __u16,
__u16 and __u8*, respectively, for more consistency. Thoughts anyone?

Thanks for reporting anyway.

-- 
Jean Delvare

