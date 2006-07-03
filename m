From: Lou@ParisiHome.net (Lou Parisi)
Date: Mon, 03 Jul 2006 07:07:53 +0000
Subject: [lm-sensors] CPU Temp on ECS NFORCE3-A939
Message-Id: <000001c69e6f$69b3d730$7001a8c0@parisi02>
List-Id: <lm-sensors.vger.kernel.org>
References: <000f01c69295$f481af80$7001a8c0@parisi02>
In-Reply-To: <000f01c69295$f481af80$7001a8c0@parisi02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for your help on this issue from a few weeks ago.  I have an update
that may be of interest.  I have attached the previous thread for your
reference.  This was for an ECS NFORCE3-A939 with an Athlon 64 3000+.

I was not able to monitor my CPU temp using lm sensors because the chip for
my cpu temperature is not supported.  Since then I noticed in my boot log
that there was a readout of the cpu temp from acpi.  I found the cpu
temperature is being logged to /proc/acpi/thermal_zone/THRM/temperature.  I
had already setup tellerstats to create html output for the sensors I was
able to monitor with lm sensors and I was easily able to modify that script
to get the cpu temperature from this location and add it in.

Still would be interested to hear if you add support for my chip in the
future but this seems to accomplish the same thing.  Everything else is
working great.  

Thanks again, Lou

-----Original Message-----
From: Jean Delvare [mailto:khali at linux-fr.org] 
Sent: Tuesday, June 20, 2006 7:53 AM
To: Lou Parisi
Cc: LM Sensors
Subject: Re: [lm-sensors] CPU Temp on ECS NFORCE3-A939

Hi Lou,

> > I wouldn't be surprised if you have the same chip as Brian.
> 
> I ran the new sensors-detect and the chip detected was the same as
Brian's.
> Can you please add my name also to the list of those interested in this
> driver.  The output from the latest sensors-detect is at the bottom of
this
> page.

I've done so.

> Thank you for all of your help.  Lou

You're welcome :) Now the hard part would be to write, review and test
a driver for that chip - but I just don't have the time to do that,
unfortunately.

> By the way, I heard back from ECS.  Their response:
> ----------ECS Response ----------
> Dear Valued Customer:
> 
> If a monitoring software is being used and is failing to collect data for
> the CPU temprature, the software is incompatible and no monitoring
software
> is available for the board since Hardware Monitor was already integrated
in
> the BIOS.
>  
> Thank you for using ECS products
> ---------------------------------

Well, at least they answered, but that wasn't really useful. Good thing
that we found the answer by ourselves meanwhile!

-- 
Jean Delvare




