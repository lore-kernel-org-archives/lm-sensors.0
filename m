From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: w83781d i2c driver updated for 2.5.66 (without sysfs support)
Message-Id: <20030326202904.GK24689@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan>
In-Reply-To: <1048705473.7569.10.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schlemmer <azarah@gentoo.org>
Cc: KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>, sensors@Stimpy.netroedge.com

On Wed, Mar 26, 2003 at 09:04:33PM +0200, Martin Schlemmer wrote:
> Hi
> 
> Ok, this is the w83781d driver updated for 2.5.66bk2.  It works
> over here.

Looks nice, thanks.

Some of the nasty casts should be fixed up though.  Stuff like:

> +      ERROR7:
> +	if (!is_isa)
> +		i2c_detach_client(&
> +				  (((struct w83781d_data
> +				     *) (i2c_get_clientdata(new_client)))->
> +				   lm75[1]));
> +      ERROR6:
> +	if (!is_isa)
> +		i2c_detach_client(&
> +				  (((struct w83781d_data
> +				     *) (i2c_get_clientdata(new_client)))->
> +				   lm75[0]));
> +      ERROR5:
> +	if (!is_isa)
> +		kfree(((struct w83781d_data *) (i2c_get_clientdata(new_client)))->
> +		      lm75);

Is just obnoxious :)

I'll hold off sending this driver to Linus until it gets cleaned up with
sysfs entries, as I'd rather not pollute /proc and sysctls anymore.

thanks,

greg k-h
