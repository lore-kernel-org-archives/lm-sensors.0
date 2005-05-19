From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: Which branch to work?
Message-Id: <20030116222611.C8619@earth.solarsys.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello everyone:

I want to add some code to i2c-sis645.c to support the
multiple recent requests we've had.  So let me make
sure I understand how we want to do this...

a) I should work from HEAD, and then merge my stuff
back to the 2.4 branch, or

b) I should work the 2.4 branch and merge it up to
HEAD.

I think (a) is what we want, but I thought I'd check first.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
