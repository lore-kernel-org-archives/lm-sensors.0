From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: Bug #1807: sensors with kernel 2.4, but not with kernel 2.6
Message-Id: <20041104180847.GB16744@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1099499003.11618.13.camel@antares.hausnetz>
In-Reply-To: <1099499003.11618.13.camel@antares.hausnetz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Nov 04, 2004 at 02:34:57PM +0100, Jean Delvare wrote:
> 
> 1* What is the different between "normal" i2c addresses and "probe"
> i2c addresses? It seems that both arrays are treated the same way, and
> no client driver is using "probe" addresses (at a quick glance at
> least.) Can't we just get rid of it?

Yes we should.  I've started to look at how to reduce the number of
things in the per-driver structure and this is one that will go away
soon (along with the ranges, but that's for another email...)

> 2* What is the difference between i2c_probe in i2c-core and i2c_detect in
> i2c-sensor (i2c-proc in 2.4)? Both functions seem to be very similar, I
> couldn't find a difference (but I admittedly did not compare line by
> line yet). If there are, it's probably not worth the code duplication.
> As a matter of fact, I don't see how exactly i2c_detect is supposed to
> be sensor-related. Can't we get rid of i2c_detect and use i2c_probe
> everywhere?

Yes we can, if we merge the two structures properly.  Right now they
aren't alike in a very tiny way.  Any patches to fix all of this up
would be greatly appreciated so that I can mark another thing off of my
todo list :)

> It would be great if we could clean this mess now because I will do
> significant changes to that part of the code soon (to get rid of the
> thinkpad breakage issue, just like I did in the userspace tools already).
> 
> I admit that I find it a little strange that two things so obviously
> redundant could have been in place for so long and nobody ever objected.
> Am I missing something?

I've always noticed them, but in the 2.6 push to get stable, I ignored
them as it will take a bit of work to fix them up.

thanks,

greg k-h
