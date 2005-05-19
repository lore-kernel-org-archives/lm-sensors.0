From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: [BK PATCH] i2c driver fixes for 2.6.0-test2
Message-Id: <20030804160630.GB3395@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030802052904.GA9782@kroah.com>
In-Reply-To: <20030802052904.GA9782@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Aug 03, 2003 at 01:27:28AM -0400, Mark M. Hoffman wrote:
> 
> Done, plus most of the nforce2 patch.  This bit though... any particular
> reason you didn't just whack all of it?
> 
> @@ -345,18 +334,12 @@
>  			smbus->base, smbus->base+smbus->size-1, name);
>  		return -1;
>  	}
> -
> -	/* TODO: find a better way to find out whether this file is compiled
> -	 * with i2c 2.7.0 of earlier
> -	 */
> -/*#ifdef I2C_HW_SMBUS_AMD8111
> +/*
>  	smbus->adapter.owner = THIS_MODULE;
> -#endif
> -
>  	smbus->adapter.id = I2C_ALGO_SMBUS | I2C_HW_SMBUS_NFORCE2;
>  	smbus->adapter.algo = &smbus_algorithm;
> -	smbus->adapter.algo_data = smbus;*/
> -
> +	smbus->adapter.algo_data = smbus;
> +*/

I didn't have the time to verify if this really should be set or not, so
I left the main portion alone.  Does this mean I can delete all of the
commented out area for 2.6?

thanks,

greg k-h
