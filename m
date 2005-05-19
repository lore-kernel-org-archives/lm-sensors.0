From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: algorithm and bus driver for PCA9564
Message-Id: <20040810164136.GC31655@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1091438873.11210.55.camel@icampbell-debian>
In-Reply-To: <1091438873.11210.55.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Aug 10, 2004 at 10:39:19AM +0100, Ian Campbell wrote:
> On Fri, 2004-08-06 at 00:45, Greg KH wrote:
> > On Mon, Aug 02, 2004 at 10:27:53AM +0100, Ian Campbell wrote:
> > > Attached is a driver for the PCA9564 "Parallel to I2C" chip
> [SNIP]
> > > The driver is against a 2.6 BK tree pulled on Friday. I also have a
> > > fairly trivial 2.4 backport if that is of interest. 
> > 
> > Looks good, I've applied this to my trees, and will send it off to Linus
> > after 2.6.8 is out.
> 
> Thanks Greg. 
> 
> Are you at all interested in a patch of the 2.4 backport?

I'm not, as I don't really care about 2.4 anymore :)

But perhaps other developers/users are interested, I don't know how
active the 2.4 cvs lmsensors tree currently is.

thanks,

greg k-h
