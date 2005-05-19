From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: [patch] it87.c patch for Shuttle SS51G and co
Message-Id: <20040302203620.GA3395@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040302200945.GA3141@kroah.com>
In-Reply-To: <20040302200945.GA3141@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 02, 2004 at 09:20:29PM +0100, Jean Delvare wrote:
> > > The included patch implements a it87 module parameter to
> > > enable/disable the chip init when explicitely specified. The default
> > > is still "1". On Shuttle SS51G machines (and related) reseting the
> > > chip also resets the "vario" speed of the fans, causing them to go
> > > at full speed thereafter until the next reboot. Noisy :-)
> > > 
> > > The patch is against vanilla 2.6.3 i2c.
> > (...)
> > Also, please post this to the sensors list (now CCed) so that the
> > other developers there can make comments on it.
> 
> Hm, we already have a patch pending doing just this, by Takeru KOMORIYA.
> You can get it here:
> http://delvare.nerim.net/i2c/linux-2.6/linux-2.6.3-i2c-it87-2-reset.diff
> 
> Greg, I think I remember it's even already in your BK tree...

Yeah it is.  I would have realized that when I would have tried to apply
it :)

Anyway, this reinforces the fact that stuff should be sent to the
mailing list and not only to me...

thanks,

greg k-h
