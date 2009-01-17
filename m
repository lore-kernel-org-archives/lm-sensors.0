From: "David O'Shea" <dcoshea@hotmail.com>
Date: Sat, 17 Jan 2009 11:45:48 +0000
Subject: Re: [lm-sensors] Compaq Evo D51S hidden sensor
Message-Id: <BLU145-W373A4AEE01BFE8091378CAB8D50@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU145-W35B82847EBE241F19D2D21B8DC0@phx.gbl>
In-Reply-To: <BLU145-W35B82847EBE241F19D2D21B8DC0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Jean,

Thanks for your response!  Please see below

> Date: Sat, 10 Jan 2009 22:34:37 +0100
> From: khali@linux-fr.org
>

>> I'm using an AGP card I added to the PC instead of the on-board video. I am assuming that the on-board video is not appearing because I added the AGP card - would that be a normal thing to happen?
>
> Yes, that makes sense. Maybe there's an option in the BIOS to forcibly
> enable the on-board video controller to stay visible. But most likely
> it is hidden automatically and you can't work around it. Just check in
> the BIOS if you can find any option controlling this behavior.

I couldn't find any relevant option in the BIOS (otherwise there was one there showing the onboard VGA enabled!) but the Hardware Reference Guide states "The monitor connector on the system board is inactive if an AGP expansion card is installed in the computer."

>> I am assuming that pci/quirks.c above just happens to check for the onboard video as a way to detect this model of PC and it could check for something else instead - would that be true? If so (and there's no other investigation that might be needed), is this likely to be "fixed"/enhanced anytime soon or should I try kernel hacking myself? I'm assuming I could add a check for the IDE or USB (I'll try and check the BIOS settings or documentation to see if one of these in particular can't be disabled and therefore would always be present).
>
> You are correct, we used this device as a mean to detect these
> machines, but another device could do as well. What matters is to find
> a device with subvendor and subdevice values properly defined. Both the
> IDE and the USB controllers meet this condition as far as I can see. I
> think I'd use IDE. If you write a patch that does this and it fixes the
> problem on your system, I'll be happy to review it and push it upstream.

It didn't work for me when I tried the IDE but did with the USB.  I think the USB is safe to use as I went into the BIOS and "disabled" the three USB IRQ options but my fix still worked and 'lspci' still showed the USB controllers.

To use the USB I need to add a #define, I assume the below would be the correct name for the value since there are corresponding _1 and _3 #defines:

#define PCI_DEVICE_ID_INTEL_82801DB_2    0x24c2

The fact that it didn't work with the IDE could just be because I'm so clueless!  Does the fact that the IDE controller has a function number other than 0 affect the way the DECLARE_PCI_FIXUP_HEADER() macro is used or what is passed to the hook function?  Even if not, if you think using the IDE is preferable I can have another try in case it didn't work due to a stupid mistake.

Thanks!
David

_________________________________________________________________
Holiday cheer from Messenger. Download free emoticons today!
http://livelife.ninemsn.com.au/article.aspx?idf9758 
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
