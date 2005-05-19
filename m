From: mathog@mendel.bio.caltech.edu (David Mathog)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: ticket 1775
Message-Id: <E1C9WI5-0000Bz-00@mendel.bio.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1C9PtS-000754-00@mendel.bio.caltech.edu>
In-Reply-To: <E1C9PtS-000754-00@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> This is strange. You forced address 0x2d and still 0x28 shows. Maybe the
> chip is really at 0x28 and you should use this address for the
> modprobe.conf file. This could explain why the subclients force failed.
> So please first try the following line:
> 
> options w83781d force_w83782d=0,0x28 force_subclients=0,0x28,0x48,0x49
force_w83627hf=0,0x2c force_subclients=0,0x2c,0x4a,0x4b init=0
> 
> 
> (basically, 0x2d becomes 0x28) and try again.

Put that in /etc/modprobe.conf and only this in /etc/sysconfig/lm_sensors

MODULE_0=i2c-amd756
MODULE_1=w83781d


That did eliminate the warning on start up and the values
are correct.  Um, well, the alarm seems to come and go
here:

VCore 1:   +1.73 V  (min =  +1.66 V, max =  +1.94 V)              

sometimes it reads ALARM too, sometimes not. The Voltage
shown doesn't change though.

These two sets of values still look wrong values to me, the
first is awfully high (not sure where VRM1 is, but it shouldn't
be higher than the CPU temps) and the DDR voltage looks
low.  The air coming out of the back of the case is warm
but not uncomfortably hot, feels like about 42-44 C.

VRM1 Temp:   +62?C  (high =   -67?C, hyst =  -101?C)   sensor = 3904
transistor 
DDR V:     +1.23 V  (min =  +1.65 V, max =  +2.05 V)    

These are minor problems though, since all I really need to
keep an eye on are the CPU fan speeds and CPU temps.          

Thanks,

David Mathog
mathog@caltech.edu
Manager, Sequence Analysis Facility, Biology Division, Caltech
