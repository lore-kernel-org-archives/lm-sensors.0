From: hyc@highlandsun.com (Howard Chu)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: Asus A8V Deluxe
Message-Id: <421283C8.7080606@highlandsun.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42120C36.6000107@highlandsun.com>
In-Reply-To: <42120C36.6000107@highlandsun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

OK, a quick followup - comparing with the readings from the BIOS I see 
that fan1 is the case fan, fan3 is the power supply fan. I have an Antec 
Sonata case with the 120mm Antec fan in the rear and a Vantec 120mm 
Stealth fan mounted up front. Both of them are being controlled by the 
power supply. I think the CPU temp readings are a little low compared to 
what the BIOS reports too, but it's hard to verify.

I also started powernowd, and when the CPU goes into low power mode not 
only does the clock frequency drop from 1.8GHz to 1.0GHz, but VCore also 
drops from 1.75V to 1.41V, which triggers an alarm. I suppose I can just 
set a lower minimum for VCore, but I wonder if that might mask a fault 
somewhere down the road?

Howard Chu wrote:
> I just got SuSE 9.2 running on my Asus system, with AMD A64 3000+ 
> processor, and tried to get some meaningful sensors output. Since the 
> bundled sensors package seemed a bit old, I downloaded and built the 2.9 
> source.
> 
> There are a couple of detected chips that aren't totally supported, but 
> I see that one (w83792d) should be appearing soon. Also it detects some 
> SPD EEPROMs on my Fusion HDTV3-T tuner card, but doesn't do anything 
> else with them.
> 
> Just for reference, I've attached the output from sensors-detect and 
> from sensors... fan1 read as zero until I set its divisor to 8. I also 
> tweaked fan2 a bit because even though it was reporting a believable fan 
> speed, the min value was way off. Also I haven't figured out yet which 
> of fan1/fan3 is the case fan vs the PSU fan.
> 
> The +/-12V values are pretty far off, still need to look into that. 
> Since this board has been around for a while - does anyone have 
> suggested settings to use here?
> 
> % sensors
> w83627thf-isa-0290
> Adapter: ISA adapter
> VCore:     +1.75 V  (min =  +1.74 V, max =  +1.91 V)
> +12V:     +11.37 V  (min = +10.82 V, max = +13.19 V)
> +3.3V:     +3.28 V  (min =  +3.14 V, max =  +3.47 V)
> +5V:       +4.93 V  (min =  +4.75 V, max =  +5.25 V)
> -12V:     -14.91 V  (min = -10.80 V, max = -13.18 V)
> V5SB:      +5.08 V  (min =  +4.76 V, max =  +5.24 V)
> VBat:      +0.03 V  (min =  +2.40 V, max =  +3.60 V)
> fan1:     1140 RPM  (min = 1394 RPM, div = 8)
> CPU Fan:  3068 RPM  (min = 1328 RPM, div = 4)
> fan3:     1205 RPM  (min = 1394 RPM, div = 8)
> M/B Temp:    +25??C  (high =   -78??C, hyst =  -126??C)   sensor = 
> thermistor
> CPU Temp:  +34.5??C  (high =   +80??C, hyst =   +75??C)   sensor = 
> thermistor
> vid:      +1.825 V  (VRM Version 9.0)
> alarms:
> beep_enable:
>           Sound alarm disabled
> 
> eeprom-i2c-1-51
> Adapter: SMBus Via Pro adapter at 0400
> Memory type:            DDR SDRAM DIMM
> Memory size (MB):       512
> 
> eeprom-i2c-1-50
> Adapter: SMBus Via Pro adapter at 0400
> Memory type:            DDR SDRAM DIMM
> Memory size (MB):       512


-- 
   -- Howard Chu
   Chief Architect, Symas Corp.       Director, Highland Sun
   http://www.symas.com               http://highlandsun.com/hyc
   Symas: Premier OpenSource Development and Support
