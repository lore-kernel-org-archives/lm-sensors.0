From: Bruce@Ivn.cl (Ivan Barrera A.)
Date: Wed, 07 Jun 2006 21:21:14 +0000
Subject: [lm-sensors] LM Sensors Autoconfig Tool - Database aspects
Message-Id: <4487434A.4070009@Ivn.cl>
List-Id: <lm-sensors.vger.kernel.org>
References: <44862F5D.6090404@gmail.com>
In-Reply-To: <44862F5D.6090404@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> 
> Do we have different motherboard revisions which are so different that
> the revison matters for sensors.conf, or do you want to know this so
> that the autoconfig tool will correctly identify all revisions?
> 

A few ones does.
I had once in my power 2 revisions, that had differents sensors config.
(However, this were old mb)


> --- end of reply ---
> 
> My own idea for being able to configure motherboards with a broken (or
> no) dmi table was to actually use the motherboard. In my memory dos
> tools were able to provide all kinda info on the bios, like version
> string, etc. Often the version string contains the mobo model. Anyone
> know how these dos tools did this (are these strings at a fixed memory
> location, or was it a dos int?).
> 
> I'm thinking about a tool which memmaps /dev/mem at 0xf0000 - 0xfffff
> where the bios is and making a hexdump to see if I can dig up any
> interesting info there which could help us identifying the mainboard.
> 
> Now modern bioses are bigger then the 64k window at 0xf0000 - 0xfffff
> does anyone know how one gets to the rest of the bios? (a bios checksum
> might nbe another way to identify mainboards, yes I know we will have
> problems with multiple bios versions).

I was also looking into this.
Even most bioses says the mainboard version/revision at the bottom of
the screen usually (i.e. award)

i think, using a combinatory of dmidecode for individual detection of
sensors/mainboard, and using some other tools/complements.

I'll work on some of the ideas, to see which ones are more effective.
Although, i dont think the first implementation has got to be the
deffinite one. This month i want to have a basic but working system, and
the next one, improve it a lot.
I dont pretend to dish the project after SoC either, so as we can get
more info to detect mainboards, better.

I'll take a look onto this DOS tools. Or perhaps disasm some of these
"flash" utilities could help to get where to read......
Well, thanks a lot for the welcomes, and ideas :)

The most, the more thanks.

Greeeeetings






> 
> Regards,
> 
> Hans
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


