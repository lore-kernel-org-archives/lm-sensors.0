From: mgreer@mvista.com (Mark A. Greer)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: [PATCH][I2C] Marvell mv64xxx i2c driver
Message-Id: <41F7FE8A.2070508@mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <41F6F1D5.90601@mvista.com> <20050126205619.4c0b41fa.khali@linux-fr.org>
In-Reply-To: <20050126205619.4c0b41fa.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>

Jean Delvare wrote:

>Hi Mark,
>

Thanks for the commenting, Jean.

><snip>
>
>  
>
>>+config I2C_MV64XXX
>>+	tristate "Marvell mv64xxx I2C Controller"
>>+	depends on I2C && MV64X60
>>    
>>
>
>&& EXPERIMENTAL?
>

Yes, I guess that's the correct thing to do.  I'll add that.

>>diff -Nru a/include/linux/i2c-id.h b/include/linux/i2c-id.h
>>--- a/include/linux/i2c-id.h	2005-01-25 18:15:24 -07:00
>>+++ b/include/linux/i2c-id.h	2005-01-25 18:15:24 -07:00
>>@@ -200,6 +200,7 @@
>> 
>> #define I2C_ALGO_SIBYTE 0x150000	/* Broadcom SiByte SOCs		*/
>> #define I2C_ALGO_SGI	0x160000        /* SGI algorithm                */
>>+#define I2C_ALGO_MV64XXX 0x170000       /* Marvell mv64xxx i2c ctlr     */
>>    
>>
>
>0x170000 is reserved within the legacy i2c project for an USB algorithm,
>and 0x180000 for virtual busses. Could you please use 0x190000 instead,
>so as to avoid future collisions?
>

Absolutely.  I was unaware of the other uses.

>  
>
>>-#define MV64340_I2C_SOFT_RESET                                      0xc01c
>>+#define	MV64XXX_I2C_CTLR_NAME					"mv64xxx i2c"
>>+#define MV64XXX_I2C_OFFSET					    0xc000
>>+#define MV64XXX_I2C_REG_BLOCK_SIZE				    0x0020
>>    
>>
>
>You have a tab instead of space before MV64XXX_I2C_CTLR_NAME, it seems.
>Also, you want to align the numerical values using only tabs, no space.
>  
>

Oops.  I'll fix that too and repost later today.

Mark
