From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 25 Jun 2005 00:17:50 +0000
Subject: [lm-sensors] lm78 fan speeds have too high minimum
Message-Id: <20050625001713.7744c55c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050624220454.GI8920@dbz.icequake.net>
In-Reply-To: <20050624220454.GI8920@dbz.icequake.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ryan,

> This is a LM78 chip on a PR440FX board.  lm-sensors is 2.9.1 from
> Debian 'sarge'.

Which kernel?

> # sensors
> lm78-isa-0290
> Adapter: ISA adapter
> VCore 1:   +3.31 V  (min =  +3.14 V, max =  +3.47 V)
> VCore 2:   +3.26 V  (min =  +3.14 V, max =  +3.47 V)
> +3.3V:     +3.25 V  (min =  +3.14 V, max =  +3.47 V)
> +5V:       +5.11 V  (min =  +4.76 V, max =  +5.24 V)
> +12V:     +12.04 V  (min = +11.37 V, max = +12.59 V)
> -12V:     -12.91 V  (min = -13.80 V, max = -11.40 V)
> -5V:       -5.01 V  (min =  -5.25 V, max =  -4.74 V)
> fan1:     4500 RPM  (min = 5314 RPM, div = 2)          ALARM
> fan2:     4753 RPM  (min = 18750 RPM, div = 2)          ALARM
> fan3:     4821 RPM  (min = 15000 RPM, div = 2)          ALARM
> temp:      +33.0 C  (high =   +67 C, hyst =   +75 C)
> vid:       +3.30 V
> alarms:   Chassis intrusion detection                  ALARM
> 
> Note the absurdly high fan minimums.  This was not a problem in
> previous versions, but I don't know when it actually changed.

Unless a bug was introduced here, these values either come from the chip
itself, or from your configuration file, depending on whether you ran
"sensors -s" or not.

> How can the minimums be corrected?

Setting the correct "set fanN_min" lines in the lm78-* section of the
/etc/sensors.conf and running "sensors -s" afterwards should do.

> Using the fan divider on fan1 and fan2 didn't help, and on fan3 the
> divider is not modifiable:

Fan dividers divide an internal clock, they do not alter the final speed
value.

> I'm also looking for a way to disable the chassis intrusion alarm
> through software since no connector for it is available on my
> motherboard.

You can't disable it at the driver level, but you should be able to do
so at the libsensors level by adding the following line to
/etc/sensors.conf (in the lm78-* section, obviously):

   ignore alarms

-- 
Jean Delvare
