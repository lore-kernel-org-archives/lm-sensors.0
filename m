From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Nov 2010 11:08:55 +0000
Subject: Re: [lm-sensors] Coretemp on Intel D510MO motherboard (Atom D510
Message-Id: <20101129120855.05df985e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Simon,

On Mon, 13 Sep 2010 11:56:53 +0100, Simon Farnsworth wrote:
> I'm seeing various anomalies in the temperature readings from the coretemp 
> driver on the Intel D510MO motherboard (Atom D510 CPU).
> 
> I'm using kernel 2.6.34, and I'm seeing two sets of anomalies (confirmed by 
> reading the MSRs using msr-tools, so not just coretemp getting it wrong):
> 
> 1) Some boots, the coretemp sensors never return me a temperature reading at 
> all (top bit of MSR_IA32_THERM_STATUS never gets set).

I have no clue about that one, sorry. You'd have to ask Intel folks
about this. Fenghua?

> 2) Different motherboards give different readings (by about 10C) when running 
> the same load, at an ambient (controlled by aircon) of 22C. In particular, 
> some boards give readings in the range 5 to 10C, others in the range 15C to 
> 20C, and yet others in the range 25C to 30C. None of the boards appear to be 
> able to read from MSR_IA32_TEMPERATURE_TARGET, so if it's a varying TjMax, 
> there's no way to tell.
> 
> I'm running BIOS revision MOPNV10J.86A.0311 which is the latest available - 
> any hints on what might be going wrong would be appreciated.

The temperature value returned by the coretemp driver isn't absolute.
It's a thermal margin from the critical limit, and the greater the
margin, the worse the accuracy. It isn't really returning degrees
Celsius.

So, if your systems are running in the 15-30 range with a critical
limit at 100, all it means is that you are far away from the critical
limit so your systems are running totally fine and cool and you don't
have to worry at all.

I've added a FAQ entry for this, as the question hits the list
repeatedly:
  http://www.lm-sensors.org/wiki/FAQ/Chapter3#coretempreturnsunrealisticvalues

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
