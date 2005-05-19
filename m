From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: PC87366 with the net4801
Message-Id: <20040627210904.36c02173.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
In-Reply-To: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I applied your chips.c patch, but unfortunately I'm still seeing the
> "Can't get TEMP4/5 data" errors. I'm NOT seeing the "Can't get TEMP4/5
> overtemperature data" errors, though.
> 
> pc87366-isa-6620
> Adapter: ISA adapter
> in0:       +2.95 V  (min =  +0.00 V, max =   2.95 V)
> in1:       +2.24 V  (min =  +1.18 V, max =   1.45 V)       ALARM
> in2:       +2.79 V  (min =  +0.00 V, max =   2.95 V)
> in3:       +0.77 V  (min =  +0.00 V, max =   2.95 V)
> in4:       +2.76 V  (min =  +0.00 V, max =   2.95 V)
> in5:       +2.77 V  (min =  +1.27 V, max =   1.55 V)       ALARM
> in6:       +0.00 V  (min =  +1.18 V, max =   1.45 V)       ALARM
> Vsb:       +3.66 V  (min =  +2.99 V, max =   3.59 V)       ALARM
> Vdd:       +3.66 V  (min =  +2.99 V, max =   3.59 V)       ALARM
> Vbat:      +2.95 V  (min =  +2.40 V, max =   2.95 V)
> AVdd:      +3.64 V  (min =  +2.99 V, max =   3.59 V)       ALARM
> S-IO Temp:   +83 C  (low  =    +0 C, high =   +70 C)   ALARM
> S-IO Crit:   +85 C
> ERROR: Can't get TEMP4 data!
> temp4_crit:
>               -9 C
> ERROR: Can't get TEMP5 data!
> temp5_crit:
>               -9 C
> temp6:      -273 C  (low  =  +109 C, high =  +179 C)   ALARM
> temp6_crit:
>               -9 C

Ahhhh I fixed 9 lines and missed 3. Stupid me... Just commited the
missing fixed, please try again. Sorry for being impressively
inefficient on this.

-- 
Jean Delvare
http://khali.linux-fr.org/
