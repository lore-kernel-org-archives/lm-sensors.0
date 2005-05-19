From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Support for DDR2 DRAM??
Message-Id: <20040910085906.M5206@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <28703505.1094766606690.JavaMail.root@louie.psp.pas.earthlink.net>
In-Reply-To: <28703505.1094766606690.JavaMail.root@louie.psp.pas.earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 9 Sep 2004 17:50:06 -0400 (GMT-04:00), David Knierim wrote
>    I'm running the latest CVS version of sensors and the sensors 
> command does not appear to support the DDR2 DRAM in my server.   
> When I run sensors on this box, I get output like this:
> 
> eeprom-i2c-0-53
> Adapter: SMBus I801 adapter at 0540
> Unknown EEPROM type (8)
> 
> Any advice on getting the sensors command to know about DDR2 DRAM??

Well, this may not be a memory eeprom at all. New systems tend to have various
types of EEPROMs exposed on the SMBus, for holding manufacturer-specific data
(like in Sony Vaio laptops) or ethernet adapters MAC addresses.

Please provide a dump of the EEPROM (using "i2cdump 0 0x53"). It it actually
is an DDR2 DRAM EEPROM we'll see how we can get it supported. With some luck
it might use the same standards as DDR and we may just have to add the new
type value to get it supported.

-- 
Jean Delvare
http://khali.linux-fr.org/
