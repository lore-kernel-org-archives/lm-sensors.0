From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: udelay(500) in amd8111 and nforce2
Message-Id: <3FC94B6F.FA363E5E@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is definitely no good.
The preferred implementation is #if'ed out in nforce2.
Does somebody have these chips to test the fix or
should we just change it w/o testing first?
