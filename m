From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 05 Jun 2006 07:00:23 +0000
Subject: [lm-sensors] [PATCH 2.6] cleanup of i2c-nforce2,
Message-Id: <20060605090023.647b87ee.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200512270102.30671.hfvogt@gmx.net>
In-Reply-To: <200512270102.30671.hfvogt@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Hans-Frider,

> I invested a little bit of time into the nforce2/3/4 SMBus driver and changed 
> the following things:
> 
> - general cleanup:
> 	o removed code for the unsupported I2C block transfer mode
> 	o removed detail warnings about unsupported modes that are covered in a 
> general warning (unsupported transaction...) anyway
> 	o removed necessity of a definition of struct i2c_adapter
> 	o moved definition of struct i2c_algorithm, making forward declarations of 
> nforce2_access and nforce2_func unnecessary
> - improvements:
> 	o support MCP51 and MCP55 southbridges
> 	o advertise  I2C_FUNC_SMBUS_BLOCK_DATA, so that it really can be used
> 
> the patch is relative to 2.6.15-rc7 with your patch 
> i2c-nforce2-support-nforce4-mcp04.patch of 18 december (thanks) already 
> applied. If preferred, I can of course also send a full patch relative to 
> 2.6.15-rc7 (which should be applicable to other kernel versions as well).

I'm sorry for overlooking this patch when you sent it back in December
2005. Now we happen to have a part of these changes already merged in
the i2c-nforce2 driver (in particular support for the MPC51 and MPC55.)
Would you be kind enough to respin your cleanups on top the i2c-nforce2
driver as it exists in recent -mm tree? (Or on top of Linus' latest +
http://khali.linux-fr.org/devel/i2c/linux-2.6/i2c-nforce2-add-mcp51-mcp55-support.patch,
at your option.)

Thanks,
-- 
Jean Delvare

