From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: Should drivers INIT? Was: Re: success on Asus P4S8X-X
Message-Id: <3E9A4F92.5090206@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

You know, perhaps it should be made a new recommendation/rule that drivers 
*not* initialize limits on chips by default.

I had a problem with the LM85 shutting down Margit's motherboard.  Other 
drivers have an init=0 option.

With the different VRM specs that are now out there it's even harder to set 
accurate defaults.

And if the BIOS *has* setup the chip, then when the driver "initializes" it, 
the user looses what are presumably good limits for the given motherboard.

Lastly, it would make the chip drivers smaller by a significant amount which 
seems to be a current focus of development [grin]...

:v)


> "set vrm 9.0" worked. thanks.
> now I have a better vid value :
> 
> VCore 1:   +1.58 V  (min =  +1.44 V, max =  +1.60 V)              
> [...]
> vid:      +1.525 V
> 
> I just can now ear a very short alarm signal trigered by the motherboard,
> after the module is loaded, and before "sensors -s" is launched. I can 
> live with that. I usually don't reboot very often :-)



