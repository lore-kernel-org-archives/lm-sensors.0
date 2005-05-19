From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: sysfs names
Message-Id: <20040218220317.GB5533@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040126230447.09700886.khali@linux-fr.org>
In-Reply-To: <20040126230447.09700886.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Feb 15, 2004 at 07:36:33PM +0100, Jean Delvare wrote:
> > In looking at these drivers they can easily be shrunk today with just
> > a bit of rewriting of the functions and macros.  I sure wasn't
> > thinking about driver size when writing the first few ones, and it
> > looks like everyone has copied my "style" in the rest of them.
> 
> If you could provide an example of how to do that, I'm interested in
> shrinking the existing drivers.

Hm, I thought I saw some drivers that could be shrunk, but at a quick
glance, I was wrong.  It's probably not worth the complexity...

thanks,

greg k-h
