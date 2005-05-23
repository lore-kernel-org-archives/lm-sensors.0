From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Mon, 23 May 2005 05:37:40 +0000
Subject: [lm-sensors] Re: [RFC PATCH 2.6.12-rc3-mm2 1/2] i2c: new sysfs
Message-Id: <2538186705052220372c2d6162@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050503034928.GC4977@jupiter.solarsys.private>
In-Reply-To: <20050503034928.GC4977@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> I thought I would finish the userspace/libsensors modifications first,
> then I could shake out any interface problems.  As I wrote earlier:
...
> I was thinking of passing the class device ID string as a parameter to
> hwmon_device_register() instead of pulling it out of dev->bus_id.  If I
> were to re-submit the patch for inclusion (w/ the changes suggested by
> Greg)... what would you use for the class device ID string for bmcsensors?

err... I don't know...not bus id :-). bmcsensors works using the
kernel IPMI messaging interface, and that really isn't a bus at
all...its more like a messaging protocol, hence the need in my mind to
remove all the i2c references.

Jean was explaining to me today that this patch just adds the sysfs
clsss and drivers would still be i2c based, I was under the mistaken
impression it was standalone, but as your e-mail stated that is yet to
be implemented.

I fear that bmcsensors really needs the full separation from i2c, how
realistic would it be to go ahead and try something like that at this
stage (I can help out)? It would seem to me that basically everything
under drivers/i2c/chips should be moved into drivers/hwmon and perhaps
drivers/i2c/bus to drivers/i2c (although the latter isn't necessary,
it just makes sense to me).

> If we can have such a patch included on the condition that it may still
> change (due to interface / naming conventions) then I will rework it
> and submit it on Wed or Thu.  Maybe we can keep it in -mm for an extended
> period until I finish the libsensors stuff.  Would that work for you?

Yes, I need the dynamic sysfs stuff that will be in -mm anyway, I so
that's perfectly fine, I expect all of this to be in testing for a
while.

> Mark (hacking on his house instead of his computer) Hoffman

Breaking things takes on all new meaning with that type of hacking, be
careful ;-)

Thanks,
Yani
