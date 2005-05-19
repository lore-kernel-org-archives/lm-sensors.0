From: epm@cox.net (Eric P. McCoy)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: Asus P4B266-C
Message-Id: <20020503163713.6e51a644.epm@cox.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020503123913.C10198@Stimpy.netroedge.com>
In-Reply-To: <20020503123913.C10198@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, I'm trying to get the sensors to work correctly on my ASUS P4B266-C
motherboard.  I have read all the relevant information on the lm-sensors
web site, in particular the tweaks I need to make on the PCI bus and so
on.  Plus the option I need to pass to the w83781d module to get it to
recognize my chip.

So anyway, all that works mostly fine and produces useful output on the
temperature and so on.  The problem here is that it also enables the
goddamn beep-alarm and I _cannot_ get it to shut off without rebooting. 
It comes on the second I load the module and will not go off, even if I
unload the module.  I suspect the alarm is coming on because temp3 is
out of range, but that's because it isn't connected to anything - it
just displays 127C.  I edited sensors.conf to tell it to ignore temp3,
and that doesn't work: it omits display of that sensor, but doesn't stop
the beeping.  I turned off "beep_enable" and now sensors doesn't say
it's on any more, but that doesn't stop the beeping either.

The fan display is broken, and the fix detailed in the problem ticket
doesn't solve it, but I suspect that's a BIOS issue: according to ASUS,
versions 1001 and 1002 of this board's BIOS don't report the fan
correctly.  That may just be the BIOS display, though; I'm mentioning it
just in case it's relevant.  In any event, the only thing that displays
an "alarm" message is temp3.

I would unplug the speaker from the motherboard, but the beeping would
actually be a really useful feature if it worked correctly.  So I'd
rather get the problem fixed.

So is there anything I can do?  Or is this the limit of the
functionality I can expect for the time being?  I really would like
lm-sensors to work, because I hope to overclock this CPU and need to
watch the temperature to keep from overclocking it too far.  (It's not
overclocked ATM.)

Thanks, and kudos on the great work you've already done: everything
works flawlessly on my other two systems.

-- 
Eric McCoy (reverse "ten.xoc@mpe", mail to "ctr2sprt" is filtered)

"Last I checked, it wasn't the power cord for the Clue Generator that
was sticking up your ass."	- John Novak, rasfwrj
