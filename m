From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Temp Sensor on Asus A7V8X - Ticket 1358
Message-Id: <20031031040008.GA13565@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.55.0310291645560.11719@localhost>
In-Reply-To: <Pine.LNX.4.55.0310291645560.11719@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* David Antliff <dave.antliff@paradise.net.nz> [2003-10-29 22:15:34 +1300]:
>
> For example, with Asus Probe and lm_sensors/asb100 readings of:
> 
> Asus Probe M/B = temp3 = 24
> Asus Probe CPU = temp4 = 26
> 
> The BIOS displays the readings as:
> 
> M/B = 24
> CPU = 23
> 
> I rebooted several times to confirm this. It seems the BIOS readings are
> not only swapped, but different from the software readings.
> 
> Can you explain this somehow?

My best guess from experience w/ Asus boards:

temp1 is your M/B
temp4 is your CPU

Easiest way to confirm is to run some CPU intensive stuff (SETI@Home or
kernel compile, etc.) and see which temp jumps first.  That's the CPU.
If your readings are off from the BIOS, you can adjust the compute
lines in /etc/sensors.conf to compensate.  Although, all of your readings
above are within 3C and IMO that's good enough.  Speaking generally, these
mainboard sensors are not high precision anyway.

We would appreciate if you send a copy of your /etc/sensors.conf after
you finish tuning it for your board - as a reference for others with the
same board.

And finally, Asus Probe is nasty.  Use MBM instead.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
