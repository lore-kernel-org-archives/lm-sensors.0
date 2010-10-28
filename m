From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 28 Oct 2010 15:11:38 +0000
Subject: Re: [lm-sensors] New/undocumented ABI attributes in w83795 driver
Message-Id: <20101028171138.260366ab@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100919163321.GA30847@ericsson.com>
In-Reply-To: <20100919163321.GA30847@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

Sorry for the late reply. I hoped to have some time to investigate
before replying, but I didn't and now the merge window is there and a
decision has to be made.

On Sun, 19 Sep 2010 14:34:53 -0700, Guenter Roeck wrote:
> On Sun, Sep 19, 2010 at 03:40:24PM -0400, Jean Delvare wrote:
> > Hi Guenter,
> > 
> > On Sun, 19 Sep 2010 09:33:22 -0700, Guenter Roeck wrote:
> > > I had a closer look into the w83795 driver - this time trying to ignore
> > > coding style problems ;) - and noticed that there are several attributes
> > > which are not defined in the ABI.
> > 
> > Correct. I've seen them too, but they are not in the part of the driver
> > I carefully reviewed and tested yet. I think most (all?) of them are in
> > the automatic fan speed control area. The few ones which were in the
> > monitoring part of the driver, I have fixed already, hopefully.
>
> Just wondering - does it make sense to push the untested parts of the driver
> into the kernel, or would it be better to keep that out until you had a chance 
> to test it ? Especially since those parts go beyond monitoring and actually
> control something.

This is a very sane questioning, and I would certainly ask the same
question if I wasn't the submitter of the driver ;)

I have a little problem with just removing the untested code. For one
thing, just because it's untested doesn't mean it doesn't work, and as
a matter of fact, it works are least partly. For another, I am not the
author of the code in question. Removing it and adding it again later
would, it would be difficult to give proper attribution for the work.

Last but not least, this would be more work for me, and the little time
I can spend on this driver, I'd rather spend on testing and fixing
bugs.

As a compromise, I can offer to introduce a temporary configuration
option, CONFIG_SENSORS_W83795_FANCTRL, which would default to no, with
a big disclaimer that enabling it isn't encouraged except for
developers and careful testers. Once this part of the code has been
properly reviewed and tested, the configuration option can default to
yes, and finally get dropped.

Would this be OK with you?

This approach also has the advantage to hide the non-standard sysfs
attributes for now, giving me some time to decide what to do with them
(remove them or standardize them.) I've taken a look at these and I
think that some of them should be kept and renamed. Some are duplicated
from the w83793 driver, so they aren't entirely new. Keeping them as is
makes some sense, because users are likely to upgrade from one server
board with a W83793G device to a new server board with a W83795G/ADG
device, and having the same attributes makes the migration easier. But
of course this is bad still, because the names aren't standard (yet.)

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
