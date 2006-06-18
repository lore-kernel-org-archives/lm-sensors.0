From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Jun 2006 18:45:03 +0000
Subject: [lm-sensors] PATCH- i2c-iop3xx platform driver avoid addressing
Message-Id: <20060618204503.68fce2aa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44931779.6050302@d-tacq.com>
In-Reply-To: <44931779.6050302@d-tacq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Peter,

> Thanks very much for reviewing this patch, you have given me some useful 
> insights.
> Please consider the revised patch which addresses the issues you raise.

My pleasure, here we go:

> > BTW, you must be using an old version of i2cdetect, as the slave address
> > appears to be forced to 0x02 in the i2c-iop3xx driver (not a smart
> > choice...) and i2cdetect does no more scan this address by default.
>
> OK, new patch leaves the slave address at default 0.

Huh, this might be worst :/ 0 is the "general call address", think of
it as a broadcast address. 2 is reserved for "CBUS compatibility"
(whatever it is.)

I would suggest 8, which is the "SMBus host" address in the SMBus spec
- unless you have to deal with multi-master busses where this address
might be already taken by another master.

Note that I have no strong opinion on this either, as long as nothing
breaks and you are happy...

> I note that i2cdetect now scans from 0x3, but I'd still prefer to 
> prevent writes to the device's own address since this wedges the unit.

Sure, I have no problem with this.

> @@ -243,12 +240,19 @@ iop3xx_i2c_wait_idle(struct i2c_algo_iop
>  
>  static int 
>  iop3xx_i2c_send_target_addr(struct i2c_algo_iop3xx_data *iop3xx_adap, 
> -				struct i2c_msg* msg)
> +			    struct i2c_msg* msg)
>  {

Please don't mix cleanups with real changes!

>  	unsigned long cr = __raw_readl(iop3xx_adap->ioaddr + CR_OFFSET);
>  	int status;
>  	int rc;
>  
> +	/* avoid writing to my slave address (hangs on 80331),
> +	 * forbidden in Intel developer manual
> +	 */
> +	if (msg->addr = MYSAR) {
> +		return -I2C_ERR_WRITEMYSAR;
> +	}
> +	

How will the address be reported by i2cdetect? As if there was no chip
there, I guess (XX)? I'm a bit worried about this, as someone might
then want to use the address for something else without realizing that
the address is already in use. Would it be possible to make it so that
the address would be reported as busy (UU)? I'm not too sure myself if
the i2c-core currently allows this, but I'd like you to investigate in
that direction as it might avoid trouble in the future. I guess the
only way right now would be to instanciante a fake client at that
address.

Thanks,
-- 
Jean Delvare

