From: chris@ripptech.com (Chris Ripp)
Date: Sun, 19 Jun 2005 18:23:30 +0000
Subject: [lm-sensors] Req for sensors help w/ Asus PC-DL
Message-Id: <42B59BE9.1090608@ripptech.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42B4EC0B.1020603@ripptech.com>
In-Reply-To: <42B4EC0B.1020603@ripptech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:

>Hi,
>
>We are suspecting that you have enabled in kernel ACPI PNP stuff. Please disable it pernamently or try
>pnpacpi=off
>
>as kernel parameter. (the parameter will work for 2.6.11 or 2.6.12)
>If it works and you can read sensors I will advise more how to get CPU temps directly from CPU...
>
>Regards
>Rudolf
>  
>
ha! That figures.  Not sure when that pnpacpi option was added or when I
turned it on, but that was the cure.  Brilliant!

w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.47 V  (min =  +0.70 V, max =  +1.87 V)
+12V:     +11.92 V  (min =  +3.16 V, max =  +3.89 V)       ALARM
+3.3V:     +3.26 V  (min =  +0.13 V, max =  +0.03 V)       ALARM
+5V:       +4.91 V  (min =  +3.63 V, max =  +3.44 V)       ALARM
-12V:     -14.91 V  (min = -14.91 V, max = -14.91 V)       ALARM
V5SB:      +5.05 V  (min =  +0.11 V, max =  +0.03 V)       ALARM
VBat:      +3.10 V  (min =  +2.83 V, max =  +0.26 V)       ALARM
fan1:     3750 RPM  (min = 3125 RPM, div = 2)
CPU Fan:  5487 RPM  (min =   -1 RPM, div = 2)              ALARM
fan3:     5532 RPM  (min = 10546 RPM, div = 2)              ALARM
M/B Temp:    +46 C  (high =    +0 C, hyst =    +0 C)   sensor thermistor   ALARM
CPU Temp:  +41.5 C  (high =   +80 C, hyst =   +75 C)   sensor = thermistor
temp3:     +39.0 C  (high =   +80 C, hyst =   +75 C)   sensor = thermistor
vid:      +0.275 V  (VRM Version 9.0)
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled

I think I can figure out the labels etc. from here, unless you're
talking about something else w/ the CPU temps?

Thanks again!

