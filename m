From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 11 Jul 2013 09:18:35 +0000
Subject: Re: [lm-sensors] GA-K8n51GMF-9 Confirugation
Message-Id: <20130711111835.453580a8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAO7ehwzhVcDHUb0UCsZUmemuCn-Dzz=iw2OZik7hRAjLJEhVVg@mail.gmail.com>
In-Reply-To: <CAO7ehwzhVcDHUb0UCsZUmemuCn-Dzz=iw2OZik7hRAjLJEhVVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Denzel,

On Sat, 6 Jul 2013 08:50:16 -0600, Denzel Holmes wrote:
> I searched online for a configuration file for my
> Gigabtye GA-K8n51GMF-9 (C51-MCP51) with no luck.
> I found a configuration file that uses the same chip of 'w83627ehf' and
> made a few modifications for this motherboard.
> Bios on my board doesn't give current readings on any of the voltages so
> it's hard to tell if the readings are correct.

If you have Windows also running on the machine, a good comparison
point is Gigabyte's own monitoring tool.

If you don't, at least the BIOS tells you _what_ is being monitored,
with a small chance in the same order as the "sensors" tool.

> If you are able to improve it you can email me @ eagled2@gmail.com.

Thanks for your contribution. I've added it to the wiki:
  http://www.lm-sensors.org/wiki/Configurations/Gigabyte/K8n51GMF-9
Next time please set the attachment type to text (text/plain.)

Comments:

> # lm_sensors configuration for Gigabyte GA-K8n51GMF-9 (C51-MCP51) Socket 7 motherboard
> 
> chip "k8temp-*"
> 
> ## cpu core temp ##
>  label temp1_input "CPU Core1 Temp"
>  label temp3_input "CPU Core2 Temp"
> 
> chip "w83627ehf-*"
> 
> ## Voltage ##
>  
>  label in0 "VCore" # CPU Core Voltage
>  label in1 "VPCIEx" # PCI Express Voltage

What is in1's value?

>  label in2 "AVCC"
>  label in3 "3VCC"
>  label in4 "In4"
>  label in5 "In5"

These are useless labels. If you don't know what these are, don't put
labels at all. If the values make no sense, ignore the inputs. I would
be able to help more if you showed us a sample output of "sensors" and
"sensors -c /dev/null" on your machine.

>  label in6 "+ 3.3V" # +3.3V, or so i think

That would be surprising given that in2 and in3 are already monitoring
that. It is likely that in4, in5 or in6 is +5V.

>  label in7 "3VSB"
>  label in8 "VBAT"
>  label in9 "+ 12V" # +12V, or so i think
> 
> ## +12V is in9 and +5V is in6 ##

This is contradictory with the in6 label above.

>  compute in9 @*(1+(56/10)), @/(1+(56/10))
>  compute in6 @*1.78, @/1.78
> 
>  set in9_min 12.0*0.7916

What a weird scaling factor.

>  set in9_max 12.0*1.1
>  set in6_min 3.3*0.9
>  set in6_max 3.3*1.10
> 
>  set in0_min 0.9
>  set in0_max 1.7
>  set in1_min 1.3
>  set in1_max 2.0

These limits are so loose that they are hardly useful.

>  set in2_min 3.3*0.9
>  set in2_max 3.3*1.1
>  set in3_min 3.3*0.9
>  set in3_max 3.3*1.1
>  set in4_min 1.4
>  set in4_max 1.6
>  set in5_min 1.86
>  set in5_max 1.9
>  set in7_min 3.3*0.9
>  set in7_max 3.3*1.1
>  set in8_min 3.0*0.9
>  set in8_max 3.3*1.1

Note that the ATX specification sets a +/- 5% limit for +3.3V, +5V and
+12V, this is what you should use here too.

>  
>  ## Temperatures ##
> 
>  label temp1 "Sys Temp"
>  label temp2 "CPU Temp"
>  label temp3 "Aux Temp"
> 
>  set temp1_max 55
>  set temp1_max_hyst 48
>  set temp2_max 55
>  set temp2_max_hyst 47
>  set temp3_max 55
>  set temp3_max_hyst 50
> 
> ## Fans ##
> 
>  label fan1 "PSU Fan"

According to the manual it is named Sys Fan on the board and in the
BIOS.

>  label fan2 "CPU Fan"
>  
>  set fan2_min 800
> 
>  ignore fan3
>  ignore fan4
>  ignore fan5
> 
>  label cpu0_vid "GPU Voltage"

No, CPU0_vid is the nominal CPU voltage, it has nothing to do with the
GPU. For fixed voltage CPU it lets you set the in0 limits easily. For
dynamic voltage CPU it is not so useful (in particular if the hwmon
driver only samples it at initialization time.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
