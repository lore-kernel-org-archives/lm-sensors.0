From: greg@kroah.com (Greg KH)
Date: Thu, 02 Jun 2005 08:03:00 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc5-mm1 3/3] i2c: modify sensors
Message-Id: <20050602061306.GC8530@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050602033727.GD4906@jupiter.solarsys.private>
In-Reply-To: <20050602033727.GD4906@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 01, 2005 at 11:37:27PM -0400, Mark M. Hoffman wrote:
> @@ -37,6 +39,8 @@ static unsigned int normal_isa[] = { I2C
>  /* Insmod parameters */
>  SENSORS_INSMOD_8(adm1021, adm1023, max1617, max1617a, thmc10, lm84, gl523sm, mc1066);
>  
> +static int id;	/* increment once for every chip found */
> +

You duplicate this logic in every driver.  Is it really needed?  How
about having the "bus id" be unique for all hwmon devices?  That way, no
id varible is needed, and just the name of the device.  Then, in the
hwmon core, you add the unique number to the front of the name.
Something like:
	01-adm1021
	02-adm1025
and so on.

Any thoughts?

thanks,

greg k-h
