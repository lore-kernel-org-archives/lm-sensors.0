From: Howard Chu <hyc@symas.com>
Date: Tue, 23 Sep 2008 20:39:36 +0000
Subject: [lm-sensors] AMD Family 11h thermal sensor
Message-Id: <48D95408.2010804@symas.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The newer AMD X2 Turion (and other) processors appear to have the same thermal 
monitoring capability as K10, but the PCI device IDs for the Northbridge have 
changed. (1022:1303)

I added the new ID to the K10 code posted here
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022909.html
and it seems to be working.

See document 41256 here
http://www.amd.com/us-en/Processors/TechnicalResources/0,,30_182_739_13906,00.html

and compare section 2.10 Thermal Functions to the same text in the K10 doc 
31116 here
http://www.amd.com/us-en/Processors/TechnicalResources/0,,30_182_739_15343,00.html

-- 
   -- Howard Chu
   CTO, Symas Corp.           http://www.symas.com
   Director, Highland Sun     http://highlandsun.com/hyc/
   Chief Architect, OpenLDAP  http://www.openldap.org/project/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
