From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: tickets needing help
Message-Id: <20040104094614.GA28147@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FF64825.9060808@verizon.net>
In-Reply-To: <3FF64825.9060808@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 04, 2004 at 10:33:32AM +0100, Jean Delvare wrote:
> > For 2.6 kernel stuff I'd recommend pointing people to use the
> > bugzilla.kernel.org system instead.
> 
> We would then need:
> 1* A write access to the system.

Create an account and you have it.  Any one can create bugs.

> 2* A way to locate the tickets related to lm_sensors. Looks like we
> would search with Component=I2C,

Yes, that's the proper search.  And there are a number of older, closed
bugs with that component.

> but actually the only bug that has i2c in its body has
> Component=Sound, because the driver concerned, although using the i2c
> interface, is a sound driver. BTW, the problem mentioned in this
> ticket (#611) seems to have been solved in 2.5.71, so the bug should
> be closed.

Thanks, I just did that.

> Greg, how do we proceed?

Right now, any bug that is has component=i2c is automagically assigned
to me.  I'll be glad to assign it on to anyone else if they want me to,
but for now, the i2c bug count in there has been real low.

Feel free to open any new bugs, 2.6 only, in that database if you wish.

thanks,

greg k-h
