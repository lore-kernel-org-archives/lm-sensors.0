From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <20050428173909.GA19060@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Apr 28, 2005 at 01:25:29PM -0400, Yani Ioannou wrote:
> > My question is, please show me how you propagate this out to the driver
> > core code, so that the drivers that use the DEVICE_ATTRIBUTE() stuff can
> > take advantage of this.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Well bmcsensors (before this patch) was creating device attributes
> like the other chip drivers, just not explicitly using the
> DEVICE_ATTRIBUTE macro, however I can easily modify one of the other
> sensor chip drivers to show you how they might take advantage of this
> if that what you are looking for? I'll probably have to do it tonight
> after I get home though :-).

Yes, that is what I was looking for.

thanks,

greg k-h
