From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <20050428162737.GD17658@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Apr 28, 2005 at 09:45:38AM -0400, Yani Ioannou wrote:
> Actually I was running a kernel with only bmcsensors changed to use
> the void * - it should work transparently for all the other drivers
> (except for a compilation warning about invalid show/store pointer
> types being passed - and I have a perl script we can run against the
> source tree to update drivers and get rid of those warnings).
> 
> The void * is completely optional of course, its up to the driver to
> use it or not (unless I'm missing your question here?).

My question is, please show me how you propagate this out to the driver
core code, so that the drivers that use the DEVICE_ATTRIBUTE() stuff can
take advantage of this.

thanks,

greg k-h
