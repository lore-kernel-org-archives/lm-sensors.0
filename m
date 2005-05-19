From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: Winbond W83792D driver
Message-Id: <20050410115252.7430099e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42461044.3080406@mds.gotdns.com>
In-Reply-To: <42461044.3080406@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chunhao, hi Mark,

> I'm sorry I'm not really familiar  with how subclients were done in
> 2.6, or 2.6 drivers in general. I did a diff  between your w83792d.c
> and w83781d.c in the 2.6.11 kernel.  I saw some differences in
> xxx_detect_subclients(). These may or may not make a difference. Be
> sure you don't have any compile warnings about wrong pointer types.
> One of the other guys on the list may be able to help you better. good
> luck. mds

I've read Chunhao's code and found the problem:

/* memset(data->lm75[0], 0x00, sizeof (struct i2c_client)); */

This is commented out in your code. The memset is NOT optional, it is a
requirement. The correct memset would be:
  memset(data->lm75, 0x00, 2 * sizeof(struct i2c_client));
Add this and this will solve your problem (at least it did for me).

Additional notes:

1* You have put a comment:
       struct i2c_client *lm75;     /* for secondary I2C addresses */
       /* array of 2 pointers to subclients */

This is *not* an array of 2 pointers to subclient, this is a pointer to
an array of 2 subclients, which is quite different.

2* You include "lm75.h" but never use it. This header file contains
temperature converters for LM75-like chips. This doesn't seem to be the
case of the W83792D (according to your code at least).

3* Your code does *not* free the memory you allocated for subclients
when unloading the driver. Please add the necessary code.

4* You do *not* need to do casts like this one:
  ((struct w83792d_data *) data)
It was needed in linux 2.4 but in 2.6 things are cleaner so the casts
are not needed.

5* In the case we do *not* force the subclient addresses, the code is:

               val1 = w83792d_read_value(new_client,
                                         W83792D_REG_I2C_SUBADDR);
               data->lm75[0].addr = 0x48 + (val1 & 0x03);
               data->lm75[1].addr = 0x4c + ((val1 >> 4) & 0x03);

This is *not* correct IMHO, because it assumes that the first subclient
is in 0x48-0x4b and the second it in 0x4c-0x4f. While this is true at
power-up for the W83792D, the BIOS may have changed this. So we should
not assume anything and simply do:

               data->lm75[0].addr = 0x48 + (val1 & 0x07);
               data->lm75[1].addr = 0x48 + ((val1 >> 4) & 0x07);

This should be fixed in the 2.4 driver as well.

6* The code does *not* properly handle the case where subclients are
disabled. If subclients addresses are forced, they will be forcibly
enabled (this is OK). If they are not forced, then we might register
clients which do not exist (this is NOT OK).

[I'd have a side question, about the subclients in general...
Why do we register subclients addresses at all? We could instead
forcibly disable them. This is easier and just as efficient (disabling
the addresses doesn't disable the temperature channels themselves).]

Thanks,
-- 
Jean Delvare
