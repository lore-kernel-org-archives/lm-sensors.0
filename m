From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Donation.
Message-Id: <20031028235512.612ea9ea.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <F7CB408531C5264680C9E37DE4FE71A4088FDF@limkexm2.ad.analog.com>
In-Reply-To: <F7CB408531C5264680C9E37DE4FE71A4088FDF@limkexm2.ad.analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Yeah, don't be afraid to do a little soldering to hack something up.  
> Here's an old page I made with my experience w/ an AD eval board:
> 
> http://secure.netroedge.com/~lm78/hardhack.html
> 
> You might need to use an old DIMM to tap into the SMBus & power, or
> you might be lucky enough to have some jumpers on the mobo which make
> it easy to tap into these things.

Common Phil, I'm not that crazy! ;) If you consider that 1) I don't want
to sacrifice the brand new evaluation board Sean kindly sent to me 2) I
don't wan't to sacrifice my own computer hardware 3) I don't have tools
for doing electronics here 4) I'm not particularily competent when it
comes to soldering and 5) The evaluation board works through the
parallel port under Windows, so it has to work under Linux too, you'll
understand that what I am requesting is a software solution, not a
hardware tinkering guide (although your page is quite impressive, I
admit).

Either one of our modules can be easily adapted to handle the evaluation
board, or I'll write one, providing Sean can explain to me how to do
that. I guess it's a simple problem of writing the right things at the
right time on the parallel port. Sean, are the SCL and SDA lines handled
by the software and transmitted to the eval board through the parallel
port, or are these signals generated on the board itself and simply
controlled by the parallel port?

BTW, I tried our i2c-pcf-epp module and it led me to a kernel panic :( I
guess that it isn't supposed to happen, even if the module doesn't
recognize the hardware. How may I investigate and fix the problem?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
