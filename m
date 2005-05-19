From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: [PATCH] eeprom chip driver for 2.6
Message-Id: <20030924180256.GD10443@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030923232510.GB6265@kroah.com>
In-Reply-To: <20030923232510.GB6265@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 24, 2003 at 09:13:15AM +0200, Jean Delvare wrote:
> 
> > Ok, I finally got the sysfs binary file interface hooked up to the
> > eeprom driver in 2.6.  Turned out to be easier than I thought.  Below
> > is the patch that I'll be sending to Linus in a bit.  If anyone has
> > any comments on it, I'd appreciate it.
> 
> > p.s. I added the Viao check too :)
> 
> Thanks :) BTW, where is my name? ;)) (just kidding)
> 
> Overall, it's OK for me. I'm still concerned by the performance issue.
> This driver will be far "slower" than current CVS' one (from sensors'
> point of view) but this has already been discussed and I have no
> concrete solution to propose, so let's forget about it.

Ah, missed that part of your change to the driver.  Patches are always
welcome :)

> > +/* EEPROM memory types: */
> > +#define ONE_K			1
> > +#define TWO_K			2
> > +#define FOUR_K			3
> > +#define EIGHT_K			4
> > +#define SIXTEEN_K		5
> > 
> 
> This could go away, the defines are unused as far as I can tell.

Looks that way, thanks.  Same thing for the cvs version too...

greg k-h
