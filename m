From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: remove 2.2 support?
Message-Id: <3E0E709B.5000900@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

testing and fixing 2.2 support was a real pain at the end of the 2.7.0 cycle.
It also adds a lot of cruft in the drivers and adds to patch misery.
What do you think of removing 2.2 support and making 2.7.0 the last 2.2-compatible release?
For reference, we dropped 2.0 support in release 2.5.0, March 2000.
mds
