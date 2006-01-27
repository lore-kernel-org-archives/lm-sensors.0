From: jim.cromie@gmail.com (Jim Cromie)
Date: Fri, 27 Jan 2006 06:05:36 +0000
Subject: [lm-sensors] [patch 2/2] hwmon: use superio_locks in pc87360
Message-Id: <43D9B830.4000007@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From:  Jim Cromie <jim.cromie at gmail.com>


This patch provides a proof-of-concept 1st use of superio_locks module.


Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>

---

$ diffstat diff.uselocks.alpha-hilock
 pc87360.c |   84 
++++++++++++++++++++++++++++++++++++++------------------------
 1 files changed, 52 insertions(+), 32 deletions(-)

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: diff.uselocks.alpha-hilock
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060127/45fb601e/diff.uselocks.pl
