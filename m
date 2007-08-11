From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Sat, 11 Aug 2007 15:48:41 +0000
Subject: Re: [lm-sensors] 2.6.23-rc1 regression: hwmon/w83627ehf: wrong fan
Message-Id: <46BDDA59.5070302@s5r6.in-berlin.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <46B5B290.4040907@s5r6.in-berlin.de>	<20070805162141.GI6221@jupiter.solarsys.private>	<46B6053E.2050708@s5r6.in-berlin.de>	<20070810230831.59cbc50f@hyperion.delvare>	<46BCE6D0.7060300@s5r6.in-berlin.de> <20070811135705.0d0688d7@hyperion.delvare> <46BDD8B3.8070708@s5r6.in-berlin.de>
In-Reply-To: <46BDD8B3.8070708@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

> Jean Delvare wrote:
>> So my theory is that something else (BIOS, ACPI?)

(ksensors?)

>> is changing the bank,
>> probably to read temperature values which are in banks 1 and 2, causing
>> the w83627ehf to get a wrong value for the VBAT register. If I am
>> right, then the attached patch should help. Please give it a try and
>> report.

This patch fixes the issue.  (I didn't reboot, only reloaded the drivers
after patching.)

Thanks for your help and advice.
-- 
Stefan Richter
-===-=-== =--- -=-=
http://arcgraph.de/sr/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
