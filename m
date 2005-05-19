From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: I2C mux / virtual bus implementation
Message-Id: <40DB5E52.2030902@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

part 1

Ken Harrenstien wrote:
> On Wed, 23 Jun 2004, Mark Studebaker wrote:
> 
> 
>>you found me, although I prefer linux mail at mds4@verizon.net.
>>would be happy to discuss it with you.
> 
> 
> Great!
> 
> First, here's the relevant parts of your last message in the thread, to
> save you some trouble:
> 
> =====================
>     * /To/: Brian Kuschak <bkuschak@xxxxxxxxx
>       <mailto:bkuschak@DOMAIN.HIDDEN>>
>     * /Subject/: Re: [PATCH] - i2c virtual adapter driver for
>       multiplexed busses
>     * /From/: Mark Studebaker <mds@xxxxxxxxxxxx <mailto:mds@DOMAIN.HIDDEN>>
>     * /Date/: Fri, 14 Nov 2003 23:30:52 -0500
>     * /Cc/: sensors@xxxxxxxxxxxxxxxxxxxx <mailto:sensors@DOMAIN.HIDDEN>
>     * /Message-id/: <3FB5ABFC.DE07809C@paradyne.com <msg05086.html>>
>     * /References/: <20031113180745.84587.qmail@web40909.mail.yahoo.com
>       <msg05067.html>>
>     * /Sender/: mds@xxxxxxxxxxxxxxxxxxxx <mailto:mds@DOMAIN.HIDDEN>
> 
> ------------------------------------------------------------------------
> 
> Brian Kuschak wrote:
> 
> 
>>It's quite possible I muddied the boundaries here.
>>The reason for keeping the main functionality out of
>>i2c-virtual_cb.c is that this file is where the
>>user-specific and platform-specific code resides.  The
>>makefiles in the patch don't actually use
>>i2c-virtual_cb.c - it was included more as an example
>>of usage.  In my case, at least, the callbacks are
>>where some of our proprietary code resides and I
>>wanted to keep that isolated.
> 
> 
> we're in agreement. You did it right, I'm just conceptually mapping what you did
> onto our naming conventions. i2c-virtual is a generic 'algorithm" and
> i2c-virtual-cb is one of many possible hardware-specific "adapters"
> using that algorithm.
> 
> 
>>>- I'd rather not add entries to struct
>>>i2c_algorithm, we just went
>>>through that
>>>  hell and are finishing a patch to go to Marcelo.
>>>Rather than
>>>xxx_exclusive,
>>>  we could use the (essentially unused)
>>>algo_control. i2c-core could
>>>recognize
>>>  that a driver is virtual by adding a functionality
>>>entry to identify
>>>that
>>>  it is virtual. If you really want it the way it is
>>>we need to put
>>>#ifdefs everywhere
>>>  so we can stay compatible, at least for now...
>>>
>>
>>Point well taken.  This sounds like a reasonable
>>change.
>>
>>One comment is that the bus exclusivity and
>>multiplexing are two separate things.  Even a regular
>>non-multiplexed bus may require 'arbitration' with
>>other blades before being allowed to use it.  Likewise
>>some multiplexed busses may not require arbitration.
> 
> 
> ok. if they are two separate things let's keep them separate...
> 
> 
>>>- If i2c-pca954x also registered as a chip driver
>>>(sensors-style)
>>>  (that is, be an i2c client as well) at addresses
>>>0x70-77 then it will
>>>  get called whenever a device is found at that
>>>location, it can do
>>>detection
>>>  (if possible -doesn't look like it) and then
>>>register the new busses,
>>>and
>>>  everything gets bootstrapped. You'll get called
>>>anytime a bus
>>>  is registered. That's better than simply scanning
>>>the
>>>  adapters already present at module_init time.
>>>
>>
>>Yes, I originally thought about doing exactly that.
>>In our application due to the variety of different HW
>>platforms it made more sense to register these busses
>>manually based on a priori knowledge of the HW.
>>
>>I'll try to put together a little pcf954x client
>>driver to do the runtime registration of the virtual
>>busses, since that will likely be more useful for the
>>larger audience.
> 
> 
> do that and you don't need the bus scan in i2c-virtual I don't think
> (i2c-core scans for you).
> also you can greatly simplify i2c-virtual-cb by using the
> i2c_smbus_write_byte function from i2c-core rather than calling
> master_xfer directly.
> 
> =====================
> 
> OK....
> 
> What I've done so far is to create "pca954x.c" as a sensors-style chip
> driver supporting all variants of the PCA954x and keeping a cleaned-up
> version of Brian's i2c-virtual.c, thus leveraging all the existing
> code exactly as you suggested.  It's pretty neat, too, and allows
> multiple levels of virtual busses.
> 
> However, I suddenly realized that this won't work.  The code will
> deadlock because the pca954x client is trying to add new "virtual bus"
> adapters while the core_lists are already locked.  D'oh!
> 
> In more detail, the typical scenario is that pca954x.o gets loaded,
> and its _init function promptly calls i2c_add_driver(), which locks
> core_lists.  Much farther down the line (via driver->attach_adapter to
> pca954x_attach_adapter() to i2detect() to pca954x_detect()), the mux
> code tries to create the virtual adapter and calls i2c_add_adapter(),
> where it locks up since core_lists is locked.  It actually is safe
> since it's all part of the same thread of control, but the code currently
> has no way to know that.
> 
> I'm not quite sure of the best way to resolve this and still conform
> to the design principles of this package.
> 
> Add something to bypass the lock?  (Must work for deletes too.)  Add a
> drivers/i2c/i2c-pca954x.c adapter driver to the mess instead?  Or....?
> 
> I'm hoping that your vastly greater experience with the i2c/lm_sensors
> infrastructure will allow you to see the most elegant solution -- in
> particular, one that you'd be willing to integrate into the package,
> once I get it working and send in the files/patch.
> 
> Thanks!
> --Ken
> 
