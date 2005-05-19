From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: More on SMBus multiplexing
Message-Id: <20041104180956.GC16744@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041023200215.38e375a1.khali@linux-fr.org>
In-Reply-To: <20041023200215.38e375a1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Nov 04, 2004 at 09:53:17AM +0100, Jean Delvare wrote:
> 
> Hi Greg,
> 
> > > On second thought, don't. As I said on LKML this morning, my autoload
> > > code doesn't work and we will have to stick to manual loading for now.
> > > I'll provide a simplified patch that does this tomorrow.
> > >
> > > Thanks and sorry for the trouble.
> >
> > Heh, glad I've been putting i2c patches off for a while, it payed off
> > here :)
> 
> Hehe, true enough. That said, I think you have been curiously silent
> about the SMBus multiplexing issue. Care to tell me if the last approach
> I am proposing (minus the autoloading) is fine with you? If you don't
> want to comment on the i2c part of it, please at least tell me if it is
> acceptable kernel-wise.

It looks fine kernel-wise from what I can tell.  Sorry about being
quiet, been busy in other parts of the kernel lately that happen to have
bigger fires to put out (stupid usb suspend issues...)

thanks,

greg k-h
