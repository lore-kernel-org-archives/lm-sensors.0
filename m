From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: You guys rock!  (and other ticket #754 followups)
Message-Id: <3C17DD81.2B0E9F85@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3C13DCC1.9010108@eecs.berkeley.edu>
In-Reply-To: <3C13DCC1.9010108@eecs.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ben Liblit wrote:

> (2) Regarding misdetection of an lm80 chip, MDS wrote: "it?s something
> else, perhaps a winbond chip....  Look at your board, perhaps you can
> figure out what it is."
> 
> You helped me, so I'm inclined to help you make lm_sensors better by
> trying to answer this question.  When I look at my board, what exactly
> am I looking for?  A chip with the word "winbond" printed somewhere on
> it?  I suppose I could make a list of what's printed on each and every
> chip, then see if one of those is on your list of known sensor chips.
> But it would help if I had a better idea of what I'm looking for.
> 

I don't have any magic for how to figure out what chip you have.
Look at what we do support, check manufacturers websites
so you can recognize logos on the chips, look for numbers
similar to chips we do support, when you find part numbers
search the web to see what chip it is.
Ask your motherboard maker's support what chip it is also.


> (3) Regarding the requirement to load i2c-isa in order for via686a to
> work.  I guess that wiring in a forced dependency would only be
> appropriate if i2c-isa is *always* the *only* way that one communicates
> with that chip.  Is it?  Or are there sometimes ways to talk to it on a
> different bus?
>


for via686a and other isa-only chips, it's the only way.
But our package is so 'modular' that there's no dependency in the
code. Perhaps there should be a forced dependency for those chips.

Anybody on the list have an opinion?

 
> Anyway, I did want to note for the record how I established the
> dependency manually.  It's a bit different from the standard approach
> suggested at the end of sensors-detect, so I thought you might find it
> interesting....
> 
> The standard thing to do, which is probably what sensors-detect would
> suggest, would be to just "modload i2c-isa" followed by "modload
> via686a".  But that strikes me as inelegant for some reason.  I used a
> different strategy.  In "/etc/modules.conf", I added the line:
> 
>         add below via686a i2c-isa
> 
> This tells modprobe that the via686a module depends upon the i2c-isa
> module for some underlying functionality.  The "modules.conf" manual
> describes this as "an optimized case of the pre-install and post-remove
> directives."  Now I can just "modload via686a" and the "i2c-isa" module
> is loaded up.  I like this approach because it has a more declarative
> feel.  It just establishes the dependency, and lets someone else decide
> when to load up the sensor module.
> 
> In fact, that worked so well that I switched to it as the loading
> strategy for all (both) sensor modules.  Each sensor has a "below"
> dependency on the bus it uses:
> 
>         add below eeprom i2c-viapro
>         add below via686a i2c-isa
> 
> Then at machine boot time, I just "modprobe eeprom" and "modprobe
> via686a".  The sensor drivers will load up their required bus drivers
> automatically.

thanks for a description of another way to do it.
