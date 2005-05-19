From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:11 +0000
Subject: i2c sysfs rant
Message-Id: <20030808233403.GA2564@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806191145.GG710@gmx.de>
In-Reply-To: <20030806191145.GG710@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 07, 2003 at 11:09:03AM +0200, Wiktor Wodecki wrote:
> On Wed, Aug 06, 2003 at 04:22:44PM -0700, Greg KH wrote:
> > On Wed, Aug 06, 2003 at 09:11:45PM +0200, Wiktor Wodecki wrote:
> > > Hello folks,
> > > 
> > > I just saw that I2C provides "/sys/bus/i2c/drivers/dev\ driver" in
> > > 2.6.0-test2. It would be nice if you'd consider renaming this to
> > > dev_driver, to avoid un-neccessary quoting in scripts.
> > > 
> > > Thank You :-)
> > 
> > Patches are always gladly accepted :)
> 
> here you go

Applied to my trees, thanks.

greg k-h
