From: mathog@mendel.bio.caltech.edu (David Mathog)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: ticket 1775
Message-Id: <E1C9tq0-0000Dj-00@mendel.bio.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1C9PtS-000754-00@mendel.bio.caltech.edu>
In-Reply-To: <E1C9PtS-000754-00@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > > Um, well, the alarm seems to come and go here:
> > > 
> > > VCore 1:   +1.73 V  (min =  +1.66 V, max =  +1.94 V)
> > > sometimes it reads ALARM too, sometimes not. The Voltage
> > > shown doesn't change though.
> >
> > No idea. You could try to periodically dump the chip contents (using
> > i2cdump 0 0x28 or i2cdump 0 0x2c) and see if the alarms shows there
> > too (bit 1 of register 0x41).
> 
> My mistake, it's actually bit 0, not 1.

Unfortuantely that's going to receive a priority somewhere
near 0 as classes start soon and I only need this "good enough"
to muddle through the semester.

A few of the sensors values still appear to be wrong.
The fan speeds claim to be 8333 and 8766 RPM (divisor 2) but at
least one is a standard AMD fan, and they really run at aroun 5400.
Hmm, google turned this up for Tyan boards:

 compute fan1 (14318/24000)*@ , @ / (14318/24000)

Putting this in the attached sensors.conf:

    compute fan1 (14318/24000)*@ , @ / (14318/24000)
    compute fan2 (14318/24000)*@ , @ / (14318/24000)
    compute fan3 (14318/24000)*@ , @ / (14318/24000)
    
    set fan1_min 8000
    set fan2_min 8000

gives:

CPU1 Fan: 5097 RPM  (min = 3987 RPM, div = 2)                     
CPU2 Fan: 5298 RPM  (min = 3987 RPM, div = 2)                     
chs1 Fan:    0 RPM  (min =   -1 RPM, div = 2)

which is about right (there is no chassis fan).

VRM 1,2 read 61 and 56 degrees C, but when I put my finger on those
regulators they only feel warm, not even uncomfortably so,
those values must be bogus too.  There are some Tyan S2466 machines
in my area and they only read about 40 degrees on the VRM with
an AMD MP 2200+ in it, one would expect that AMD MP 2000+ should
draw even less current.  The regulators feel about the same 
temperature in both types of machines.  For both machines
sensors.conf just uses the raw "temp" values with no formula.

Unfortunately the BIOS on the S2468UGN has no hardware monitor
functions, so there's nothing to compare lm_sensors with.

My sensors.conf (before the change noted above)
and sensors.out are attached.

Thanks,


David Mathog
mathog@caltech.edu
Manager, Sequence Analysis Facility, Biology Division, Caltech
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/octet-stream
Size: 2928 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040921/9a01d711/attachment.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/octet-stream
Size: 1591 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040921/9a01d711/attachment-0001.obj
