From: ac9410@attbi.com (Albert Cranford)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: [Fwd: Re: [patch 3/3] 2.5.36 i2c new adapter i2c-pport driver]
Message-Id: <3D892720.74A81A18@attbi.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Again,  tried to submit i2c-pport.c but the usage of
udelay(#) has to change to schedule_timeout(#).

I think this is going to affect lots of drivers and needs
converting before we will get sensors included into the
kernel.
Albert
-------- Original Message --------
Subject: Re: [patch 3/3] 2.5.36 i2c new adapter i2c-pport driver
Date: Wed, 18 Sep 2002 12:33:46 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
To: Albert Cranford <ac9410@attbi.com>
CC: Linus Torvalds <torvalds@transmeta.com>,Kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209180205270.358-200000@home1>

Albert Cranford wrote:
> +static int bit_pport_init(void)
> +{
> +	if (!request_region((base+2),1, "i2c (PPORT adapter)")) {
> +		return -ENODEV;	
> +	} else {
> +
> +		/* test for PPORT adap. 	*/
> +	
> +
> +		PortData=inb(base+2);
> +		PortData= (PortData SET_SDA) SET_SCL;
> +		outb(PortData,base+2);				
> +
> +		if (!(inb(base+2) | 0x06)) {	/* SDA and SCL will be high	*/
> +			DEBINIT(printk("i2c-pport.o: SDA and SCL was low.\n"));
> +			return -ENODEV;
> +		} else {
> +		
> +			/*SCL high and SDA low*/
> +			PortData = PortData SET_SCL CLR_SDA;
> +			outb(PortData,base+2);	
> +			udelay(400);


use schedule_timeout() instead of udelay() since you're in process 
context.  otherwise, looks ok...
