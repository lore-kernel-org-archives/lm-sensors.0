From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 09 Oct 2006 20:03:39 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors not working
Message-Id: <20061009220339.b467d1e9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <451FF905.60001@hal.saar.de>
In-Reply-To: <451FF905.60001@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi Jean,
> 
> Jean Delvare wrote:
> > Well hopefully this new version of the driver will just work. However,
> > be aware that, contrary to the previous version, I couldn't give a try
> > to this one, so you're the first tester. This means there could be a
> > couple sharp edges left, please let me know if you notice anything
> > wrong.
> >
> > The changes are essentially in the way the driver is registered, so
> > basically, if you are able to load, unload and reload the driver, and
> > everything still works, it's a good sign that the conversion is a
> > success. You should also see the reserved I/O region in /proc/ioports
> > as "pc87427 FMC".
> >
> > Please give it a try and report!
> >   
> 
> I tried it - i.e. I replaced pc87427.c in a copy of the directory
> containing the old pc87427.c
> But I regret to report a failure. I try to document the relevant things...

Is the attached version any better? I had forgotten to create the
"name" attribute file, and libsensors needs it. This is fixed now,
hopefully this is all that was missing.

> By the way, I found that sensors-detect now detects a PC87360:
> Found `Nat. Semi. PC87360 Super IO Fan Sensors'
>     (but not activated)
> If I try a 'modprobe pc87360' I get
> FATAL: Error inserting pc87360
> (/lib/modules/2.6.16-xen/kernel/drivers/hwmon/pc87360.ko): No such device
> pc87360: Device 0x09 not activated
> pc87360: No active logical device, module not inserted.
> 
> I don't know if it's somehow related. I think, it finds it at least
> since the snapshot you published recently. It definitely didn't
> recognize before.

I have seen the same of the test system I had access to. I know for
sure that there is no such chip on the board, this is a misdetection.
Just ignore it. I can't tell why you didn't see it before.

-- 
Jean Delvare
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: pc87427.c
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061009/46037df5/attachment-0001.c 
