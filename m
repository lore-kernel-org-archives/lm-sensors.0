From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 01 Mar 2007 06:57:19 +0000
Subject: [lm-sensors] IT8726F support (was: mcp61 sensors support)
Message-Id: <20070301075719.9e1c0127.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Thomas,

On Thu, 22 Feb 2007 12:43:46 -0500, Thomas Garner wrote:
> Yeah, I can recompile, no problem.

OK, then can you please edit drivers/hwmon/it87.c, replace:
#define IT8716F_DEVID 0x8716
with:
#define IT8716F_DEVID 0x8726

Recompile, test and report. The report should include the output of
"sensors" and the message printed in the kernel logs when you loaded
the it87 driver.

Please also provide a dump of the Super-I/O config space:
isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 0x04

And a list of the hardware monitoring items listed by your BIOS.

Thanks,
-- 
Jean Delvare

