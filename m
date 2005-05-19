From: sjhill@realitydiluted.com (Steven J. Hill)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: i2c/sensors patch for 2.4.21 uploaded to my server....
Message-Id: <3F2201D7.2050203@realitydiluted.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EFCF67D.9040503@realitydiluted.com>
In-Reply-To: <3EFCF67D.9040503@realitydiluted.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark D. Studebaker wrote:
> The rule is, "modules aren't supposed to change their own usage count"
> so you shouldn't use MOD_xxx_USE_COUNT.
> All the usage counts are changed in i2c-core now.
> That's what caused all the struct changes.
> 
Okay, so I uploaded a new patch against 2.4.21 to remove the
macros and the inc_use/dec_use from the scx200 modules. I
also downloaded 2.4.22-pre8 and noticed that these function
pointers still have not been fixed been removed from the main
i2c headers. Anyway, the patches for 2.8.0 against 2.4.21 are
up there and I will be quiet now :).

    ftp://ftp.realitydiluted.com/linux/i2c

-Steve

