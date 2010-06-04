From: "David Mathog" <mathog@caltech.edu>
Date: Fri, 04 Jun 2010 17:44:00 +0000
Subject: Re: [lm-sensors] Gigabyte MA785GMT-UD2H
Message-Id: <E1OKaw4-0007KV-1B@mendel.bio.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1OI4SR-000499-9R@mendel.bio.caltech.edu>
In-Reply-To: <E1OI4SR-000499-9R@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Hmm, could be due to the CPU speed scaling.  In the BIOS I'm pretty sure
> the CPUs are both running at their maximum speed of 2800MHz, but in
> Windows and linux they scale down to 800MHz.  Plugged a DMM into a molex
> connector and measured this for the performance and ondemand governors:
>      2800MHz  800Mz
> 5V    5.07    5.06
> 12V  12.03    12.04

A slightly different table:
                              DMM
BIOS measurement  11.985    = 12.00
W7 speedfan       12.10     = 12.02
in4/lm_sensors    3.02/3.04 = 12.03 (2800MHz)
in4/lm_sensors    3.02/3.04 = 12.04 (800MHz)

So it does look like 12V in the BIOS mode really is a hair lower than it
is in either linux or W7.  Using 3.03 for the avg in4 measurement and
12.035 for the avg DMM measurement gives a scale factor of 3.97,
assuming the DMM is actually correct.  

Regards,

David Mathog
mathog@caltech.edu
Manager, Sequence Analysis Facility, Biology Division, Caltech

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
