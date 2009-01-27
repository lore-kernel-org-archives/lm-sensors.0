From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 27 Jan 2009 09:44:00 +0000
Subject: Re: [lm-sensors] Compaq Evo D51S hidden sensor
Message-Id: <20090127104400.6abc016b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU145-W35B82847EBE241F19D2D21B8DC0@phx.gbl>
In-Reply-To: <BLU145-W35B82847EBE241F19D2D21B8DC0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

Sorry for the late answer, busy busy busy...

On Sat, 17 Jan 2009 21:45:48 +1000, David O'Shea wrote:
> > Yes, that makes sense. Maybe there's an option in the BIOS to forcibly
> > enable the on-board video controller to stay visible. But most likely
> > it is hidden automatically and you can't work around it. Just check in
> > the BIOS if you can find any option controlling this behavior.
> 
> I couldn't find any relevant option in the BIOS (otherwise there was
> one there showing the onboard VGA enabled!) but the Hardware Reference
> Guide states "The monitor connector on the system board is inactive if
> an AGP expansion card is installed in the computer."

OK, that's pretty clear.

> > You are correct, we used this device as a mean to detect these
> > machines, but another device could do as well. What matters is to find
> > a device with subvendor and subdevice values properly defined. Both the
> > IDE and the USB controllers meet this condition as far as I can see. I
> > think I'd use IDE. If you write a patch that does this and it fixes the
> > problem on your system, I'll be happy to review it and push it upstream..
> 
> It didn't work for me when I tried the IDE but did with the USB.  I think
> the USB is safe to use as I went into the BIOS and "disabled" the three USB
> IRQ options but my fix still worked and 'lspci' still showed the USB
> controllers.
> 
> To use the USB I need to add a #define, I assume the below would be the
> correct name for the value since there are corresponding _1 and _3
> #defines:
> 
> #define PCI_DEVICE_ID_INTEL_82801DB_2    0x24c2

Yes, that would be it.

> The fact that it didn't work with the IDE could just be because I'm so
> clueless!  Does the fact that the IDE controller has a function number
> other than 0 affect the way the DECLARE_PCI_FIXUP_HEADER() macro is used
> or what is passed to the hook function?  Even if not, if you think using
> the IDE is preferable I can have another try in case it didn't work due
> to a stupid mistake.

Yes, I would like you to try again with the IDE device, because there's
only one IDE device and 3 USB devices so using the IDE device should be
more efficient (quirk runs only once.)

No, the function number shouldn't play any role. I can't see any reason
why IDE wouldn't work.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
