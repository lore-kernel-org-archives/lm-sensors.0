From: trini@kernel.crashing.org (Tom Rini)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: Problems with Tyan Thunder LE-T
Message-Id: <20031212151432.GG668@mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.50.0312052212300.7299-100000@trottelkunde.amd.co.at>
In-Reply-To: <Pine.LNX.4.50.0312052212300.7299-100000@trottelkunde.amd.co.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Dec 10, 2003 at 10:50:53AM -0700, Tom Rini wrote:

> On Tue, Dec 09, 2003 at 01:58:40PM +0100, Michael Renner wrote:
> 
> > 
> > 
> > On Sat, 6 Dec 2003, Jean Delvare wrote:
> > 
> > > > I was trying to get I2C/lm_sensors running on one of our "refurbished"
> > > > servers, but ran into freezes while loading the i2c-piix driver.
> > >
> > > Get an updated lm_sensors2 from CVS and it should work OK. Sorry for the
> > > trouble.
> > 
> > Hi Jean, Tom!
> > 
> > Thanks for your fast reply, everything works fine now (using 'todays'
> > cvs).
> > 
> > The only thing left is the following message I get when loading
> > the i2c-piix4 module:
> > 
> > Found ServerWorks OSB4 South Bridge device
> > dmi_scan.o version 2.8.1 (20031005)
> > dmi_scan.o: SM BIOS found
> > i2c-piix4.o: Unusual config register value (0x03)
> > i2c-piix4.o: Please report!
> 
> Thanks.

Ok.  Adding further to the confusion of this problem is that the Force
CPCI-735 (which is the board with the problem) has the same value.  So I
would like to propose the following patch:
Index: kernel/busses/i2c-piix4.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-piix4.c,v
retrieving revision 1.60
diff -u -u -r1.60 i2c-piix4.c
--- kernel/busses/i2c-piix4.c	6 Dec 2003 21:48:32 -0000	1.60
+++ kernel/busses/i2c-piix4.c	12 Dec 2003 15:44:22 -0000
@@ -193,9 +193,8 @@
 			temp &= 0xfd;
 			pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp);
 		} else {
-			printk(KERN_INFO "i2c-piix4.o: Unusual config register value "
-			       "(0x%02x)\n", temp);
-			printk(KERN_INFO "i2c-piix4.o: Please report!\n");
+			printk(KERN_INFO "i2c-piix4.o: Unusual config register value\n");
+			printk(KERN_INFO "If i2c does not work for you, try using fix_hstcfg=1\n");
 		}
 	}
 
-- 
Tom Rini
http://gate.crashing.org/~trini/
