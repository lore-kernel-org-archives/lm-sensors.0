From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 14 Jun 2006 15:07:16 +0000
Subject: [lm-sensors] ASUS NCCH-DR confusing 83792 vs. 83627THF
Message-Id: <44902624.9090509@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <44901813.3080703@fasytek.dk>
In-Reply-To: <44901813.3080703@fasytek.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi J.

> I have build a brand new server for SuSE 10, using ASUS NCCH-DR, and
> everything
> works fine, apart from the HW monitoring.

Lets fix it.

> The only "likely" chip I can see on the board is a Winbond W83627THF,
> but according
> to ASUS support the HW monitoring chip should be W83792D (even if I
> can't find it).

It is "hidden" using the multiplexer. Please upgrade to latest BIOS.
If sensors-detect cannot find it - we have a contact at ASUS and they will fix it.

> w83627thf-isa-0290
> Adapter: ISA adapter
> VCore:     +1.94 V  (min =  +1.94 V, max =  +1.94 V)            
> +12V:      +7.60 V  (min = +10.82 V, max = +13.19 V)       ALARM
> +3.3V:     +3.34 V  (min =  +3.14 V, max =  +3.47 V)            
> +5V:       +4.96 V  (min =  +4.75 V, max =  +5.25 V)            
> -12V:      +6.06 V  (min = -10.80 V, max = -13.18 V)       ALARM
> V5SB:      +5.00 V  (min =  +4.76 V, max =  +5.24 V)            
> VBat:      +0.00 V  (min =  +2.40 V, max =  +3.60 V)       ALARM
> fan1:        0 RPM  (min = 4891 RPM, div = 2)              ALARM CPU
> Fan:     0 RPM  (min = 37500 RPM, div = 2)              ALARM
> fan3:        0 RPM  (min = 28125 RPM, div = 2)              ALARM M/B
> Temp:    -48?C  (high =  +104?C, hyst =    +0?C)   sensor > thermistor          CPU Temp:  -48.0?C  (high =   +80?C, hyst =  
> +75?C)   sensor = thermistor          temp3:     -48.0?C  (high =  
> +80?C, hyst =   +75?C)   sensor = thermistor          alarms:   Chassis
> intrusion detection                      ALARM
> beep_enable:
>          Sound alarm enabled
>

This chip is known to be unused for the fans/temps. You dont need to load this
driver.

> The other thing that puzzles me: In an X86_64 system, I would expect to
> find
> the libsensor libraries in a the /lib64 directory, but they actually get
> nstalled
> in /usr/local/lib. What must I do to get these libraries in the proper
> place ?
> 

# You should not need to change this. It is the directory into which the

# library files (both static and shared) will be installed.

LIBDIR := $(PREFIX)/lib

maybe you can change this to lib64 so the dir will be /usr/local/lib64 but I
dont know if such directory can exist.

You may also change the PREFIX to / to get it to /lib64 if you like. (all in top
Makefile)

Hope it helps,

Regards
Rudolf




