From: akkana@shallowsky.com (Akkana)
Date: Thu, 19 May 2005 06:23:26 +0000
Subject: ticket 689, Soyo K7ADA and lm-sensors
Message-Id: <20011209210549.A7771@shallowsky.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm having the same problem as is described in ticket #689,
http://www.netroedge.com/~lm78/readticket.cgi?ticketh9 --
I also have a Soyo K7ADA motherboard, lm-sensors sees an
lm78 chip, but when I try to modprobe lm78, I get an audible
tone that won't go away and I have to shut the machine down.
I've gone over my board trying to figure out what chip it uses,
and I can't find anything that explicitly says "lm78" but can't
find anything with a similar name either (sorry, I'm not that
experienced with hardware and don't know how to recognize a sensor
chip when I see one -- any hints?)  I've scoured the net and Soyo's
various web sites looking for information on what chip it actually
uses, but haven't found any information.

I see that the ticket was closed; I'm wondering whether a solution
was ever found?  

I'm having frequent sporadic glitches of various sorts (not seeing
disks, crashing or rebooting in the middle of long compiles) and I'm
very eager to find some way of monitoring the CPU temperature to see
what the problem is.  I'm trying to figure out whether I should buy
a different motherboard (anyone have any recommendations for an Athlon
XP/DDR motherboard that works well with Linux, lm-sensors and ACPI?)
or if the problems are elsewhere.

Thanks very much for any help!

	...Akkana
