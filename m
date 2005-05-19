From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: [Fwd: sensor issues]
Message-Id: <20040608223230.2a08d529.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40C6098A.8020101@edgedesign.us>
In-Reply-To: <40C6098A.8020101@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The min/max on most of these are reversed.  /etc/sensors.conf seemed
> to have them right, but the display has them flipped.
> 
> Let me know if you want me to send /etc/sensors.conf

Yes please.

> LinuxBook1 root # sensors
> it87-isa-0290
> Adapter: ISA adapter
> VCore 1:   +1.47 V  (min =  +2.68 V, max =  +1.40 V)   ALARM
> VCore 2:   +1.56 V  (min =  +0.12 V, max =  +3.77 V)
> +3.3V:     +3.28 V  (min =  +1.02 V, max =  +1.02 V)   ALARM
> +5V:       +4.37 V  (min =  +5.38 V, max =  +3.68 V)   ALARM
> +12V:     +11.96 V  (min =  +0.48 V, max =  +4.08 V)   ALARM
> -12V:      -9.26 V  (min =  -3.74 V, max = -11.71 V)   ALARM
> -5V:       -4.72 V  (min =  -3.42 V, max =  -8.05 V)   ALARM
> Stdby:     +2.47 V  (min =  +0.10 V, max =  +1.93 V)   ALARM
> VBat:      +3.08 V
> fan1:        0 RPM  (min =    0 RPM, div = 8)
> fan2:        0 RPM  (min =    0 RPM, div = 8)
> fan3:        0 RPM  (min =    0 RPM, div = 2)
> M/B Temp:    +45 C  (low  =    +2 C, high =   -96 C)   sensor = thermistor
> CPU Temp:    +46 C  (low  =   +64 C, high =   -36 C)   sensor = thermistor ALARM
> Temp3:       +50 C  (low  =   -64 C, high =   -64 C)   sensor = thermistor

Which kernel? Which version of i2c (if kernel 2.4.x)? Which version of
lm_sensors?

Is this the result of running "sensors -s", or was the chip in this
state from the beginning?

Are you *absolutely* sure you have an it87 on this system? Looks like
random values to me. Which system is this, BTW?

Full output of sensors-detect and isadump 0x295 0x296 (twice)
appreciated.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
