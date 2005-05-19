From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:11 +0000
Subject: W83L785TS-S
Message-Id: <20030809120646.541e35a3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all,

Looks like a W83L785TS-S driver would be welcome. I could write it
(well, as usual, when I find some time to). I've read the datasheet and
it looks like a very simple one temperature only chip. However,
Winbond's datasheet is (as usual it seems) written in a very
approximative english so I'm not sure I understand everything, and it'll
be hard to make sure the driver is working OK without actually having
the hardware.

In particular, I hardly can figure out what we're supposed to do with
the values in registers 0x53 and 0x85. If I understand it correctly,
their values are latched at powerup, and are used to correct the
readings and configure the limit. So they should be write only (as VID
is, for example) but are said to be R/W. Are we supposed to use these
registers values to correct the value at 0x27, or is it *already*
corrected? Such an uninformative datasheet is just awful :(

I think I'll ask Alex (again) if he has some clue.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
