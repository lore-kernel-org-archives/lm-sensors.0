From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 28 Aug 2006 19:17:44 +0000
Subject: [lm-sensors] Flex Scanner Jammed Problem
Message-Id: <20060828211744.8044f6be.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Below is the new sensors output:
> 
> adm1026-i2c-2-2c
> Adapter: SMBus nForce2 adapter at 4c40
> in0:       +1.30 V  (min =  +2.25 V, max =  +2.75 V)   ALARM
> in1:       +1.30 V  (min =  +1.49 V, max =  +1.82 V)   ALARM
> in2:       +1.50 V  (min =  +1.35 V, max =  +1.65 V)   
> in3:       +2.64 V  (min =  +2.16 V, max =  +2.86 V)   
> in4:       +2.62 V  (min =  +2.34 V, max =  +2.86 V)   
> in5:       +0.00 V  (min =  +1.22 V, max =  +2.02 V)   ALARM
> in6:       +1.21 V  (min =  +1.08 V, max =  +1.32 V)   
> in7:       +1.19 V  (min =  +1.02 V, max =  +1.68 V)   
> in8:       +0.00 V  (min =  +0.00 V, max =  +2.49 V)   
> in9:       +0.16 V  (min =  +0.00 V, max =  +0.70 V)   
> in10:      +3.06 V  (min =  +2.70 V, max =  +3.30 V)   
> in11:      +3.40 V  (min =  +2.97 V, max =  +3.64 V)   
> in12:      +3.40 V  (min =  +2.97 V, max =  +3.64 V)   
> in13:      +5.10 V  (min =  +4.50 V, max =  +5.49 V)   
> in14:      +1.19 V  (min =  +1.02 V, max =  +1.68 V)   
> in15:     +12.06 V  (min = +10.81 V, max = +13.19 V)   
> in16:     -12.10 V  (min = -13.18 V, max = -10.80 V)   
> ERROR: Can't get FAN0 data!
> fan1:        0 RPM  (min =    0 RPM, div = 8)   
> fan2:     6750 RPM  (min =    0 RPM, div = 8)   
> fan3:        0 RPM  (min =    0 RPM, div = 8)   
> fan4:     7031 RPM  (min =    0 RPM, div = 8)   
> fan5:        0 RPM  (min =    0 RPM, div = 8)   
> fan6:        0 RPM  (min =    0 RPM, div = 8)   
> fan7:        0 RPM  (min =    0 RPM, div = 8)   
> temp1:       +24?C  (low  =    +0?C, high =   +72?C)  
> temp2:        -1?C  (low  =    +0?C, high =   +72?C)     ALARM
> temp3:       +16?C  (low  =    +0?C, high =   +72?C)  
> vid:      +1.175 V  (VRM Version 2.4)

OK, so it mostly works now. The error on FAN0 can be explained by the
fact that the 2.4 driver (and thus libsensors) numbered fans from 0 to
7 while the 2.6 driver numbers them the standard way (1 to 8). It's odd
that nobody ever complained about that...

I've just fixed it in lm_sensors SVN.

temp3 is a bit too cold to be real, unless the system is heavily
air-conditioned.

> A few of the values are obvious, but others are not.  Is there
> any way to find out which inputs are designated as which values?

Ask the system/motherboard vendor?

If the BIOS displays hardware monitoring data, you can use that as a
target for where the sensors output should look like.

-- 
Jean Delvare

