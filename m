From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 03 Nov 2013 19:37:19 +0000
Subject: Re: [lm-sensors] w83795.c no longer compiles
Message-Id: <20131103203719.0aa4f98a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <5273CD89.6030803@gmail.com>
In-Reply-To: <5273CD89.6030803@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David, Guenter,

On Sat, 02 Nov 2013 10:16:28 -0700, David Anderson wrote:
> On 11/01/2013 02:09 PM, Guenter Roeck wrote:
> > On Fri, Nov 01, 2013 at 08:49:29AM -0700, David Anderson wrote:
> >> Just installed the new Ubuntu 13.10.   Kernel 3.11.0-12 #19.
> >> I get an error building w83795.c (building a module to read
> >> my  w83795adg temp sensor) for this kernel.
> > SENSORS_LIMIT no longer exists; replace it with clamp_val.
> >
> > Is the driver in the upstream kernel different to the version above ?
> 
> Yes.  Different, I now see.
> 
> I picked up
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> and the upstream w83795.c had changes.  I built a module
> on the target machine using
> the upstream w83795.c  ---- it compiles with no warnings and
> the new module is working fine in my kernel.
> 
> Honestly, it would not have occurred to me  look for the latest
> or try building latest w83795.c !

The drivers in http://khali.linux-fr.org/devel/lm-sensors/drivers/ are
all snapshots of the respective upstream driver at some point in time,
to which I added some compatibility glue so that it build for a range
of older kernels. I update them manually as my time permits and needs
arise, which means that they are all lagging behind most of the time,
by construct.

For example, "my" w83795 driver is currently based on the upstream
driver from kernel 2.6.36.1 (doh, this is so old) with enough
compatibility glue to work with kernels down to 2.6.27.

In most cases, this shouldn't be a problem, because if you're running a
very recent kernel, you shouldn't need to use a standalone driver in
the first place, the upstream driver should work just fine. Which
brings a question to David: why are you not just using the driver which
comes with your kernel?

In the case of the w83795 driver I admit it is about time to remove all
the dust because it's indeed very old...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
