From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: tickets needing help
Message-Id: <20040106050118.GJ30841@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FF64825.9060808@verizon.net>
In-Reply-To: <3FF64825.9060808@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2004-01-04 21:19:33 +0100]:
> > To really do it properly, it needs to be aware of 2.4 vs. 2.6, due to
> > the fact that the ridiculous PCI device unhiding happens at driver
> > load in the former, at bootup in the latter.
> > 
> > I.e. if we only had 2.6 to worry about, i2c-sis96x would have a single
> > PCI device entry in the table and detection would be nice and generic
> > like all the rest.
> > 
> > Instead, what I should do is yank all the sis96x and sis5595 entries
> > (because that misdetects all 96x) out of that table and write a
> > special- purpose function for detecting them properly.
> > 
> > I'm not a perl wizard (in fact I dislike perl) so I'm inclined to just
> > list both devices and attack the rest later, if ever.
> 
> If you provide the data and explain to me what I should do with them, I
> can do the work for you. I'm not a perl wizard either, but in fact I
> like perl pretty much ;)

Thanks!

in pseudo code; indentation matters...

if kernel is 2.6.x
	if 1039:0016 is present
		use i2c-sis96x
	else if 1039:0008 is present
		use i2c-sis5595
	else
		(none)
else if kernel is 2.4.x
	if 1039:0008 is present
		if (1039:0645 or 1039:0646 or \
		1039:648 or 1039:0650 or \
		1039:651 or 1039:0735 or \
		1039:745 or 1039:0746) is present
			use i2c-sis645
		else
			use i2c-sis5595
	else if 1039:0016 is present
		use i2c-sis645
	else if 1039:0018 is present
		use i2c-sis645
	else
		(none)

Also, I think, any SiS device ID which does not appear in the above
function should stay just as it is in the table... because I can't
confirm what IDs are on those systems.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
