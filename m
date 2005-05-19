From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: [PATCH 2.6] I2C: New PC8736x chip driver
Message-Id: <20041105223613.GC3199@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041029224731.58d0be48.khali@linux-fr.org>
In-Reply-To: <20041029224731.58d0be48.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Nov 05, 2004 at 11:32:34PM +0100, Jean Delvare wrote:
> > Applied, thanks.
> > 
> > Oh, and I fixed up your MODULE_PARAM warning too :)
> 
> Sorry, I should have noticed the change. That said I did not see any
> warning. Are these compile-time or run-time warnings? Anything special
> needs to be done to actually see them?

Compile time warnings.  You might need a newer version of gcc to see
them, don't really know.

thanks,

greg k-h
