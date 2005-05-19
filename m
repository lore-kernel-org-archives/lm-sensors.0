From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.6] Autoselect i2c algos
Message-Id: <20040119210514.GE4407@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040118230033.07539111.khali@linux-fr.org>
In-Reply-To: <20040118230033.07539111.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 18, 2004 at 11:00:33PM +0100, Jean Delvare wrote:
> > > BTW, wouldn't it make sense to apply the same idea to i2c
> > > algorithms?
> > 
> > Yes it would.  Care to make a patch?
> 
> Ahahah I love it when you do that ;))
> 
> Here you go. I replaced all dependancies on algos with dependancies on
> I2C + select algo. There are some cases outside of the i2c subdirectory.
> 
> Also note that I slightly altered the condition to display the PCILynx
> comment. I added PCI to the dependencies, I think it's more logical that
> way. Without it, the user could get the message he/she needs I2C, go to
> enable it, come back and still not see the option.

I took out your dependancy on PCI you added to the PCILynx driver.
That's up to the ieee1394 people to determine :)

I applied that patch, and then had to add the following change to keep
us from trying to build MIPS specific code.

thanks,

greg k-h


# I2C: only select I2C_ITE if we are a MIPS system

diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Jan 19 13:03:15 2004
+++ b/drivers/i2c/busses/Kconfig	Mon Jan 19 13:03:15 2004
@@ -122,7 +122,7 @@
 
 config I2C_ITE
 	tristate "ITE I2C Adapter"
-	depends on I2C
+	depends on I2C && MIPS_ITE8172
 	select I2C_ALGOITE
 	help
 	  This supports the ITE8172 I2C peripheral found on some MIPS
