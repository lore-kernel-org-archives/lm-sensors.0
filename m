From: Joe Perches <joe@perches.com>
Date: Thu, 20 Jun 2013 16:20:27 +0000
Subject: [lm-sensors] [PATCH] MAINTAINERS: Remove Hans J. Koch entries
Message-Id: <1371745227.2146.13.camel@joe-AO722>
List-Id: <lm-sensors.vger.kernel.org>
References: <086bdaf83fe546bd3c7fe163e565a0887770770f.1369317710.git.michal.simek@xilinx.com>
	 <71c482e15ee32fa304db73b984f6d5a63441cd92.1369317710.git.michal.simek@xilinx.com>
	 <51A5E644.1040901@monstr.eu> <51AC8D43.100@monstr.eu>
	 <20130603210513.GA22606@kroah.com>
	 <20130620160126.GB22115@amd.pavel.ucw.cz>
In-Reply-To: <20130620160126.GB22115@amd.pavel.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Simek <monstr@monstr.eu>, "Hans J. Koch" <hjk@hansjkoch.de>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Thu, 2013-06-20 at 18:01 +0200, Pavel Machek wrote:
> Anyway, Hans disappeared, so Greg takes patches, again.

Maybe this is appropriate then.

Signed-off-by: Joe Perches <joe@perches.com>
---
diff --git a/MAINTAINERS b/MAINTAINERS
index 69fea4f..dc9d04a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5253,9 +5253,8 @@ F:	Documentation/hwmon/max16065
 F:	drivers/hwmon/max16065.c
 
 MAX6650 HARDWARE MONITOR AND FAN CONTROLLER DRIVER
-M:	"Hans J. Koch" <hjk@hansjkoch.de>
 L:	lm-sensors@lm-sensors.org
-S:	Maintained
+S:	Orphan
 F:	Documentation/hwmon/max6650
 F:	drivers/hwmon/max6650.c
 
@@ -8795,7 +8794,6 @@ F:	fs/hostfs/
 F:	fs/hppfs/
 
 USERSPACE I/O (UIO)
-M:	"Hans J. Koch" <hjk@hansjkoch.de>
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 S:	Maintained
 F:	Documentation/DocBook/uio-howto.tmpl



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
