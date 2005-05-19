From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:54 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <20050426072938.GF6387@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Apr 25, 2005 at 01:36:56AM -0400, Yani Ioannou wrote:
> Hi all,
> 
> I'm sending this driver sysfs callback patch to the lm-sensors list to
> get more of the sensor driver maintainer's comments on the patch
> (specifically the type to be associated with each sysfs entry) before
> submitting to LKML. Jean and Greg have already given me invaluable
> feedback and are supportive of the general idea of the patch (the
> problem of which is epitomized by the kludge the 2.6 bmcsensors driver
> is at the moment - see previous discussions in the list archive).
> 
> Included is a patch against drivers/base/core.c and
> include/linux/driver.h that adds a void * to the device attribute
> struct and passes it back to the two sysfs callbacks show/store. Also
> included is a simple perl script we can run against the source tree to
> update drivers to use the correct callback pointer types (otherwise
> warnings are generated on compile for each). Of course 'real' fixes in
> the spirit of the new callbacks would be to use the void */passed type
> to implement a single/few dynamic callback instead of the messy static
> callbacks at present, but I leave that up to the individual driver
> maintainer.

Care to show how a driver would use this change?

And the void * shouldn't be called ptr, use what other structures call
their void pointers, "data", "private", etc.

thanks,

greg k-h
