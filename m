From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 11 Jun 2009 22:32:55 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add driver for VIA CPU core
Message-Id: <20090611153255.ba8d6c54.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090609083406.GE25316@prithivi.gnumonks.org>
	<loom.20090610T172830-164@post.gmane.org>
In-Reply-To: <loom.20090610T172830-164@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomaz Mertelj <tomaz.mertelj@guest.arnes.si>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Harald Welte <HaraldWelte@viatech.com>

On Wed, 10 Jun 2009 17:40:31 +0000 (UTC)
Tomaz Mertelj <tomaz.mertelj@guest.arnes.si> wrote:

> Harald Welte <HaraldWelte <at> viatech.com> writes:
> 
> > 
> > This is a driver for the on-die digital temperature sensor of
> > VIA's recent CPU models.
> > 
> > Signed-off-by: Harald Welte <HaraldWelte <at> viatech.com>
> > 
> 
> Harald,

You carefully removed Harald from Cc: so he probably didn't read your
email.

> I tested it on 2.6.28.3 kernel on VIA VB7002 motherboard and it does not work 
> correctly.
> 
> Output form sensors:
> 
> via-cputemp-isa-0000
> Adapter: ISA adapter
> Core 0:       +0.0 C
> 
> On the other hand 
> cat '/sys/class/hwmon/hwmon2/device/driver/via-cputemp.0/temp1_input' outputs 
> numbers between 25-27. 
> 

Thanks for testing it.

Harald, please cc myself on updates to this patch.

<looks quickly at the patch>

It has a few trivial coding-style glitches.  Please use checkpatch.

Please take a look at using hotcpu_notifier() rather than a bare
register_hotcpu_notifier().  Many ifdefs should fall away as a result.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
