From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 14 Aug 2013 10:53:30 +0000
Subject: Re: [lm-sensors] [patch] hwmon: (adt7462) ADT7462_REG_VOLT_MAX() should return 0
Message-Id: <20130814105330.GD4713@mwanda>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130814094526.GE521@elgon.mountain>
In-Reply-To: <20130814094526.GE521@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

On Wed, Aug 14, 2013 at 12:45:26PM +0300, Dan Carpenter wrote:
> The callers never check for negative but they sometimes check for zero
> returns:
> 
> 	int reg = ADT7462_REG_VOLT_MAX(data, i);
>         data->volt_max[i] > 		(reg ? i2c_smbus_read_byte_data(client, reg) : 0);
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Static checker stuff.  I don't have this hardware.

I should have also said that not all the callers check for error.
I don't know if that is a problem.

regards,
dan carpenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
