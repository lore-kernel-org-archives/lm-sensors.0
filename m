From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: w83781d i2c driver updated for 2.5.66 (without sysfs support)
Message-Id: <20030326204343.A22053@infradead.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan> <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com>
In-Reply-To: <20030326202622.GJ24689@kroah.com>; from greg@kroah.com on Wed, Mar 26, 2003 at 12:26:23PM -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Jan Dittmer <j.dittmer@portrix.net>, azarah@gentoo.org, KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>, sensors@stimpy.netroedge.com

On Wed, Mar 26, 2003 at 12:26:23PM -0800, Greg KH wrote:
> We should really split these multivalue files up into individual files,
> as sysfs is for single value files.  Makes parsing easier too.
> 
> Here's a patch for the lm75.c driver that does this.  As we are going to
> need a "generic" read and write for the "real" values that the i2c
> drivers use, I added these files to the i2c-proc.c file.

i2c-proc.c is the wrong place.  Please add a i2c-sensor.c file with
helper code for hardware sensors driver (i2c_detect should move over to
there from i2c-proc.c aswell)
