From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: [BK PATCH] I2C update for 2.6.10-rc1
Message-Id: <20041109152145.GB27269@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041109052229.GA5117@kroah.com> <vYBFH9gE.1099992539.9943000.khali@gcu.info>
In-Reply-To: <vYBFH9gE.1099992539.9943000.khali@gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

On Tue, Nov 09, 2004 at 10:29:00AM +0100, Jean Delvare wrote:
> 
> Hi Greg,
> 
> >Greg Kroah-Hartman:
> >  o I2C: delete normal_i2c_range logic from sensors as there are no more
> >         users
> >  o I2C: moved from all sensor drivers from normal_i2c_range to normal_i2c
> >  o I2C: fix i2c_detect to allow NULL fields in adapter address structure
> >  o I2C: remove normal_isa_range from I2C sensor drivers, as it's not used
> >  o I2C: remove ignore_range from I2C sensor drivers, as it's not used
> >  o I2C: remove probe_range from I2C sensor drivers, as it's not used
> 
> I'm very happy with that :) A documentation update will be needed though.

Doh, ok, I'll go do that, forgot that...

> Also, while we're at it, is there any reason why I2C_CLIENT_END and
> I2C_CLIENT_ISA_END are two different constants?

unsigned short vs unsigned int, right?

thanks,

greg k-h
