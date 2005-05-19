From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: lmsensors on Abit IC7-G
Message-Id: <20031122190019.6f5ee5cf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FB92482.2070306@langfeldt.net>
In-Reply-To: <3FB92482.2070306@langfeldt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The CVS version worked better:
> 
> # sensors-detect
> (...)
> Next adapter: SMBus I801 adapter at 0500 (Non-I2C SMBus adapter)
> Do you want to scan it? (YES/no/selectively): yes
> 
>   Some chips are also accessible through the ISA bus. ISA probes are
>   typically a bit more dangerous, as we have to write to I/O ports to
>   do this.  Do you want to scan the ISA bus? (YES/no): yes

Hm, did it really happen that way, or have you been cutting a part? (I
hope so.)

> Driver `w83781d' (may not be inserted):
>    Misdetects:
>    * ISA bus address 0x0290 (Busdriver `i2c-isa')
>      Chip `Winbond W83627HF' (confidence: 8)
> 
> Driver `w83627hf' (should be inserted):
>    Detects correctly:
>    * ISA bus address 0x0290 (Busdriver `i2c-isa')
>      Chip `Winbond W83627HF Super IO Sensors' (confidence: 9)

Exactly what I had expected.

> # /usr/local/bin/sensors
> w83627hf-isa-0290
> Adapter: ISA adapter
> Algorithm: ISA algorithm
> VCore 1:   +1.50 V  (min =  +0.00 V, max =  +0.00 V)
> VCore 2:   +2.59 V  (min =  +0.00 V, max =  +0.00 V)
> +3.3V:     +3.24 V  (min =  +3.13 V, max =  +3.45 V)
> +5V:       +4.97 V  (min =  +4.72 V, max =  +5.24 V)
> +12V:     +11.97 V  (min = +10.79 V, max = +13.19 V)
> -12V:      -8.33 V  (min = -13.21 V, max = -10.90 V)
> -5V:       -2.94 V  (min =  -5.26 V, max =  -4.76 V)
> V5SB:      +5.53 V  (min =  +4.72 V, max =  +5.24 V)
> VBat:      +3.29 V  (min =  +2.40 V, max =  +3.60 V)
> fan1:     2008 RPM  (min =  166 RPM, div = 32)
> fan2:     5273 RPM  (min =  166 RPM, div = 32)
> fan3:        0 RPM  (min =  332 RPM, div = 16)              ALARM
> temp1:       +31?C  (high =    +0?C, hyst =    +0?C)
> temp2:     +44.0?C  (high =   +85?C, hyst =   +80?C)
> temp3:     +33.0?C  (high =   +85?C, hyst =   +80?C)
> vid:      +0.000 V
> (...)
> This looks like real results.  The -12V is a bit worrying.  I'll
> compare with BIOS and tweak or whatever.

Most chips don't monitor negative voltages anymore. I would bet that
your BIOS won't show these values either, so you can safely ignore them
(add "ignore" statements in your configuration file).

VCore 1/2 limits are wrong because of your bad vid reading (last line).
Try changing the vrm to 9.0 (uncomment one line in the configuration
file) and run "sensors -s", see if it helps. If it doesn't, set these
limits using real values instead of references to vid.

Fan values look OK, limits are way too low. Try changing divisors
(typical value is 2), it might help. Don't forget to run "sensors -s" as
root afterwards.

Temperatures look OK too, except the missing limits for temp1. Tweak
your config file to set the limits as you want them.

After that, you should have a fine-tuned hardware monitoring
configuration :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
