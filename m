From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: [PATCH] More i2c driver changes for 2.5.65
Message-Id: <20030325033436.GC11874@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10482950873871@kroah.com> <10482950921680@kroah.com> <20030325093550.GD1083@zaurus.ucw.cz> <20030325012923.GA10879@kroah.com> <20030325020418.GB8048@suse.de>
In-Reply-To: <20030325020418.GB8048@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Jones <davej@codemonkey.org.uk>, Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Tue, Mar 25, 2003 at 02:04:19AM +0000, Dave Jones wrote:
> On Mon, Mar 24, 2003 at 05:29:23PM -0800, Greg KH wrote:
> 
>  > > > +	.name		= "ADM1021-MAX1617",
>  > > Why dash here
>  > > > +	.name		= "LM75 sensor",
>  > > And space here? Also you should have 
>  > > either 2x "sensor" or none at all. 
>  > What do you mwan "2x"?
> 
> The way I parsed it, either have..
>  .name = "ADM1021-MAX1617 sensor",
>  .name = "LM75 sensor",
> 
> or
> 
>  .name = "ADM1021-MAX1617",
>  .name = "LM75",
> 
> ie, both, or all. Personally the latter looks better to me.

Ah, yes, that makes more sense now.

Yes, we shouldn't have the "sensor" in the name.

> Especially given the 16 char limit.  Aren't these going to
> be in a sysfs heirarchy where its obvious they are sensors
> anyway ? like i2c/sensors/lm75 ?

Yes, they show up as bus/i2c/drivers/

thanks,

greg k-h
