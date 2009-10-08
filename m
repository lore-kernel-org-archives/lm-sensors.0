From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 08 Oct 2009 20:02:15 +0000
Subject: Re: [lm-sensors] [Module] hwmon: GM/GME965 GM45 and more chips IGP
Message-Id: <20091008220215.3e18f760@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <73511e6c0907180440p43b81f33x85c4dc70007165b3@mail.gmail.com>
In-Reply-To: <73511e6c0907180440p43b81f33x85c4dc70007165b3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Lu,

On Sat, 18 Jul 2009 11:40:36 +0000, Lu Zhihe wrote:
> Dear all,
> 
>     Attachment is the updated version gm965temp module and patched
> "sensors-detect.gm965temp".
>     For some reasons about safe consideration, gm965temp is not
> considered to merge to hwmon subsystem.
>     So, it is packaged as external module.

Can you please elaborate about it? Don't you ever plan to get your
driver included in the kernel tree?

If your driver won't ever be merged, I admit I am not interested in
reviewing it. If the plan is to merge it, then I will review it.

>     Now, it supported:
>     PM/GM/GME965, PM/GM45(need tester :-). These chips read temp from
> register TR1/RTR1 .
> 
>     Following Chip sets:
>     G33/Q33/Q35 G41 G43/Q43 G45/Q45,
>     B43_BASE and B43_SOFT_SKU.
>     They all need testers!                      These chips read temp
> from register TSTTP.RELT .
> 
>     Thanks for Tobias Hain helping me test gm965temp.
> 
>     Hope someone can help to test it too, thank you very much!

I can't test your code, I do not have any supporter piece of hardware,
sorry.

I've looked at the intel-agp driver, which binds to the same PCI
devices. It's way too big and complex to resort to the same hack we
have in sis5595 and i2c-sis5595 for example. The intel-agp driver must
remain a "real" pci driver which binds to its devices, in particular so
that power management works OK.

This leaves us with 3 alternatives.

1* Add hwmon support to the intel-agp driver directly. As this driver
   is already somewhat big (77 kB) it would probably go unnoticed. The
   hwmon part in your driver is probably about 350 lines of code.

2* Implement hwmon as a separate module, simply use pci_get_dev()
   during initialization of that module, and if a device is found,
   register a platform driver and instantiate a platform device for the
   hwmon part. This is essentially what your implementation does,
   except that your module registers the platform driver and device
   regardless of the presence of a supported chip, which is bad.

3* Let intel-agp instantiate the platform device for hwmon, and only
   register the driver in the separate module. This avoid some code
   duplication, and we can have the hwmon module auto-load. Maybe the
   best compromise code-wise, but possibly somewhat more difficult to
   maintain.

Note that driver auto-loading should also work with option #2, although
your implementation doesn't do it. It shouldn't be too hard to add.

I don't have a strong opinion between these 3 choices, but I want the
driver to auto-load as needed.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
