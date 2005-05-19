From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [BK PATCH] More i2c driver fixes for 2.6.0-test2
Message-Id: <20030811204316.GB18382@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030808235501.GA2795@kroah.com>
In-Reply-To: <20030808235501.GA2795@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Aug 09, 2003 at 09:38:11AM +0200, Jean Delvare wrote:
> 
> > Here are some more i2c driver fixes for 2.6.0-test2.  They include a
> > fix for the driver model code (no release function, so easy oopses
> > could happen by users), and removing usage of the struct device.name
> > field as that is about to go away.
> > 
> > Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5
> 
> Do any of these apply to our CVS tree?

Nope, in fact it now makes the i2c drivers a bit more compatible with
the older 2.4 versions now that I had to move the name field back into
the i2c structures.

thanks,

greg k-h
