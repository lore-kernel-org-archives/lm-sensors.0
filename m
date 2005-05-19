From: ladis@linux-mips.org (Ladislav Michl)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: [2.6 patch] 2.6.10-mm2: let I2C_ALGO_SGI depend on MIPS
Message-Id: <20050107091218.GA3715@orphique>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050106002240.00ac4611.akpm@osdl.org> <20050106181519.GG3096@stusta.de> <20050106192701.GA13955@linux-mips.org> <41DD9313.4030105@total-knowledge.com> <20050106194646.GB5481@kroah.com>
In-Reply-To: <20050106194646.GB5481@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: "Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>, Ralf Baechle <ralf@linux-mips.org>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com, linux-mips@linux-mips.org

On Thu, Jan 06, 2005 at 11:46:46AM -0800, Greg KH wrote:
> Ok, can someone send me the proper patch then?

Index: drivers/i2c/algos/Kconfig
=================================RCS file: /home/cvs/linux/drivers/i2c/algos/Kconfig,v
retrieving revision 1.3
diff -u -r1.3 Kconfig
--- drivers/i2c/algos/Kconfig	24 Aug 2004 15:10:09 -0000	1.3
+++ drivers/i2c/algos/Kconfig	7 Jan 2005 09:10:10 -0000
@@ -61,7 +61,7 @@
 
 config I2C_ALGO_SGI
 	tristate "I2C SGI interfaces"
-	depends on I2C
+	depends on I2C && (SGI_IP22 || SGI_IP32 || X86_VISWS)
 	help
 	  Supports the SGI interfaces like the ones found on SGI Indy VINO
 	  or SGI O2 MACE.
