From: jim.cromie@gmail.com (Jim Cromie)
Date: Mon, 21 Aug 2006 02:59:26 +0000
Subject: [lm-sensors] [patch 1/3] hwmon/pc87360: take maintenance
Message-Id: <44E9218E.4010607@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

1. hwmon-pc87360-maintainer.patch
    the bribe, as it were.
    thanks for authoring this driver Jean.

Signed-off-by:  Jim Cromie  <jim.cromie at gmail.com>


[jimc at harpo pc-set]$ diffstat hwmon-pc87360-maintainer.patch
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+)

--

diff -ruNp -X dontdiff -X exclude-diffs ad-0/MAINTAINERS ad-1/MAINTAINERS
--- ad-0/MAINTAINERS	2006-08-13 08:38:53.000000000 -0600
+++ ad-1/MAINTAINERS	2006-08-20 16:04:03.000000000 -0600
@@ -2257,6 +2257,12 @@ T:	git kernel.org:/pub/scm/linux/kernel/
 T:	cvs cvs.parisc-linux.org:/var/cvs/linux-2.6
 S:	Maintained
 
+PC87360 HARDWARE MONITOR DRIVER
+P:	Jim Cromie
+M:	jim.cromie at gmail.com
+L:	lm-sensors at lm-sensors.org
+S:	Maintained
+
 PCI ERROR RECOVERY
 P:	Linas Vepstas
 M:	linas at austin.ibm.com



