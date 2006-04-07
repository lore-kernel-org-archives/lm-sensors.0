From: pford@justcroft.com (Peter Ford)
Date: Fri, 07 Apr 2006 13:47:57 +0000
Subject: [lm-sensors] Curious temperature readings
Message-Id: <44366D8D.8010403@justcroft.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I'm new to the lm-sensors world, but I have some curious results that 
I'm struggling to understand.

My hardware is:
	Pentium4 2A GHz (Northwood, 512Kb cache, socket478)
	Motherboard is tricky to identify, but says 845CA so maybe it's
	 a Jetway 845CA - that seems consistent with their specs and
	 looks like an Intel 845 chipset.
	Sensor chip is a Winbond w83627hf.

Software is Mandriva 2006

I started to get the system shutting down spontaneously, often 
overnight, but also while I'm working. No obvious application causing 
it. I did memory tests and that came up clean. So I decided to monitor 
CPU temperature and voltages using lm-sensors and KDE-SystemGuard.

On the original hardware, with a standard Intel heatsink and fan, I got 
three temperature readings:
temp1: 15-20?C
temp2: 28-35?C
temp3: 54-60?C

I figured temp3 was CPU chip temperature, and a bit high: the cooler 
looked a bit grubby and I have a feeling that the thermal grease had 
been disturbed. So I looked for a way of cleaning this up, and found the 
Asatek Micro Chill cooler - so I bought one (retail therapy I guess...)

Anyway, with this (big) cooler now on the chip, my readings are:
temp1: ~20?C
temp2: 30-35?C
temp3: Started at 118?C (!) but is gradually working its way down 
towards 60?C

Now I'll admit that I might have screwed the cooler installation, but I 
was surprised to see 100+?C on a running machine. So have I 
misinterpreted the readings, or maybe the sensors are not connected like 
lm-sensors expects...

Anyone have any suggestions?

One other thing, VCore1 is a bit fluffy, with occasional spikes to 1.8V 
and dips below 1.4V (should be 1.5V). Does that sound reasonable?

Cheers
Pete

-- 
Peter Ford			phone: 01580 893333
Developer			fax:   01580 893399
Justcroft International Ltd., Staplehurst, Kent

