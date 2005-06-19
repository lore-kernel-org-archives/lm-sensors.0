From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 19 Jun 2005 19:51:35 +0000
Subject: [lm-sensors] Req for sensors help w/ Asus PC-DL
Message-Id: <42B5B08D.2010407@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <42B4EC0B.1020603@ripptech.com>
In-Reply-To: <42B4EC0B.1020603@ripptech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> ha! That figures.  Not sure when that pnpacpi option was added or when I
> turned it on, but that was the cure.  Brilliant!

The 0x290 IO port was reserved by ACPI and our driver failed to register it.
You turned off the ACPI PNP feature with that option.

> w83627thf-isa-0290
> Adapter: ISA adapter
> VCore:     +1.47 V  (min =  +0.70 V, max =  +1.87 V)
> +12V:     +11.92 V  (min =  +3.16 V, max =  +3.89 V)       ALARM
> +3.3V:     +3.26 V  (min =  +0.13 V, max =  +0.03 V)       ALARM
> +5V:       +4.91 V  (min =  +3.63 V, max =  +3.44 V)       ALARM
> -12V:     -14.91 V  (min = -14.91 V, max = -14.91 V)       ALARM
> V5SB:      +5.05 V  (min =  +0.11 V, max =  +0.03 V)       ALARM
> VBat:      +3.10 V  (min =  +2.83 V, max =  +0.26 V)       ALARM
> fan1:     3750 RPM  (min = 3125 RPM, div = 2)
> CPU Fan:  5487 RPM  (min =   -1 RPM, div = 2)              ALARM
> fan3:     5532 RPM  (min = 10546 RPM, div = 2)              ALARM
> M/B Temp:    +46 C  (high =    +0 C, hyst =    +0 C)   sensor > thermistor   ALARM
> CPU Temp:  +41.5 C  (high =   +80 C, hyst =   +75 C)   sensor = thermistor
> temp3:     +39.0 C  (high =   +80 C, hyst =   +75 C)   sensor = thermistor
> vid:      +0.275 V  (VRM Version 9.0)
> alarms:   Chassis intrusion detection                      ALARM
> beep_enable:
>           Sound alarm disabled
> 
> I think I can figure out the labels etc. from here, unless you're
> talking about something else w/ the CPU temps?

We just sent a query about THF chip to winbond we think it might have some additional features. (more fans)

The CPUs itself might have build in sensor. I think it resides on address 0x48 and 0x49

Please can you do:

modprobe i2c-i801
modprobe i2c-dev
i2cdump 0 0x48
i2cdump 0 0x49

In meanwhile you can try:

modprobe adm1021 force_adm1021=0,0x48
Or better (i'm not sure about delimiter)
modprobe adm1021 force_adm1021=0,0x48,0,0x49
sensors

More on this on monday after my exam.

Regards
Rudolf


