From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: New sensors web site (was Re: 2nd mail archive?)
Message-Id: <20041215112305.GG18354@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <41BDF25A.9030509@edgedesign.us>
In-Reply-To: <41BDF25A.9030509@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

OK, I can arrange for lm-sensors.org with

o Web
o Mailman
o Wiki (which one?)
o CVS/subversion with viewcvs (and cvsgraph for cvs)
o Bugzilla

Migration of the list: Who has a complete archive? A modern approach
in naming/segmenting lists would be lm-sensors-users@lm-sensors.org
and lm-sensors-devel@lm-sensors.org. Is that in order?

Migration CVS to subversion would be quite easy (I need a copy of the
CVS repo). It is mainly up to the current developers, whether they'd
like to change the versioning system.

Migration of the ticket system to Bugzilla may be more
cumbersome. Someone with good bugzilla database knowledge would have
to check the current ticketing system and migrate it.

First one would have to decide on product/components schemes for
bugzilla. I believe that it will boil down to
products={lm_sensors,i2c} and components (for lm_sensors) being the
busses/chips.

Who wants to become
o list admin
o bugzilla admin
o wiki admin

Phil, I'm sure some of these tasks are reserved for you :)
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041215/267d0a55/attachment.bin
