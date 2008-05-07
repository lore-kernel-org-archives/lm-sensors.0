From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 07 May 2008 06:18:38 +0000
Subject: Re: [lm-sensors] Problem with sensors on linux 2.6.25
Message-Id: <20080506231838.563c9dcd.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200805042334.03574.tockar@o2.pl>
In-Reply-To: <200805042334.03574.tockar@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tockar <tockar@o2.pl>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Sun, 4 May 2008 23:34:03 +0200 tockar <tockar@o2.pl> wrote:

> Hello,
> I've strange problem with Linux 2.6.25 and later (I've compiled 2.6.26-rc1 and 
> I have same problem). In 'sensors' command result, I get ALARMs. 
> Here's 'sensors' result on Linux 2.6.24:
> 
> it87-isa-0290
> Adapter: ISA adapter
> VCore 1:     +1,71 V  (min =  +3,97 V, max =  +1,95 V)
> VCore 2:     +3,09 V  (min =  +3,82 V, max =  +1,01 V)
> +3.3V:       +3,07 V  (min =  +3,82 V, max =  +3,06 V)
> +5V:         +5,59 V  (min =  +4,27 V, max =  +5,11 V)
> +12V:       +13,31 V  (min = +15,62 V, max =  +7,74 V)
> -12V:        -2,69 V  (min =  -0,61 V, max =  +3,44 V)
> -5V:         -9,14 V  (min =  +3,82 V, max =  -2,62 V)
> Stdby:       +0,00 V  (min =  +6,37 V, max =  +5,03 V)
> VBat:        +3,25 V
> fan1:       5152 RPM  (min =    0 RPM, div = 2)
> fan2:          0 RPM  (min =    0 RPM, div = 2)
> M/B Temp:    +34,0__C  (low  =  -7,0__C, high = -11,0__C)  sensor = transistor
> CPU Temp:    +33,0__C  (low  = -66,0__C, high = +127,0__C)  sensor = transistor
> Temp3:       +31,0__C  (low  = -33,0__C, high = -101,0__C)  sensor = transistor
> 
> Two minutes later, on Linux 2.6.25:
> 
> it87-isa-0290
> Adapter: ISA adapter
> VCore 1:     +1,71 V  (min =  +3,97 V, max =  +1,95 V)   ALARM
> VCore 2:     +3,09 V  (min =  +3,82 V, max =  +1,01 V)   ALARM
> +3.3V:       +3,07 V  (min =  +3,82 V, max =  +3,06 V)   ALARM
> +5V:         +5,59 V  (min =  +4,27 V, max =  +5,11 V)   ALARM
> +12V:       +13,31 V  (min = +15,62 V, max =  +7,74 V)   ALARM
> -12V:        -2,69 V  (min =  -0,61 V, max =  +3,44 V)   ALARM
> -5V:         -9,14 V  (min =  +3,82 V, max =  -2,62 V)   ALARM
> Stdby:       +0,00 V  (min =  +6,37 V, max =  +5,03 V)   ALARM
> VBat:        +3,25 V
> fan1:       5152 RPM  (min =    0 RPM, div = 2)
> fan2:          0 RPM  (min =    0 RPM, div = 2)
> M/B Temp:    +35,0__C  (low  =  -7,0__C, high = -11,0__C)  sensor = transistor
> CPU Temp:    +33,0__C  (low  = -66,0__C, high = +127,0__C)  sensor = transistor
> Temp3:       +32,0__C  (low  = -33,0__C, high = -101,0__C)  sensor = transistor
> 
> Results are almost identical, but I get those ALARMs. I've Pentium4 1,4Ghz 
> processor, module for my mainboard is BLK_DEV_VIA82CXXX. Is that a bug? Can I 
> safely use Linux 2.6.25 or later?

(cc added)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
