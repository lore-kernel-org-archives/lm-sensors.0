From: Paul Crawford <psc@sat.dundee.ac.uk>
Date: Mon, 25 Jun 2012 10:54:28 +0000
Subject: Re: [lm-sensors] Configuration for EL620-C motherboard
Message-Id: <4FE84364.2030508@sat.dundee.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FE232BE.7060409@sat.dundee.ac.uk>
In-Reply-To: <4FE232BE.7060409@sat.dundee.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Jean
>> While temp1 clearly has incorrect limits, the values of 80C & 75C for
>> the temp2 = CPU is not unreasonable.
>
> FWIW I think every Winbond/Nuvoton W83* Super-I/O chip I've ever seen
> had temp1 limits uninitialized and temp2 and temp3 limits initialized
> to sane values as you have above.

That makes sense.

> I agree with all proposed changes and have applied them to the wiki.

Thanks.

I also had a look around the motherboard and found that:

Temperature sensor #1 (RT1) is located next to the w83627dhg chip, close 
to the rear of the motherboard and between the PCI and ISA slots.

Temperature sensor #2 (RT2) is located just under the Intel G41 "Express 
Chipset" in the centre of the motherboard (probably the hottest device 
aside from the CPU).

Regards,
Paul
-- 
Dr. Paul S. Crawford
Satellite Station
Dundee University
Small's Wynd, Dundee,
DD1 4HN, U.K.
Tel: +44 (0)1382 38 4687
Email: psc@sat.dundee.ac.uk
The University of Dundee is a Scottish Registered Charity, No. SC015096


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
