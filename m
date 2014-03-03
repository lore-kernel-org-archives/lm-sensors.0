From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 03 Mar 2014 08:10:30 +0000
Subject: Re: [lm-sensors] sensors.conf for Gigabyte B75-D3V
Message-Id: <20140303091030.5c885df8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <005901cf33ae$ccc48130$664d8390$@gmx.de>
In-Reply-To: <005901cf33ae$ccc48130$664d8390$@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dominik,

On Fri, 28 Feb 2014 11:18:46 +0100, Dominik Egert wrote:
> Sorry for the malformed configuration file. - I am really having trouble
> with the configuration, as it seems. 
> After checking back to the machine running this configuration, I noticed it
> was beeping. - Unstoppable beeping every time I set the min/max values by
> calling sensors -s
> 
> Could you give me a hint on what I am doing wrong, please.
> (BTW: I recognized the in0_min and in0_max are not taken into account.)

Bug in your config file, see below. Possibly responsible for the
beeping BTW.

> Sensors -v: sensors version 3.3.2 with libsensors version 3.3.2 (on Debian,
> from package)
> 
> Sorry for this long mail.
> 
> The config:
> ######################
> # libsensors configuration file
> # -----------------------------
> #
> #  For the Gigabyte B75-D3V Rev: 1.2
> #
> #
> #
> 
> 
> ##############################################
> chip "it8728-isa-0a30"
> 
> ########
> # Fans
> label fan1 "CPU-Fan"
> set fan1_min 1000
> 
> label fan2 "System Fan 1"
> set fan2_min 450
> 
> ignore fan3 #"System Fan 2"
> set fan3_min 450

You shouldn't set a minimum for a fan you ignore. If it triggers an
alarm, you won't see it.

> 
> label fan4 "System Fan 3"
> set fan4_min 450
> 
> ignore fan5 #"Chassis Fan"
> 
> ################
> # Temperatures
> label temp1 "CPU Chip Temperature"
> set temp1_min 10
> set temp1_max 60
> set temp1_offset 55

This offset looks plain wrong.

> 
> ignore temp2 #"Unknown"

What value did it display?

> label temp3 "System Temperature"

PECI sensors are typically for the CPU or the PCH chipset, so I very
much doubt this can be the (ambient) system temperature.

> set temp3_min 10
> set temp3_max 55
> set temp3_offset 50

PECI offsets should be set by the BIOS, you shouldn't have to do that.

> 
> ############
> # Voltages

I am curious how you found the mappings and scaling factors?

> label in0 "Vtt"
> set in0_min 1.020
> set in0_max 1.080
> 
> label in1 "+3.3V"
> set in1_min 3.135
> set in1_max 3.465
> compute in1 1.635*@,@/1.635
> 
> label in2 "+12V"
> set in2_min 11.400
> set in2_max 12.600
> compute in2 6.0*@,@/6.0
> 
> label in3 "+5V"
> set in3_min 4.750
> set in3_max 5.250
> compute in3 2.5*@,@/2.5
> 
> label in4 "Vaxg IGD"
> set in4_min 0.800
> set in4_max 1.000
> 
> label in5 "CPU Vcore"
> set in5_min 0.750
> set in5_max 1.150
> 
> label in6 "Dram Voltage"
> set in6_min 1.450
> set in6_max 1.550
> 
> label in7 "3.3 VSB"
> set in7_min 3.150
> set in7_max 3.450

These limits should not be stricter than the ones of +3.3V. They should
be the same.

> 
> label in8 "Vbat"
> set in0_min 2.700
> set in0_max 3.300

You really mean in8_min and and in8_max here!

> 
> # Other sensor readings
> label intrusion0 "Chassis Open"
> set intrusion0_alarm 0
> 
> 
> ##############################################
> chip "coretemp-*"
> 
> label temp1 "CPU Chip Temperature"

Technically this is the "CPU Package Temperature".

> label temp2 "CPU Core 1 Temperature"
> label temp3 "CPU Core 2 Temperature"
> 
> 
> ##############################################
> chip "pkg-*"
> 
> label temp1 "ACPI Thermal CPU"
> 
> 

This value has nothing to do with ACPI, so the label is wrong. You
might as well drop this section anyway, as this driver will soon stop
instantiating a hwmon device.

> ##############################################
> chip "acpitz-virtual-0"
> 
> label temp1 "ACPI Thermal Zone 0 Temp1"
> label temp2 "ACPI Thermal Zone 0 Temp2"
> ######################
> 
> 
> The Output of sensors, sensors -u, sensors -s, sensors -u
> After sensors -s the beeping starts. - But why?

Either because of the wrong in0 limits, or because of the odd
temperature offsets, or because of the unmet fan3_min (can't tell as
long as it is ignored in the configuration file - remove the ignore
statement for diagnostics.)

-- 
Jean Delvare
http://jdelvare.nerim.net/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
