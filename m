From: ep@plicht.de (Ekki Plicht)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: Info on Epox 8RDA+ motherboard sensors
Message-Id: <200307162235.12732.ep@plicht.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,
first - thanks for the excellent work on lm_sensors.

Here is a little input on what I found on my new Epox 8RDA+ motherboard. Maybe 
you can use it somewhere else.

The motherboard uses the recent nForce2 chipset.
OS is SuSE 8.2, kernel 2.4.20
sensors is version 2.7.0

sensors-detect reports a Winbond W83627HF chip.

BIOS has display for
Vdd (1.6V)
Vcore (1.66V)
Vdimm (2.64V)
and the other usual power supply voltages, except:

BIOS has NO display for 3.3V. So I don't know if this is really not used or 
what.

VID was reported as 3.50V, so I changed the in0_min/max and in1_min/max 
calculation from using vid to 1.6V, works fine.

Fan divisors needed to be set to 4 instead of default 2, now working nicely.


That's all. Again, thanks, let me know if you need any other data on this 
motherboard.

Regards,
Ekki from Germany

