From: "hceuterpe@gmail.com" <hceuterpe@gmail.com>
Date: Fri, 15 Aug 2014 14:00:44 +0000
Subject: [lm-sensors] ITE8620E Weird Buzzer
Message-Id: <CAJHs0UFsEmovYvZrfJkJByEArXHQzUgADQ5vkaCPj0hdRbo6Lg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I own a Gigabyte Z97 with an ITE8620E. I followed the guidance of forcing
the it87 module with the 8728 chip since the one I have hasn't been ironed
out quite yet. I intentionally disabled the high temperature CPU, PCH and
system buzzer warnings in the BIOS, along with the minimum fan RPMs.
Identified individual fan RPMs by manually stopping them with either my
fingers or a trusty cotton swab to compare RPMs and setting unused fan
headers to ignored in the conference file. Even got the voltage multipliers
configured.  It appears however that randomly, the case speaker buzzer will
randomly go off, even when the sensor values are clearly in spec ( CPU temp
is about 27C at idle, case temp 31C, set minimum fan RPM warning to 0).
All fans are controlled currently by the BIOS and not an external tool.
Using CentOS 7.
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
