From: greg@kroah.com (Greg KH)
Date: Thu, 26 May 2005 09:05:27 +0000
Subject: [lm-sensors] Re: Who should I write to about this OOPS in 2, 6,
Message-Id: <20050525231814.GB27039@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, May 25, 2005 at 03:59:40PM -0700, Andrew Morton wrote:
> Miles Lane <miles.lane@gmail.com> wrote:
> >
> > I tried building nvidiafb into the kernel and using nvidiafb in the
> > "append" arguments.  I set "CONFIG_I2C_CHARDEV=m" to get around the
> > immediate crash.  When I booted, the nvidiafb driver worked, but the
> > crash still occurred when the DS1621 sensor driver came into
> > operation.  The Code: listing is identical to the previous scenario.
> 
> Holy cow, this was a huge email thread.
> 
> Are there still any outstanding bugs related to this which we need to fix
> in 2.6.12-rc5?

I think it was all handled.  Miles?

thanks,

greg k-h

