From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: tickets needing help
Message-Id: <20040104190845.GD30841@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FF64825.9060808@verizon.net>
In-Reply-To: <3FF64825.9060808@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Mark D. Studebaker <mds4@verizon.net> [2004-01-02 23:42:13 -0500]:
> > 1506 - asb100 detection - Mark?

OK.  I'll look at this one today.

> > 1499 - i2c-sis645 renamed to i2c-sis96x in kernel 2.6, any way we can
> > handle this in sensors-detect? Khali or other perl guy?

* Jean Delvare <khali@linux-fr.org> [2004-01-03 11:07:17 +0100]:
> For #1499, wouldn't listing both devices be sufficent? Well, the system
> would complain about not finding one of the modules, but that left
> apart, would it work or not? I can implement what you want in
> sensors-detect, but I don't know much about i2c-sis*. I think I remember
> MMH telling me there was some kind of trick there.

Yeah we discussed it briefly over IRC...

To really do it properly, it needs to be aware of 2.4 vs. 2.6, due to
the fact that the ridiculous PCI device unhiding happens at driver load
in the former, at bootup in the latter.

I.e. if we only had 2.6 to worry about, i2c-sis96x would have a single
PCI device entry in the table and detection would be nice and generic
like all the rest.

Instead, what I should do is yank all the sis96x and sis5595 entries
(because that misdetects all 96x) out of that table and write a special-
purpose function for detecting them properly.

I'm not a perl wizard (in fact I dislike perl) so I'm inclined to just
list both devices and attack the rest later, if ever.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
