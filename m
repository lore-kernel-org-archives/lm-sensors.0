From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <20040114033627.GL894@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2004-01-11 21:14:40 +0100]:
> > Well, as stated above, you have to write 4 to the fan status register,
> > which will in turn clear bit 2 of the fan status register. If no more
> > fan status registers indicate a fan failure, the 'Global fan fault
> > event' will clear too (simple OR-logic, as you mentioned above).
> 
> Writing a 1 to the bit so that it is reset is a strange idea, isn't it?
> ;)

Just in case you were not entirely joking...

This is a common idiom for h/w status registers:  write '1' to reset
and write '0' is ignored.  This allows you to clear a single status
bit without needing a read-modify-write, i.e. you'll not accidentally
clear a status bit that was set just before your write.

For sticky-status bitfields in sysfs, this idiom is still appropriate.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
