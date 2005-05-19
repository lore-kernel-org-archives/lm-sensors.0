From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: [BK PATCH] i2c driver fixes for 2.6.0-test2
Message-Id: <20030802165638.GF11038@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030802052904.GA9782@kroah.com>
In-Reply-To: <20030802052904.GA9782@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Aug 02, 2003 at 09:55:18AM +0200, Jean Delvare wrote:
> 
> Greg,
> 
> > <nikkne:hotpop.com>:
> >   o I2C: fix Kconfig info
> > 
> > <patrick:dreker.de>:
> >   o I2C: add ncforce2 i2c bus driver
> > 
> > Benjamin Herrenschmidt:
> >   o I2C: timer clean up for i2c-keywest.c
> > 
> > Daniele Bellucci:
> >   o I2C: fixed a little memory leak in i2c-ali15x3.c
> > 
> > Greg Kroah-Hartman:
> >   o I2C: remove devinitdata marking from i2c-nforce2.c as it's wrong
> >   o I2C: consolidate the i2c delay functions
> >   o I2C: minor cleanups to the i2c-nforce2 driver
> > 
> > Jan Dittmer:
> >   o I2C: convert via686a temp_* to milli degree celsius
> 
> Does any of these apply to our CVS repository?

Probably :)

The memory leak from Daniele is probably needed, and the i2c delay
cleanup can also be moved there.  I don't think the others really apply
though.  I've put the individual patches in my kernel.org account if
people want to see them (sorry for not posting them to the list, but I
already have, this was just a re-send of these patches to Linus.)

thanks,

greg k-h
