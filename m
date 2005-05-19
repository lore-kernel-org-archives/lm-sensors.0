From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: sysfs names
Message-Id: <20040215165730.GB25709@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040126230447.09700886.khali@linux-fr.org>
In-Reply-To: <20040126230447.09700886.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Feb 14, 2004 at 10:03:50AM +0100, Jean Delvare wrote:
> > It'd be nice if the driver could provide a parameter to the
> > sysfs show() and store() routines... i.e.
> > 
> > static ssize_t show_temp(struct device *dev, char *buf, int param);
> > 
> > DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 1)
> > DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 2)
> > DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 3)
> 
> Much like what we had in 2.4. And this was Good.

But we had multiple values per file, which was not "good" at all :)

> > But, I can't see a way to do this without forcing a massive
> > rewrite of all sysfs-enabled drivers - oh well.
> 
> Sad but probably true. Still I'd like to hear Greg about what it would
> take to do so, and if there is a chance that this happens in 2.7.

I really doubt it, as it isn't on my list of things to do, but others
might want to see helpers like this, and I always take patches...

thanks,

greg k-h
