From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Patches for 2.6.0 (lm83 and misc)
Message-Id: <20031009212706.GC12618@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031004160750.70561b1d.khali@linux-fr.org>
In-Reply-To: <20031004160750.70561b1d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 09, 2003 at 11:23:15PM +0200, Jean Delvare wrote:
> > > - Port my lm90 driver.
> > > - Port the adm1025 driver.
> > 
> > Nice.
> 
> I'll wait until the lm83 driver is accepted. That way, if changes are
> needed for that driver, I won't have to fix these things for the new
> drivers.

Why wait?  The lm83 driver is sitting in my bitkeeper tree, and I can
gladly add others.  I'm doing the same thing for two new USB drivers
already :)

And who knows how long it will be before 2.6.0 comes out...

thanks,

greg k-h
