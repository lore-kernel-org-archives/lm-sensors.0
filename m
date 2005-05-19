From: John.Morris@spirentcom.com (Morris, John)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: MAX6650 driver
Message-Id: <629E717C12A8694A88FAA6BEF9FFCD440224B3A9@brigadoon.spirentcom.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030827130911.2931281e.khali@linux-fr.org>
In-Reply-To: <20030827130911.2931281e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> -----Original Message-----
> From: Vojtech Pavlik [mailto:vojtech@ucw.cz]
> Sent: Friday, August 29, 2003 4:17 AM
> To: sensors@stimpy.netroedge.com
> Cc: Vojtech Pavlik; John.Morris@spirentcom.com
> Subject: Re: MAX6650 driver
> 
> 
> On Wed, Aug 27, 2003 at 01:09:11PM +0200, Jean Delvare wrote:
> > 
> > Hi Pavlik,
> > 
> > Some months ago, you told us you would write a driver for 
> the MAX6650
> > chipset. How far did you go? I ask you now because John Morris also
> > worked on a driver for this chipset, so I'd like you both 
> to share what
> > you have. If we could have a working driver commited to our CVS
> > repository, it would be great.
> 
> I'm sorry, the chip never made it on the mainboard I was planning to
> write support for, so the project for the MAX6650 driver was 
> cancelled."

ok, I'll submit mine to CVS.

Let's start working through the new_drivers check list...

It's ok to put my name on the "New Drivers" page.

I need an ID reserved in i2c-id.h. I suggest:

--- kernel/i2c-id.h     23 Aug 2003 20:32:57 -0000      1.77
+++ kernel/i2c-id.h     29 Aug 2003 13:35:39 -0000
@@ -157,6 +157,7 @@
 #define I2C_DRIVERID_SAA1064 1041
 #define I2C_DRIVERID_LM90 1042
 #define I2C_DRIVERID_ASB100 1043
+#define I2C_DRIVERID_MAX6650 1044

John.
