From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: S3C2410 I2C driver
Message-Id: <20041012010048.GB20725@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041008130842.GK12218@home.fluff.org>
In-Reply-To: <20041008130842.GK12218@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 12, 2004 at 01:49:34AM +0100, Ben Dooks wrote:
> On Mon, Oct 11, 2004 at 05:29:32PM -0700, Greg KH wrote:
> > On Sun, Oct 10, 2004 at 11:05:50PM +0100, Ben Dooks wrote:
> > > On Fri, Oct 08, 2004 at 02:08:42PM +0100, Ben Dooks wrote:
> > > > I have the first version of my Samsung S3C2410 I2C bus driver
> > > > available at http://www.fluff.org/ben/linux-26/i2c-s3cdrv1.patch
> > > > 
> > > > Tested against 2.6.9-rc3.
> > > > 
> > > > I would be grateful of any comment, as I would like to get this
> > > > support into the 2.6 kernel soon.
> > > 
> > > Is the correct approach to getting this patch applied to email
> > > linux-kernel@vger.kerne.org and cc greg@kroah.com and 
> > 
> > Yes.
> > 
> > > I also need an allocation for I2C_ALGO_S3C2410
> > 
> > Hm, I thought we didn't need ids allocated anymore.  Doesn't your driver
> > work just fine without it?
> 
> Ok, I've not seen that information before... what is the correct
> value to set this to? I assume that the identity of the controller
> can be ascertained from it's parent device?

Hm, this is for a bus driver?  I need to see the patch to give you a
better answer.

> > Care to send the patch so we can comment on it?
> 
> The last version was put on my website for download, as I didn't
> know wether people would get irritated at having a large-ish patch
> sent to the list... I can repost the patch inline if people would
> like to see it in the message.

Inline lets us comment on it properly.

thanks,

greg k-h
