From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: Linux 2.6 and CONFIG_ISA
Message-Id: <20040116214618.GE2530@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1074005072.400404506dd11@imp.gcu.info>
In-Reply-To: <1074005072.400404506dd11@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jan 16, 2004 at 10:43:27AM +0100, Jean Delvare wrote:
> Quoting Greg KH <greg@kroah.com>:
> 
> > I just too the requirement for CONFIG_ISA off of i2c-isa so that
> > x86_64 users can use that driver.  We might want to consider a rename
> > of the driver in the future...
> 
> I am not sure I understand your sentence ;)

I took the CONFIG_ISA dependancy off of CONFIG_I2C_ISA as seen in the
following patch.

thanks,

greg k-h


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Fri Jan 16 13:45:53 2004
+++ b/drivers/i2c/busses/Kconfig	Fri Jan 16 13:45:53 2004
@@ -108,7 +108,7 @@
 
 config I2C_ISA
 	tristate "ISA Bus support"
-	depends on I2C && ISA && EXPERIMENTAL
+	depends on I2C && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for i2c
 	  interfaces that are on the ISA bus.
