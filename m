From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 07 Sep 2006 12:07:14 +0000
Subject: [lm-sensors] regression test script for sensors output
Message-Id: <20060907120714.GC11807@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <44F72B6D.4050207@gmail.com>
In-Reply-To: <44F72B6D.4050207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim:

* Jim Cromie <jim.cromie at gmail.com> [2006-08-31 12:33:17 -0600]:
> 
> attached script reads `sensors` output, compares to file content
> (which should contain sensors output from baseline driver, before you hack)

Hey, thanks for doing that - it will be useful.

Do you have any experience with these Perl modules... ?

	test::cmd
	test::simple
	test::harness

I'm working up a regression test for the libsensors config file scanner.  At
the moment, Perl with those modules looks like an easy but flexible way to
organize it.  By contrast, Dejagnu is extreme overkill.  Are there any other
mechanisms I should consider?

Thanks & regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


