From: hfvogt@gmx.net (Hans-Frieder Vogt)
Date: Wed, 07 Jun 2006 22:09:22 +0000
Subject: [lm-sensors] [PATCH 2.6] cleanup of i2c-nforce2,
Message-Id: <200606080009.22097.hfvogt@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200512270102.30671.hfvogt@gmx.net>
In-Reply-To: <200512270102.30671.hfvogt@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

attached is my latest patch against kernel 2.6.17-rc5-mm3, now only containing 
the cleanup parts of my original patch. I hope we can get these changes 
quickly into the kernel. They mainly delete non-funtioning parts, so the 
patch should not have many side effects.

Signed-off-by: Hans-Frieder Vogt <hfvogt at arcor.de>

Am Montag, 5. Juni 2006 09:00 schrieb Jean Delvare:
> Hallo Hans-Frider,
>
> > I invested a little bit of time into the nforce2/3/4 SMBus driver and
> > changed the following things:
> >
> > - general cleanup:
> > 	o removed code for the unsupported I2C block transfer mode
> > 	o removed detail warnings about unsupported modes that are covered in a
> > general warning (unsupported transaction...) anyway
> > 	o removed necessity of a definition of struct i2c_adapter
> > 	o moved definition of struct i2c_algorithm, making forward declarations
> > of nforce2_access and nforce2_func unnecessary
> > - improvements:
> > 	o support MCP51 and MCP55 southbridges
> > 	o advertise  I2C_FUNC_SMBUS_BLOCK_DATA, so that it really can be used
> >
> > the patch is relative to 2.6.15-rc7 with your patch
> > i2c-nforce2-support-nforce4-mcp04.patch of 18 december (thanks) already
> > applied. If preferred, I can of course also send a full patch relative to
> > 2.6.15-rc7 (which should be applicable to other kernel versions as well).
>
> I'm sorry for overlooking this patch when you sent it back in December
> 2005. Now we happen to have a part of these changes already merged in
> the i2c-nforce2 driver (in particular support for the MPC51 and MPC55.)
> Would you be kind enough to respin your cleanups on top the i2c-nforce2
> driver as it exists in recent -mm tree? (Or on top of Linus' latest +
> http://khali.linux-fr.org/devel/i2c/linux-2.6/i2c-nforce2-add-mcp51-mcp55-s
>upport.patch, at your option.)
>
> Thanks,

-- 
--
Hans-Frieder Vogt                 e-mail: hfvogt <at> arcor .dot. de
                                          hfvogt <at> gmx .dot. net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-nforce2-2.6.17-rc5-mm3.patch
Type: text/x-diff
Size: 3558 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060608/60645b68/attachment.bin 
