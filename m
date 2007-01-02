From: r.marek@assembler.cz (Rudolf Marek)
Date: Tue, 02 Jan 2007 19:07:24 +0000
Subject: [lm-sensors] strange output values from W83627HG chip
Message-Id: <459AAD6C.3090203@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1167384671.4594e05f0a0df@www.inbox.lv>
In-Reply-To: <1167384671.4594e05f0a0df@www.inbox.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jurijs Petrovs wrote:
> Hi!
> First, happy new year to all!

Ah so optimistic beginning ;)

> Many thanks for your advice, Rudolf!
> I loaded correct driver w83793 and updated lm-sensors. Right after that
> I saw correct values from sensor command. As you asked, here is report 
> of these values (I just corrected computing formula for "-12V" sensor
> and set ignore to unused FANs):


Good.

> w83793-i2c-0-2f
> Adapter: SMBus I801 adapter at 1100
> VCoreA: +1.23 V (min = +0.92 V, max = +1.49 V)
> VCoreB: +1.23 V (min = +0.92 V, max = +1.49 V)
> Vtt: +1.19 V (min = +1.08 V, max = +1.33 V)
> -12V: -12.81 V (min = -13.14 V, max = -11.57 V)
> P1V5: +1.49 V (min = +1.34 V, max = +1.65 V)
> +3.3V: +3.33 V (min = +2.96 V, max = +3.63 V)
> +12V: +12.19 V (min = +10.75 V, max = +13.25 V)
> +5V: +4.85 V (min = +4.49 V, max = +5.50 V)
> 5VSB: +5.02 V (min = +4.49 V, max = +5.50 V)
> VBAT: +3.15 V (min = +2.99 V, max = +3.66 V)
> fan1: 3770 RPM (min = 712 RPM)
> fan2: 3668 RPM (min = 712 RPM)
> fan4: 1230 RPM (min = 712 RPM)
> fan5: 1254 RPM (min = 712 RPM)
> CPU1 Temp: +24.0?C (high = +75.0?C, hyst = +70.0?C)
> CPU2 Temp: +22.0?C (high = +75.0?C, hyst = +70.0?C)
> temp3: +30.5?C (high = +75.0?C, hyst = +70.0?C)
> temp4: -128.0?C (high = +75.0?C, hyst = +70.0?C)

Looks like temp4 is not connected.

> temp5: +35?C (high = +50?C, hyst = +45?C)
> temp6: +16?C (high = +100?C, hyst = +95?C)
> cpu0_vid: +0.019 V (VRM Version 11.0)
> cpu1_vid: +0.019 V (VRM Version 11.0) 
> 
> 
> Very strange that motherboard specification on the original manufacturer
> site shows Winbond W83627HG chip. Is it error on site or my own
> misunderstanding of docs?
> 
> http://www.supermicro.com/products/motherboard/Xeon1333/5000V/X7DVA-E.cfm
> 
> And where I can get _right_ description of temperature sensors for
> temp3-temp6 sensors?

In manual, (intel usually creates a technical document about MB and there is
written where sensors are)

I just checked and it is not there... But they may used what was recommended by
Winbond

temp5-temp6 are thermistors placed somewhere on the board. (Is 16C likely?)
temp1-temp4 could be disabled, monitored through PECI or analog - thermal diode.

Please go to:

cd /sys/class/hwmon/hwmon0/device
cat name
cat temp?_type

It will show the actual type. You could also RTFM in
kernel/Documentation/hwmon/w83793 ;)))

Please provide the output so we know what is what

Jean,

This reminds me... This would be great case for the tempX_label file, so it will
show the string "None" "Thermal diode" "PECI" ...

Do you like that idea?

Rudolf


