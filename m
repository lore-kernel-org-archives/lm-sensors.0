From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 18 Feb 2006 10:13:18 +0000
Subject: [lm-sensors] MSI KT4V - Strange sensors output.
Message-Id: <20060218111318.6e92aaa5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <ec3d44da0602161608r43dc6653mcc94099d41e3a3e@mail.gmail.com>
In-Reply-To: <ec3d44da0602161608r43dc6653mcc94099d41e3a3e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> Motherboard: MSI KT4V (MSI 6712):
> http://www.msi.com.tw/program/products/mainboard/mbd/pro_mbd_detail.php?UID62
>   Uses KT400, VT8235, w83697hf (last one reported by sensors, not in specs).
> Kernel: Stock debian 2.6.15-1-k7 (2.6.15-4)
> Lm-sensors: Stock debian 2.9.2-8.
> 
> Problem is I get strange output from sensors (-86 C high for temp1)
> and several alarms are tripped even though I'm not an overclocker and
> I never adjust any of the voltages in the BIOS:
> 
>       % sensors
>       w83697hf-isa-0290
>       Adapter: ISA adapter
>       VCore:     +1.78 V  (min =  +1.71 V, max =  +1.89 V)
>       +3.3V:     +3.33 V  (min =  +3.14 V, max =  +3.47 V)
>       +5V:       +5.00 V  (min =  +4.76 V, max =  +5.24 V)
>       +12V:     +12.40 V  (min = +10.82 V, max = +13.19 V)
>       -12V:     -12.11 V  (min = -13.18 V, max = -10.80 V)
>       -5V:       -5.35 V  (min =  -5.25 V, max =  -4.75 V)       ALARM
>       V5SB:      +5.56 V  (min =  +4.76 V, max =  +5.24 V)       ALARM

Well the values are indeed out of the 5% tolerance defined in the
default configuration file. This means that your power supply isn't
doing a very good job for these voltages. If you're worried about this
you may purchase a better power supply, but given that these voltages
are not really important, I'd simply change the configuration file to
10% tolerance for these inputs:

    set in6_max -5 * 0.90
    set in6_min -5 * 1.10
    set in7_min 5 * 0.90
    set in7_max 5 * 1.10

This will still not make it for 5VSB though; it would need 15%, which I
admit is a bit too much. Are there values displayed for these voltages
in the BIOS setup screen? If so, do the values there match the ones
displayed by "sensors"?

>       VBat:      +3.47 V  (min =  +2.40 V, max =  +3.60 V)
>       fan1:     4787 RPM  (min = 3026 RPM, div = 2)
>       fan2:     1834 RPM  (min = 1814 RPM, div = 4)

fan2 is very near from the limit you have set. You should probably lower
that limit a bit if you don't want an alarm to trigger every now and
then.

>       temp1:       +30?C  (high =   -86?C, hyst =   +59?C)   sensor = thermistor
>       temp2:     +50.0?C  (high =   +70?C, hyst =   +67?C)   sensor = thermistor

I'd guess the limits for temp1 were simply never initialized. The
default in sensors.conf (for this chip at least) is to leave the limits
to whatever the BIOS set them. It would seem that your BIOS initialized
the limits for temp2 (CPU temperature) but not for temp1 (system
temperature). The following lines in your configuration file should
help:

    label temp1 "Sys Temp"
    label temp2 "CPU Temp"

    set temp1_over 50
    set temp1_hyst 45

Remember you'll have to run "sensors -s" for the set lines to take
effect.

> In addition to that, I tried using the Tyan settings since that also
> uses KT400/VT8235 and w83697hf.  However, with that configuration, I
> get even more alarms (and temp1 is still listed at high of -86 C).

Settings are really motherboard specific, these special Tyan settings
won't work for you, as you already figured out.

-- 
Jean Delvare

