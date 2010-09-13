From: "Jan Beulich" <JBeulich@novell.com>
Date: Mon, 13 Sep 2010 10:28:35 +0000
Subject: [lm-sensors] [PATCH] x86/hwmon: cosmetic cleanup for coretemp
Message-Id: <4C8E18F30200007800015AFA@vpn.id2.novell.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fenghua.yu@intel.com, khali@linux-fr.org
Cc: r.marek@assembler.cz, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

"break" after "return" is at best bogus (good compilers even warn about
the "break" being unreachable).

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Cc: Rudolf Marek <r.marek@assembler.cz>

---
 drivers/hwmon/coretemp.c |    2 --
 1 file changed, 2 deletions(-)

--- linux-2.6.36-rc4/drivers/hwmon/coretemp.c	2010-09-13 08:45:02.000000000 +0200
+++ 2.6.36-rc4-x86-coretemp-cosmetic/drivers/hwmon/coretemp.c	2010-09-03 17:54:14.000000000 +0200
@@ -279,11 +279,9 @@ static int __devinit get_tjmax(struct cp
 	case 0x1a:
 		dev_warn(dev, "TjMax is assumed as 100 C!\n");
 		return 100000;
-		break;
 	case 0x17:
 	case 0x1c:		/* Atom CPUs */
 		return adjust_tjmax(c, id, dev);
-		break;
 	default:
 		dev_warn(dev, "CPU (model=0x%x) is not supported yet,"
 			" using default TjMax of 100C.\n", c->x86_model);




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
