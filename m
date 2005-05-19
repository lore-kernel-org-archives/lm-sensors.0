From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: lmsensors on Abit IC7-G
Message-Id: <20031119220617.7341e0de.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FB92482.2070306@langfeldt.net>
In-Reply-To: <3FB92482.2070306@langfeldt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> # i2cdump 0 0x2e
> (...)
> That's very negative isn't it :-)

Yes it is. I don't know what it is, but this is no LM80 for sure. We
would need to enhance our detection routine so that doesn't fall in that
kind of trap.

I'm curious. If you dump the chip again now, does it contain exactly the
same data or not?

According to MBM's site, the monitoring chip on your motherboard is a 
W83627HF. They also have that note: "select your board from the
installer to avoid problems". It could mean that there is some special
action to take before being able to access the chip.

Could you provide the full output of sensors-detect (CVS version if
possible)?
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-detect

If it doesn't show that chipset, we'll have to ask Alex (MBM's author)
how he has been solving the problem.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
