From: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Date: Mon, 13 Sep 2010 10:56:53 +0000
Subject: [lm-sensors] Coretemp on Intel D510MO motherboard (Atom D510 CPU)
Message-Id: <201009131156.53518.simon.farnsworth@onelan.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I'm seeing various anomalies in the temperature readings from the coretemp 
driver on the Intel D510MO motherboard (Atom D510 CPU).

I'm using kernel 2.6.34, and I'm seeing two sets of anomalies (confirmed by 
reading the MSRs using msr-tools, so not just coretemp getting it wrong):

1) Some boots, the coretemp sensors never return me a temperature reading at 
all (top bit of MSR_IA32_THERM_STATUS never gets set).

2) Different motherboards give different readings (by about 10C) when running 
the same load, at an ambient (controlled by aircon) of 22C. In particular, 
some boards give readings in the range 5 to 10C, others in the range 15C to 
20C, and yet others in the range 25C to 30C. None of the boards appear to be 
able to read from MSR_IA32_TEMPERATURE_TARGET, so if it's a varying TjMax, 
there's no way to tell.

I'm running BIOS revision MOPNV10J.86A.0311 which is the latest available - 
any hints on what might be going wrong would be appreciated.

-- 
Thanks,

Simon Farnsworth

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
