From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: [PATCH] New driver-id for radeon-i2c
Message-Id: <20030829171619.GA1450@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030823173658.GA3278@kroah.com>
In-Reply-To: <20030823173658.GA3278@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Aug 29, 2003 at 06:47:51PM +0200, Jean Delvare wrote:
> > On Sat, Aug 23, 2003 at 06:58:47PM +0200, Kronos wrote:
> > > Hi Greg,
> > > I forgot to cc you when I sent the radeonfb-i2c patch to fbdev. I
> > > need a new driver-id:
> > > 
> > > 
> > > --- linux-2.6.vanilla/include/linux/i2c-id.h	Tue Jul 15 14:27:55
> > > 2003+++ linux-2.6/include/linux/i2c-id.h	Wed Aug 20 19:22:58 2003
> > > @@ -99,6 +99,7 @@
> > >  #define I2C_DRIVERID_24LC32A	51	/* Microchip 24LC32A 32k EEPROM	*/
> > >  #define I2C_DRIVERID_STM41T00	52	/* real time clock		*/
> > >  #define I2C_DRIVERID_UDA1342	53	/* UDA1342 audio codec		*/
> > > +#define I2C_DRIVERID_RADEON	54	/* I2C bus on Radeon boards	*/
> > 
> > Thanks, I've given you the id of 55, as someone else is already using
> > 54.  I'll send the patch on to Linus in a few days.
> 
> Hey, wait a minute. *We* (the LM Sensors group) are the authority for
> giving the IDs. And we gave 54 for Radeon. Whoever else is using 54 has
> no right to do so. So, please use 54 for Radeon in 2.6 too, and ask the
> other person to contact us to get an ID (which will probably be 55).

Ah, the joys of trying to control a codebase that is out of your control :)

It looks like the big zoran driver update that went into the 2.6 kernel
tree added an id for number 54:
	#define I2C_DRIVERID_ADV7170	54	/* video encoder	*/

As that driver also has 3 other ids, I guess they got there first.

I've cced the person who sent in the patch to Linus for this driver.

Personally, I think we should just make the Radeon #55 as I've done in
the 2.6 tree and move on, we all have better things to do with our
time...

thanks,

greg k-h
