From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: i2c_force_data
Message-Id: <LnYPITbO.1100017658.7285730.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041109005252.GA26855@kroah.com>
In-Reply-To: <20041109005252.GA26855@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Greg,

> Ok, thanks for the descriptions.  But moving the structure out of the
> i2c_address_data field shouldn't be a problem, as long as I retain the
> original functionality, right?

True as far as I can see. However, I don't know what exactly you have in
mind. If you want to describe it in more details, I would be more able
to tell you how good it sounds to me. Or just wait until you have it
ready and I'll review it then, at your option. Depends on how confident
you are I guess ;)

> Also, a lot of this will be done with sysfs, and not as module
> paramaters, to make it more uniform accross bus types (see the various
> odd threads on lkml about trying to unify the "add a device id" to a bus
> type for more details.)

I'm not diving into the LKML archives today. I think I remember of
threads about how to standardize the way devices are numbered and
identified among the various bus types so that the hotplug stuff can be
kept simple. I guess this is what you refer to. I were not aware that
other busses had device id forcing requirements like we have for I2C
though.

> Speed really isn't an issue, as device probing will soon be
> multithreaded within the kernel.  It would just be a thread off doing
> the probing while everything else happens like normal.

I'm more concerned about bus load. We have seen poor hardware
implementations and messy BIOSes causing SMBus locks on high load. We
don't want this to happen at boot time.

> All I want to do is have the address that chip drivers support be
> exported to userspace throught the MODULE_DEVICE_ID interface.  Then, if
> the user wants it, basically do the same thing as i2c-detect does
> (testing all addresses for a valid answer).  If it looks like there is a
> chip there, create a device, which creates a hotplug event, which lets
> userspace look up what driver it wants to have loaded, if any.
>
> The logic about detecting which driver for which device still remains in
> userspace, where it belongs.
>
> Although moving some of the sensors-detect logic into a hotplug script
> might be useful in the end, but I'll worry about that when we get there.
> I really just want the MODULE_DEVICE_ID() stuff done first.  More fun
> can happen after that.

OK, now I see what you want to do. Basically adapt the sensors-detect
script so that it is suitable for hotplug. Sounds interesting. The good
part being that sensors-detect is hosed and needs a complete rewrite
anyway ;)

If I understand correctly, the information the kernel would transmit to
hotplug would be "a client chip was found at I2C address (N, M)", and
it would be left to the user-space to probe that address (sensors-detect
like) and load the appropriate module?

As a side note, it won't work for non-Super-I/O ISA chips unless I'm
missing something (ISA PnP maybe?)

And the Super-I/O chips would probably need yet something different, but
that's quite another story.

> I agree, I'll go slowly, and I know everyone here will be sure to tell
> me when I get things wrong :)

True. Feel free to share your code and thoughts as you go, in case I
could be of some help.

> > In particular, if we go that
> > direction, I think we would start by listing which chips can safely be
> > automatically detected and which do not, and only attempt to autoload
> > safe drivers (or, more precisely, safe devices within a driver).
>
> That would be great, do we have such a list anywhere already?

Not exactly. However, such a list could be easily regenerated from the
confidence values stored in sensors-detect. Chips to which we never
grant a confidence value greater than (say) 5 are bad candidates to
autoloading. A closer look should let us refine the list.

If you are interested, I may provide a comprehensive list of I2C client
drivers and chips stating the "autoloadability" for each chip. Since I
know the various hardware monitoring chips and sensors-detect very well,
I will probably come to a decent candidate list faster than anyone else.
If you want a similar document for ISA chips and Super-I/O chips, just
let me know.

Thanks,
Jean
