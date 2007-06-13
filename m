From: linux@horizon.com
Date: Wed, 13 Jun 2007 09:27:34 +0000
Subject: Re: [lm-sensors] Trying to get a w83627hf working
Message-Id: <20070613092734.21654.qmail@science.horizon.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070613063021.28033.qmail@science.horizon.com>
In-Reply-To: <20070613063021.28033.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Anyway, new motherboard, and new sensors chip.  Yes, the BIOS reports
> reasonable values.   sensors-detect detects the W83627HF-AW chip I
> can see on the motherboard (Abit AX8, if anyone cares).  But sensors(1)
> reports garbage:

Ah.  Figured it out.  The motherboard isn't using the hardware monitor
features of the w83627hf.  It's an Abit motherboard, so I need the
abituguru driver.

Then everything works:

abituguru-isa-00e0
Adapter: ISA adapter
CPU Core Voltage:       +1.40 V (min  +0.00 V, max  +1.70 V)
DDR Voltage:            +2.64 V (min  +2.40 V, max  +2.89 V)
DDR VTT Voltage:        +1.33 V (min  +1.21 V, max  +1.45 V)
NB Voltage:             +1.59 V (min  +1.40 V, max  +1.70 V)
SB Voltage:             +2.52 V (min  +2.25 V, max  +2.74 V)
HyperTransport Voltage: +1.22 V (min  +0.94 V, max  +1.45 V)
AGP VDDQ Voltage:       +2.85 V (min  +2.22 V, max  +3.34 V)
ATX +5V:                +4.78 V (min  +3.77 V, max  +5.63 V)
ATX +3.3V:              +3.57 V (min  +2.77 V, max  +4.17 V)
Standby Voltage (+5V):  +5.27 V (min  +4.12 V, max  +6.17 V)
ERROR: Can't get IN data! (0x000b)
CPU Temperature:          +35 C  (high =   +65 C, crit =   +85 C)  
SYS Temperature:          +28 C  (high =   +50 C, crit =   +65 C)  
PWM Temperature:          +30 C  (high =   +70 C, crit =   +90 C)  
CPU FAN Speed:         3060 RPM (min 1200 RPM)               
NB FAN Speed:          4920 RPM (min 1200 RPM)               
SYS FAN Speed:         4860 RPM (min 1200 RPM)               
AUX1 FAN Speed:           0 RPM (min 1200 RPM)               
AUX2 FAN Speed:           0 RPM (min  300 RPM)               

Unfortunately, I can only set the thresholds with the BIOS, but data is
available.

The 5V worked because it uses the power supply pin which IS wired
up.  I could also monitor the battery voltage if I liked.  But the
other features are garbage because they're not connected.

Sorry for the false alarm!

(And I'm sorry to have supported a manufacturer that won't document
their hardware; it was available in a hurry when I needed it.)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
