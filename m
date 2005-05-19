From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: [PATCH] I2C update for 2.6.10-rc1
Message-Id: <zxUdaK3b.1099995467.6672570.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10999778553443@kroah.com>
References: <10999778552595@kroah.com>
In-Reply-To: <10999778552595@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: greg@kroah.com, arjan@infradead.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com


Hi,

>ChangeSet 1.2014.1.8, 2004/11/05 13:42:18-08:00, arjan@infradead.org
>
>[PATCH] I2C: remove dead code from i2c
>
>i2c-core.c has a few never used functions, patch below removes these dead
>functions.
>(...)
>@@ -1322,11 +1266,7 @@
> EXPORT_SYMBOL(i2c_smbus_write_byte_data);
> EXPORT_SYMBOL(i2c_smbus_read_word_data);
> EXPORT_SYMBOL(i2c_smbus_write_word_data);
>-EXPORT_SYMBOL(i2c_smbus_process_call);
>-EXPORT_SYMBOL(i2c_smbus_read_block_data);
>-EXPORT_SYMBOL(i2c_smbus_write_block_data);
> EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data);
>-EXPORT_SYMBOL(i2c_smbus_write_i2c_block_data);
>
> EXPORT_SYMBOL(i2c_get_functionality);
> EXPORT_SYMBOL(i2c_check_functionality);

U-ho. At least i2c_smbus_read_block_data will have a user soon (the lm93
driver written by Mark M. Hoffman will certainly be ported to Linux 2.6
at some point). Also, removing these functions without dropping relevant
defines, updating the definition of I2C_FUNC_SMBUS_EMUL and removing the
extern declarations in linux/i2c.h is inconsistent and possibly
dangerous.

These functions are part of the SMBus specs. The fact that no client uses
them for now doesn't mean that they will never be used. In particular,
we see that newer chips such as the LM93, which have a high number of
registers, tend to use these as a way to lower the pressure of the
SMBus. It would come to no surprise if newer chips would make use of
block writes or process calls. Removing these functions at this point
doesn't sound like a clever move.

This kind of change to the i2c core should really have been discussed on
the lm_sensors mailing list before hitting the main kernel tree. This
one in particular wasn't as trivial at it seemed (left apart the
question of whether the functions should be removed at all).

Thanks,
Jean
