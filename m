From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 10 Jun 2007 20:35:35 +0000
Subject: Re: [lm-sensors] svn commit: r4435 - lm-sensors/trunk/prog/py-smbus
Message-Id: <20070610223535.6159056b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 9 Jun 2007 18:19:45 +0200 (CEST), lm-sensors-notify@lm-sensors.org wrote:
>       Author: mmh
>         Date: Sat Jun  9 18:19:37 2007
> New Revision: 4435
>    Changeset: http://lm-sensors.org/changeset/4435
> 
> Modified:
>    lm-sensors/trunk/prog/py-smbus/smbusmodule.c
> 
> Log:
> Allow i2c block transfers with of length < 32 on kernels that support it.

>  	if (i2c_smbus_access(self->fd, I2C_SMBUS_READ, (__u8)cmd,
> +				len = 32 ? I2C_SMBUS_I2C_BLOCK_BROKEN:
>  				I2C_SMBUS_I2C_BLOCK_DATA, &data)) {

This looks wrong to me, should be "len = 32"?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
