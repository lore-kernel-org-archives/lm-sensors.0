From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: A7V8X-X and lm sensors
Message-Id: <20030920195017.4ad0acbd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030918153623.GA3679@pvv.org>
In-Reply-To: <20030918153623.GA3679@pvv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Another thing. If the fan drops below 2500-2600 RPMs I only get 0 RPM
> with lm sensors. Why is that? Is that why my chassie fan (fan2) is
> constantly 0 RPM? It runs normally at around 1600

This is a FAQ, you need to increase the fan divisor.

--- 8< ---
4.1.1 Fans sometimes/always read 0!!
------------------------------------

   You may not have a three-wire fan, which is required.

   You may need to increase the 'fan divisor'. See `doc/fan-divisors'
in our package for further information.
--- 8< ---

> I'm trying now to find other people her in scandinavia that uses the
> same motherboard and are willing to do tests to find the temperatures.
> have you had any experience that the temperature can be dependant of
> the CPU? I mean if somebody has a P4 or a AMD 2800+ XP etc would that
> influence the difference in the BIOS and lm sensors temperature
> reading?

Could be. That's uncommon, but Alex van Kaam (Motherboard Monitor's
author) wrote to me this morning saying just this:

"I finally have the correct info for the EPIA M10000 temps, which uses
the VT1211 sensor chip, they use a diffrent calculation per CPUID !!"

So, yes, some chips report different results depending on which CPU is
plugged in. As a side effect, the differences with LM Sensors could be
altered (although they do not have to be). I believe that the
differences (between CPUs) are introduced to match their internal
temperature sensor at best.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
