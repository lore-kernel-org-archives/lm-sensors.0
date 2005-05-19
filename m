From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: Ticket #: 1659   it87: it8712f module stops working (lm: message
Message-Id: <1083142755.408f726402569@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1083021688.1553.27.camel@localhost>
In-Reply-To: <1083021688.1553.27.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> weird:
> it87-i2c-0-2d
> Adapter: SMBus I801 adapter at 0500
> VCore 1:   +4.08 V  (min =  +4.08 V, max =  +4.08 V)   
> VCore 2:   +4.08 V  (min =  +4.08 V, max =  +4.08 V)   
> +3.3V:     +4.08 V  (min =  +4.08 V, max =  +4.08 V)   
> +5V:       +6.85 V  (min =  +6.85 V, max =  +6.85 V)   
> +12V:     +16.32 V  (min = +16.32 V, max = +16.32 V)   
> -12V:      +4.01 V  (min =  +4.01 V, max =  +4.01 V)   
> -5V:       +4.00 V  (min =  +4.00 V, max =  +4.00 V)   
> Stdby (5): +6.85 V  (min =  +6.85 V, max =  +6.85 V)   
> VBat:      +4.08 V
> NB:          0 RPM  (min =    0 RPM, div = 128)          
> ICE:         0 RPM  (min =    0 RPM, div = 8)          
> M/B Temp:     -1 C  (low  =    -1 C, high =    -1 C)   sensor > disabled   
> CPU Temp:     -1 C  (low  =    -1 C, high =    -1 C)   sensor > disabled   
> Vreg:         -1 C  (low  =    -1 C, high =    -1 C)   sensor > disabled   
> vid:       +0.00 V
> 
> it87-isa-0290
> Adapter: ISA adapter
> VCore 1:   +0.00 V  (min =  +0.00 V, max =  +0.00 V)   
> VCore 2:   +0.00 V  (min =  +0.00 V, max =  +0.00 V)   
> +3.3V:     +0.00 V  (min =  +0.00 V, max =  +0.00 V)   
> +5V:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)   
> +12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)   
> -12V:     -17.38 V  (min = -17.38 V, max = -17.38 V)   
> -5V:      -20.81 V  (min = -20.81 V, max = -20.81 V)   
> Stdby (5): +0.00 V  (min =  +0.00 V, max =  +0.00 V)   
> VBat:      +0.00 V
> NB:         -1 RPM  (min =   -1 RPM, div = 1)          
> ICE:        -0 RPM  (min =   -0 RPM, div = 2)          
> M/B Temp:     +0 C  (low  =    +0 C, high =    +0 C)   sensor > disabled   
> CPU Temp:     +0 C  (low  =    +0 C, high =    +0 C)   sensor > disabled   
> Vreg:         +0 C  (low  =    +0 C, high =    +0 C)   sensor > disabled   
> vid:       +0.00 V

Obviously, it's all 0xff on the I2C bus, and all 0x00 on the ISA bus.
That's not particularly weird if you consider that the "natural state"
of the I2C bus is high.

> as you may have noticed i have both an i2c and ISA sensor output,
> which i haven't been able to figure out how to turn one off but i
> don't really care and figure it's simple....

If you want to see only one of the two output, the easiest way is not to
load both bus drivers. Either load i2c-i801 or i2c-isa, but not both.
However, this was interesting to verify that both readings fail. This
would tend to prove that the chip itself is broken, not the busses. You
may still want to ensure that the failure occurs even if you use only
one of the bus drivers (maybe there's some kind of bad interaction
between both access modes).

When the chip goes broken, you may want to try:
i2cset 0 0x2d 0 0x90
(make sure you have i2c-i801 loaded as bus 0)
This will try to preform a reset of the it87 chip. However, if the chip
is already dead broken, I doubt it'll work.

Let us know if you find something new.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
