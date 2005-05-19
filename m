From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: driver for mic184 chip
Message-Id: <41FBD889.5020509@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <41FAB35E.1050208@aeroflex.com>
In-Reply-To: <41FAB35E.1050208@aeroflex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ok, I get it, I thought it was two at once.
So I agree that small mods to lm75.c would be the best way.
In addition to the detection fix,
he could add a modparm that switches from internal to remote
if the BIOS didn't do it.

Jean Delvare wrote:
> Hi Mark,
> 
> 
>>since MIC184 has TWO sensors, it should not be added to lm75 IMHO.
>>We shouldn't add a second sensor to the lm75 driver.
> 
> 
> It doesn't really have two sensors. It simply can use an external sensor
> *instead of* the internal one. It cannot use both at the same time. It
> is certainly possible to design a driver that continuously switches from
> internal to external and back, but that would require a clever timing
> and I don't think it's worth the effort. The chip is simply not designed
> for this use. I invite you to consider all the drawbacks of such a
> design (delayed interrupt response to overtemperature, need to have the
> same overtemperature and hysteresis temperature for both "channels",
> impossibility to know which "channel" caused an alarm/interrupt, and
> possibly more bad surprises if we were to really write such a driver).
> 
> Anyway, I don't think that Frank was interested in this - the mic184.c
> driver he proposed would only export one set of sysfs files.
> 
> Thanks,
