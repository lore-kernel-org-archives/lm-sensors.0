From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 18 Jun 2007 08:59:13 +0000
Subject: [lm-sensors] Howto name fintek 71882 temp sysfs files?
Message-Id: <46764961.5080602@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

As already explained my student (Hans Edgington), has returned the Epox 
motherboard to school and now I'm working on cleaning up his driver and adding 
missing features.

The temp sensors in this chip have an OVT (over temperature) and a high 
temperature limit, both have a shared hysteresis. This hysteresis is a true 
hysteresis. When a temp is over either limit a flag gets set, when it gets 
below limit-hysteresis the flag gets cleared again.

I've been digging through the datasheets to try and find the differences 
between the 2 limits.

Both limits have flags, can cause interrupts and PME events.

The main difference seems to be OVT Output Enable Register 1  Index 66h
at page 75 of the datasheet:
http://www.fintek.com.tw/files/productfiles/F71882_V0.24P.pdf

The high limit has alert events coupled to its, which can not be enabled (read 
only). Where as the ovt has an over temperature (OVT) mechanism, which can be 
enabled and is active for the CPU temp by default, the OVT mechanism, has an 
output pin reserved which it can control when an OVT conditions happens.

The high limit can be coupled to forcing fans to go full speed.

To me this sounds like the high limit should be mapped to temp#_max and the OVT 
to temp#_crit, and since the hyst is for both limits it should be temp#_hyst.

Does this sound like a plan?

Regards,

Hans








_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
