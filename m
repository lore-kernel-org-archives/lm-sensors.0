From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: Call for 2.6.3 soon
Message-Id: <3C6E8EFC.C0028700@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It's been 3 months and the changelog is getting long.
I'm not aware of anything pending.
Let's target the last week of this month for a release.
Any objections or pending submissions please let everyone know.

Because we did not have any dependencies from lm-sensors 2.6.2
on i2c-2.6.2, our users did not have to patch their kernel
if they were at 2.4.13 or higher, and we have seen
_much_ less installation problems in the last 3 months. 

We've kept the same
dependency (i2c-2.6.1 or kernel-2.4.13) so hopefully 
this will be another smooth one.

mds
