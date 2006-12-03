From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 03 Dec 2006 10:29:36 +0000
Subject: [lm-sensors] Sending config for ABit NF-M2
Message-Id: <20061203112936.feff465c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45718AC0.5010002@cox.net>
In-Reply-To: <45718AC0.5010002@cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 02 Dec 2006 09:16:32 -0500, MC Castle wrote:
> 1)I could not get your Wiki to work, so maybe someone could post this in 
> event I'm not the only person with a NF-M2.
> 2) You instructions for installing lm-sensors suggests removing files 
> from /usr/lib. This breaks KSysGuard.

Which instructions?

> 
> #======================
> # ABIT NF-M2
> #
> # MC Castle, Castle Engineering Services, LLC
> # 02 Dec 2006: Initial conf for ABIT NF-M2
> #
> #======================
> 
> #****************************************
> chip "k8temp-*"
> # k8temp-i2c--5-c3

Strange string, "sensors" doesn't actually display this, does it?

> # Adapter: PCI adapter
> #****************************************
> 
>     label temp1 "Core 0"
>     ignore temp2
>     label temp3 "Core 1"
>     ignore temp4
>    
> #****************************************
> chip "w83627ehf-*"
> # w83627ehf-isa-0290
> # Adapter: ISA adapter
> 
> # From ABITEQ: Factor = (R2/(R1+R2))*1000
> # Not sure of VAVCC & VSB
> #****************************************
> 
>     label in0 "VCore"        #VCORE    Index 0x20, Bank 0, Factor = 1000
>     label in1 "DDR2 V"        #VIN0        Index 0x21, Bank 0, Factor =  500
>     label in2 "VAVCC?"        #VAVCC    Index 0x22, Bank 0, Factor = ?
>     ignore in2
>     label in3 "ATX +3.3V"    #V3VCC    Index 0x23, Bank 0, Factor = 1000
>     label in4 "DDR VTT"        #VIN1        Index 0x24, Bank 0, Factor = 
> 1000
>     label in5 "CS Core"        #VIN2        Index 0x25, Bank 0, Factor = 
> 1000
>     label in6 "ATX +12V"    #VIN3        Index 0x26, Bank 0, Factor = 131
>     label in7 "VSB?"        #VSB        Index 0x50, Bank 5, Factor = ?
>     ignore in7
>     label in8 "VBAT"        #VBAT        Index 0x51, Bank 5, Factor = ?
>     label in9 "ATX +5V"        #VIN4        Index 0x52, Bank 5, Factor = 333
> 
>     label temp1 "Case Temp"    #SYSTIN    Index 0x27, Bank 0
>     label temp2 "CPU Temp"    #CPUTIN    Index 0x50, Bank 1
>     label temp3 "PWM Temp"    #AUXTIN    Index 0x50, Bank 2
> 
>     label fan1 "SYS Fan"    #SYSFANIN      Index 0x28, Bank 0
>     label fan2 "CPU Fan"    #CPUFANIN0     Index 0x29, Bank 0
>     label fan3 "AUX1 Fan"    #AUXFANIN0     Index 0x2a, Bank 0
>     label fan4 "Aux2 Fan"    #CPUFANIN1     Index 0x3f, Bank 0
>     label fan5 "Aux3 Fan"    #AUXFANIN1     Index 0x53, Bank 5
> 
> #---------------------------------------------------------------------------    
> 
> # commented out Factor = 1000 (read direct entries)
>  
> #   compute in0 (1000/1000)*@, @/(1000/1000)    # F = 1000
>     compute in1 (1000/500)*@, @/(1000/500)    # F =  500
> #   compute in2 (1000/x)*@, @/(1000/x)        # F = ?
> #   compute in3 (1000/1000)*@, @/(1000/1000)    # F = 1000
> #   compute in4 (1000/1000)*@, @/(1000/1000)    # F = 1000
> #   compute in5 (1000/1000)*@, @/(1000/1000)    # F = 1000
>     compute in6 (1000/131)*@, @/(1000/131)    # F =  131
> #   compute in7 (1000/x)*@, @/(1000/x)        # F = ?
> #   compute in8 (1000/x)*@, @/(1000/x)        # F = ?
>     compute in9 (1000/333)*@, @/(1000/333)    # F =  333
> 
> #---------------------------------------------------------------------------
> 
> # set limits to  5% for the critical voltages
> # set limits to 10% for the non-critical voltages
> # set limits to 20% for the battery voltage
> 
>     set in0_min 1.35*0.95
>     set in0_max 1.35*1.05
>     set in1_min 1.8*0.95
>     set in1_max 1.8*1.05
>     set in2_min 3.3 * 0.95
>     set in2_max 3.3 * 1.05
>     set in3_min 3.3 * 0.95
>     set in3_max 3.3 * 1.05
>     set in4_min 0.9 * 0.95
>     set in4_max 0.9 * 1.05
>     set in5_min 1.2 * 0.95
>     set in5_max 1.2 * 1.05
>     set in6_min 12.0 * 0.95
>     set in6_max 12.0 * 1.05
>     set in7_min 3.3 * 0.90
>     set in7_max 3.3 * 1.10
>     set in8_min 3.0 * 0.80
>     set in8_max 3.0 * 1.20
>     set in9_min 5.0 * 0.95
>     set in9_max 5.0 * 1.05
> 
>     set fan1_min 2000
>     set fan2_min 2000
> 
>     set temp1_over 50
>     set temp1_hyst 45
>     set temp2_over 65
>     set temp2_hyst 60
>     set temp3_over 70
>     set temp3_hyst 65
> 
> #---------------------------------------------------------------------------
> 


-- 
Jean Delvare

