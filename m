From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: Question about libsensors
Message-Id: <20040219030843.GG21829@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200402061628.06801.renier@morales-rodriguez.net>
In-Reply-To: <200402061628.06801.renier@morales-rodriguez.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(cc Frodo on purpose)

* Renier Morales Rodriguez <renier@morales-rodriguez.net> [2004-02-06 16:28:06 -0500]:
> Hi,
> I'm interested in writing a plugin for the OpenHPI project 
> (http://openhpi.sourceforge.net) that supports lm sensors.
> I would like to make use of libsensors for this, but saw that it is under the 
> GPL, while OpenHPI is under BSD. Is it at all possible to make use of 
> libsensors under the LGPL.

You probably saw at the bottom of the lm_sensors README...

> Note that at this moment, libsensors falls under the GPL, not the LGPL.
> In more human language, that means it is FORBIDDEN to link any application
> to the library, even to the shared version, if the application itself
> does not fall under the GPL. This will probably be changed in the future.
> In the meantime, you will have to contact us first if you want to do this.

AFAIK, it would take all the copyright holders to agree to allow this, but
just one of them could veto it.  I don't claim to hold any rights to that
library myself (all my patches to it have been small).

So, it's up to the original authors... Phil, Frodo, MDS, are there others?

And to be sure, silence in this case is as good as a veto.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
