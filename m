From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: Constant beep and ALARM warnings on ALI1535
Message-Id: <20040201122201.4d65ac44.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200401311948.50570.juanpedro@fibertel.com.ar>
In-Reply-To: <200401311948.50570.juanpedro@fibertel.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> juan@athos:~$ sensors
> lm78-i2c-0-2c
> Adapter: SMBus ALI1535 adapter at 0400
> Algorithm: Non-i2c SMBus adapter
> VCore 1:   +3.28 V  (min =  +3.04 V, max =  +3.36 V)
> VCore 2:   +2.93 V  (min =  +3.04 V, max =  +3.36 V)
> +3.3V:     +1.71 V  (min =  +1.70 V, max =  +2.10 V)
> +5V:       +6.18 V  (min =  +4.74 V, max =  +5.24 V)
> +12V:     +15.50 V  (min = +15.50 V, max = +15.50 V)   ALARM
> -12V:     -14.19 V  (min = -14.19 V, max = -14.19 V)   ALARM
> -5V:       -6.14 V  (min =  -6.14 V, max =  -6.14 V)   ALARM
> fan1:     4272 RPM  (min =   -1 RPM, div = 2)
> fan2:        0 RPM  (min =   -1 RPM, div = 2)
> fan3:        0 RPM  (min =    0 RPM, div = 2)          ALARM
> temp:      +48.0?C  (high =  +120?C, hyst =  +115?C)
> vid:       +3.20 V
> alarms:   Chassis intrusion detection                  ALARM
> (...)
> Motherboard SY-K7ADA
> Processor AMD Athlon XP 1600+

In fact I don't think you have an LM78 on this motherboard. It's too
recent, LM78 have been replaced by other chips since Pentium II's or
similar.

Please provide the full output of sensors-detect for your system (after
unloading lm78 and eeprom and any other chip driver you would have
loaded). I think that the chipset you have is misdetected.

Also, please provide the output of "i2cdump 0 0x2c" (after unloading
lm78, too).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
