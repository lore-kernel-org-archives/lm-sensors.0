From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: S3C2410 I2C driver
Message-Id: <20041013172539.GB17142@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041008130842.GK12218@home.fluff.org>
In-Reply-To: <20041008130842.GK12218@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 12, 2004 at 11:18:22PM +0100, Ben Dooks wrote:
> +
> +static int debug_info;
> +static int debug_norm = 1;

Why not make these module_param()?  That way they could be changed at
module load time, or at run time (module paramaters are also boot line
options if they are built into the kernel.) 

Or, most likely, these can just be deleted all together as you aren't
developing the driver anymore, right?

> +/* Debug */
> +
> +#define DBG(lev, msg...) do {\
> +	if (lev < debug_info) \
> +		dev_info(i2c->dev, msg); \
> +	if (lev < debug_norm ) \
> +		dev_dbg(i2c->dev, msg); \
> +	} while(0)

And if they go away, this odd DBG() macro can also go away, right?

Other than that minor stuff, it looks good to me.

thanks,

greg k-h
