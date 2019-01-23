From: Mikko Laaksonen <mikko.praha@gmail.com>
Date: Wed, 23 Jan 2019 14:05:22 +0000
Subject: Re: Intel X550-T2
Message-Id: <eb4c4dd5-c081-2c18-b833-3d1cae10e514@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4e3b24db-7946-23f8-3f95-650b29f28a17@gmail.com>
In-Reply-To: <4e3b24db-7946-23f8-3f95-650b29f28a17@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hello,

Sensors gives just the basics:

coretemp-isa-0001
Adapter: ISA adapter
Package id 1:  +18.0°C  (high = +80.0°C, crit = +90.0°C)
Core 0:        +11.0°C  (high = +80.0°C, crit = +90.0°C)
Core 1:        +12.0°C  (high = +80.0°C, crit = +90.0°C)
Core 2:        +11.0°C  (high = +80.0°C, crit = +90.0°C)
Core 3:        +11.0°C  (high = +80.0°C, crit = +90.0°C)
Core 4:        +12.0°C  (high = +80.0°C, crit = +90.0°C)
Core 5:        +11.0°C  (high = +80.0°C, crit = +90.0°C)

nouveau-pci-0200
Adapter: PCI adapter
GPU core:     +0.90 V  (min =  +0.85 V, max =  +1.05 V)
temp1:        +47.0°C  (high = +95.0°C, hyst =  +3.0°C)
                        (crit = +105.0°C, hyst =  +5.0°C)
                        (emerg = +135.0°C, hyst =  +5.0°C)

nct7904-i2c-12-2d
Adapter: SMBus I801 adapter at 0580
in1:          +0.95 V
in2:          +1.04 V
in3:          +1.49 V
in4:          +1.23 V
in5:          +1.26 V
in6:          +0.30 V
in7:          +1.81 V
in8:          +0.47 V
in9:          +1.79 V
in10:         +1.79 V
in11:         +1.20 V
in12:         +1.20 V
in13:         +1.20 V
in14:         +1.20 V
in15:         +3.22 V
in16:         +3.20 V
in20:         +3.38 V
fan1:        2343 RPM
fan2:        2368 RPM
fan3:        2481 RPM
fan4:        1288 RPM
fan5:           0 RPM
fan6:        2389 RPM
fan7:        1280 RPM
fan8:           0 RPM
temp1:        +30.8°C
temp2:        +17.6°C
temp3:        +17.8°C

coretemp-isa-0000
Adapter: ISA adapter
Package id 0:  +17.0°C  (high = +80.0°C, crit = +90.0°C)
Core 0:        +11.0°C  (high = +80.0°C, crit = +90.0°C)
Core 1:        +11.0°C  (high = +80.0°C, crit = +90.0°C)
Core 2:        +11.0°C  (high = +80.0°C, crit = +90.0°C)
Core 3:        +12.0°C  (high = +80.0°C, crit = +90.0°C)
Core 4:        +11.0°C  (high = +80.0°C, crit = +90.0°C)
Core 5:        +12.0°C  (high = +80.0°C, crit = +90.0°C)


and cat /sys/class/hwmon/*/name gives

nouveau
coretemp
coretemp
nct7904

lspci | grep -i eth gives

03:00.0 Ethernet controller: Intel Corporation Ethernet Controller 10G X550T (rev 01)
03:00.1 Ethernet controller: Intel Corporation Ethernet Controller 10G X550T (rev 01)
05:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network Connection (rev 03)
06:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network Connection (rev 03)

from which I get with

find /sys | grep drivers.*03:00.1

/sys/bus/pci/drivers/ixgbe/0000:03:00.1

--
Mikko

On 1/23/2019 2:54 PM, Ondřej Lysoněk wrote:
> Hi,
>
> On 23. 01. 19 13:15, Mikko Laaksonen wrote:
>> Hello,
>>
>> I would like to know how I can go about adding support for an Intel
>> X550-T2 PCI-E network card in lm_sensors. The card comes with a number
>> of sensors, including temperature, and a 1,200-page reference manual.
>> sensors-detect does not recognize the card off the shelf.
> Detection support in sensors-detect doesn't mean much, so I'd first
> focus on whether data from the sensors is exported by the driver.
> Looking at the ixgbe driver (am I looking at the correct driver?), it
> does register a hwmon device, so the data could be available. Let's
> verify that - what's the output of the 'sensors' program and the output
> of 'cat /sys/class/hwmon/*/name'?
>
> Ondra
