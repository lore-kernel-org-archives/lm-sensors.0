From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: [PATCH] Driver Core patches for 2.6.9-rc1
Message-Id: <20040826041019.GA8445@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10934733881970@kroah.com> <1093485846.3054.65.camel@gaston>
In-Reply-To: <1093485846.3054.65.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, sensors@stimpy.netroedge.com
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>

On Thu, Aug 26, 2004 at 12:04:06PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2004-08-26 at 08:36, Greg KH wrote:
> > ChangeSet 1.1873, 2004/08/25 13:21:22-07:00, khali@linux-fr.org
> > 
> > [PATCH] I2C: keywest class
> > 
> > This is needed for iBook2 owners to be able to use their ADM1030
> > hardware monitoring chip. Successfully tested by one user.
> 
> Vetoed until I get a proper explanation on what that is supposed to do,
> I don't want random stuff mucking around the i2c busses on those machines,
> only specifically written drivers for the chips in there.
> 
> Please, do NOT apply.

Oops, sorry, already in :(

Anyway, sensors people, any further info on this patch?

thanks,

greg k-h
