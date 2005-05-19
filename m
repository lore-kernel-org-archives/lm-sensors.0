From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: sysfs names
Message-Id: <20040215165609.GA25709@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040126230447.09700886.khali@linux-fr.org>
In-Reply-To: <20040126230447.09700886.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 13, 2004 at 10:28:44PM -0500, Mark M. Hoffman wrote:
> * Greg KH <greg@kroah.com> [2004-02-13 15:40:31 -0800]:
> > On Tue, Feb 10, 2004 at 08:26:51PM +0100, Jean Delvare wrote: 
> > > Greg, is it correct to have such a high number of sysfs files for a
> > > driver?
> > 
> > That's fine to do.  You might want to start using attribute lists to
> > make it easier to register all of those files :)
> 
> True enough, but that's not the part that bothers me.
> 
> It'd be nice if the driver could provide a parameter to the
> sysfs show() and store() routines... i.e.
> 
> static ssize_t show_temp(struct device *dev, char *buf, int param);
> 
> DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 1)
> DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 2)
> DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 3)
> 
> ... and so on.  Then we could end the blizzard of tiny helper
> functions and the macro abuse.  Try 'nm --size-sort w83781d.o'
> some time for an illustration.

Well we can always emulate something like the above with some macros :)

In looking at these drivers they can easily be shrunk today with just a
bit of rewriting of the functions and macros.  I sure wasn't thinking
about driver size when writing the first few ones, and it looks like
everyone has copied my "style" in the rest of them.

> But, I can't see a way to do this without forcing a massive
> rewrite of all sysfs-enabled drivers - oh well.

Yeah, that's not going to happen, sorry.

thanks,

greg k-h
