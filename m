From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: i2c-sis645.c patch (Experimental SiS 655 support)
Message-Id: <20040407011939.GB6289@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <4063CA9F@webmail.ucc.ie>
In-Reply-To: <4063CA9F@webmail.ucc.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ken, Mark...

* Mark D. Studebaker <mds4@verizon.net> [2004-04-06 19:57:02 -0400]:
> the i2c-sis96x driver doesn't have a list of PCI ID's so a 'similar patch'
> isn't possible. MMH does anything need to change in 2.6 for this new chip?

Nope, it should work fine as it is.  The 2.6 kernel checks for any SiS PCI id
madness at boot time and fixes it (long before the i2c-sis96x driver inits).

However, sensors-detect needs the patch which I just committed.  Ken, could
you please test that?

Thanks and regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
