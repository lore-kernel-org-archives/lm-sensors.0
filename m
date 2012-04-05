From: Robert Coulson <robert.coulson@ericsson.com>
Date: Thu, 05 Apr 2012 21:32:56 +0000
Subject: Re: [lm-sensors] [Fwd: [PATCH 2/4] hwmon: (smsc47m1) Fix compiler warning]
Message-Id: <C379E95F3359F140B21F5259C55CC831506A36D5C6@EUSAACMS0714.eamcs.ericsson.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

 

> -----Original Message-----
> From: Guenter Roeck 
> Sent: Thursday, April 05, 2012 10:52 AM
> To: Robert Coulson
> Subject: [Fwd: [lm-sensors] [PATCH 2/4] hwmon: (smsc47m1) Fix 
> compiler warning]
> 
> -------- Forwarded Message --------
> From: Guenter Roeck <linux@roeck-us.net>
> To: lm-sensors <lm-sensors@lm-sensors.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Subject: [lm-sensors] [PATCH 2/4] hwmon: (smsc47m1) Fix 
> compiler warning
> Date: Wed, 28 Mar 2012 12:38:26 -0400
> 
> Some configurations produce the following compiler warning:
> 
> drivers/hwmon/smsc47m1.c: In function 'sm_smsc47m1_init':
> drivers/hwmon/smsc47m1.c:938: warning: 'address' may be used 
> uninitialized in this function
> 
> While this is a false positive, it can easily be fixed by 
> overloading the return
> value from smsc47m1_find with both address and error return 
> code (the address
> is an unsigned short and thus never negative). This also 
> reduces module size by
> a few bytes (46 bytes for x86_64).
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/smsc47m1.c |   15 ++++++++-------
>  1 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
> index c590c14..87b9ab0 100644
> --- a/drivers/hwmon/smsc47m1.c
> +++ b/drivers/hwmon/smsc47m1.c
> @@ -491,10 +491,10 @@ static const struct attribute_group 
> smsc47m1_group = {
>  	.attrs = smsc47m1_attributes,
>  };
>  
> -static int __init smsc47m1_find(unsigned short *addr,
> -				struct smsc47m1_sio_data *sio_data)
> +static int __init smsc47m1_find(struct smsc47m1_sio_data *sio_data)
>  {
>  	u8 val;
> +	unsigned short addr;
>  
>  	superio_enter();
>  	val = force_id ? force_id : superio_inb(SUPERIO_REG_DEVID);
> @@ -546,9 +546,9 @@ static int __init smsc47m1_find(unsigned 
> short *addr,
>  	}
>  
>  	superio_select();
> -	*addr = (superio_inb(SUPERIO_REG_BASE) << 8)
> +	addr = (superio_inb(SUPERIO_REG_BASE) << 8)
>  	      |  superio_inb(SUPERIO_REG_BASE + 1);
> -	if (*addr = 0) {
> +	if (addr = 0) {
>  		pr_info("Device address not set, will not use\n");
>  		superio_exit();
>  		return -ENODEV;
> @@ -565,7 +565,7 @@ static int __init smsc47m1_find(unsigned 
> short *addr,
>  	}
>  
>  	superio_exit();
> -	return 0;
> +	return addr;
>  }
>  
>  /* Restore device to its initial state */
> @@ -938,8 +938,9 @@ static int __init sm_smsc47m1_init(void)
>  	unsigned short address;
>  	struct smsc47m1_sio_data sio_data;
>  
> -	if (smsc47m1_find(&address, &sio_data))
> -		return -ENODEV;

Please revisit this change; smsc47m1_find() returns an int, whereas address is an unsigned int.

Thanks,

*** Rob.

> +	address = smsc47m1_find(&sio_data);
> +	if (address < 0)
> +		return address;
>  
>  	/* Sets global pdev as a side effect */
>  	err = smsc47m1_device_add(address, &sio_data);
> -- 
> 1.7.5.4
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 
> 
> 
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
