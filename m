From: Andreas Hollmann <hollmann@in.tum.de>
Date: Mon, 10 Mar 2014 11:53:04 +0000
Subject: Re: [lm-sensors] Possibility to read temperature sensor on registered DDR3 DIMMs?
Message-Id: <CAGz0_-2_1V1FDJCp=ohFRThhR=HmwjqHYNs5andiMj5_ERcaaQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGz0_-1Y9Qos3qm8AAejhTxtZPeE9VH_ZCmscOY-R6QU-VkWDQ@mail.gmail.com>
In-Reply-To: <CAGz0_-1Y9Qos3qm8AAejhTxtZPeE9VH_ZCmscOY-R6QU-VkWDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

thank you for your reply on this topic.

I have another question regarding the temperatures.

How can I identify the device for the temperatures that
are shown below (temp0 to temp10)?

It also seems that there are no devices found which need the jc42
module? This means no temperatures are shown for memory dimms?

Best regards,
Andreas Hollmann



[hollmann@inwest ~]$ modprobe jc42
[hollmann@inwest ~]$ modprobe w83795
[hollmann@inwest ~]$ sudo sensors-detect
# sensors-detect revision 6209 (2014-01-14 22:51:58 +0100)
# System: Supermicro X8QB6 [1.0]

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):
Module cpuid loaded successfully.
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
AMD Family 12h and 14h thermal sensors...                   No
AMD Family 15h thermal sensors...                           No
AMD Family 15h power sensors...                             No
AMD Family 16h power sensors...                             No
Intel digital thermal sensor...                             Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
Found `Winbond W83627DHG-P/W83527HG Super IO Sensors'
    (address 0x290, but not activated)
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no):
Found `IPMI BMC KCS' at 0xca2...                            Success!
    (confidence 8, driver `to-be-written')

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Using driver `i2c-i801' for device 0000:00:1f.3: Intel ICH10
Module i2c-dev loaded successfully.

Next adapter: SMBus I801 adapter at 0400 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x2f
Probing for `National Semiconductor LM78'...                No
Probing for `National Semiconductor LM79'...                No
Probing for `National Semiconductor LM80'...                No
Probing for `National Semiconductor LM96080'...             No
Probing for `Analog Devices ADT7470'...                     No
Probing for `Winbond W83781D'...                            No
Probing for `Winbond W83782D'...                            No
Probing for `Winbond W83791D'...                            No
Probing for `Winbond W83792D'...                            No
Probing for `Winbond W83793R/G'...                          No
Probing for `Nuvoton W83795G/ADG'...                        Success!
    (confidence 8, driver `w83795')
Probing for `Winbond W83627HF'...                           No
Probing for `Winbond W83627EHF'...                          No
Probing for `Winbond W83627DHG/W83667HG/W83677HG'...        No
Probing for `Asus AS99127F (rev.1)'...                      No
Probing for `Asus AS99127F (rev.2)'...                      No
Probing for `Asus ASB100 Bach'...                           No
Probing for `Winbond W83L786NR/NG/R/G'...                   No
Probing for `Analog Devices ADM9240'...                     No
Probing for `Dallas Semiconductor DS1780'...                No
Probing for `National Semiconductor LM81'...                No
Probing for `Maxim MAX6639'...                              No
Probing for `Analog Devices ADM1029'...                     No
Probing for `ITE IT8712F'...                                No
Probing for `SMSC EMC2104'...                               No
Probing for `Fintek custom power control IC'...             No
Probing for `Winbond W83791SD'...                           No


Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `coretemp':
  * Chip `Intel digital thermal sensor' (confidence: 9)

Driver `to-be-written':
  * ISA bus, address 0xca2
    Chip `IPMI BMC KCS' (confidence: 8)

Driver `w83795':
  * Bus `SMBus I801 adapter at 0400'
    Busdriver `i2c_i801', I2C address 0x2f
    Chip `Nuvoton W83795G/ADG' (confidence: 8)

Note: there is no driver for IPMI BMC KCS yet.
Check http://www.lm-sensors.org/wiki/Devices for updates.

Do you want to overwrite /etc/conf.d/lm_sensors? (YES/no):
Unloading i2c-dev... OK
Unloading cpuid... OK

[hollmann@inwest ~]$ ls -la /etc/conf.d/lm_sensors
-rw-r--r-- 1 root root 416 Mar 10 12:38 /etc/conf.d/lm_sensors
[hollmann@inwest ~]$ sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:       +35.0 C  (high = +86.0 C, crit = +94.0 C)
Core 1:       +36.0 C  (high = +86.0 C, crit = +94.0 C)
Core 2:       +36.0 C  (high = +86.0 C, crit = +94.0 C)
Core 8:       +34.0 C  (high = +86.0 C, crit = +94.0 C)
Core 9:       +36.0 C  (high = +86.0 C, crit = +94.0 C)
Core 16:      +36.0 C  (high = +86.0 C, crit = +94.0 C)
Core 17:      +31.0 C  (high = +86.0 C, crit = +94.0 C)
Core 18:      +34.0 C  (high = +86.0 C, crit = +94.0 C)
Core 24:      +40.0 C  (high = +86.0 C, crit = +94.0 C)
Core 25:      +31.0 C  (high = +86.0 C, crit = +94.0 C)

coretemp-isa-0001
Adapter: ISA adapter
Core 0:       +32.0 C  (high = +86.0 C, crit = +94.0 C)
Core 1:       +42.0 C  (high = +86.0 C, crit = +94.0 C)
Core 2:       +30.0 C  (high = +86.0 C, crit = +94.0 C)
Core 8:       +31.0 C  (high = +86.0 C, crit = +94.0 C)
Core 9:       +36.0 C  (high = +86.0 C, crit = +94.0 C)
Core 16:      +38.0 C  (high = +86.0 C, crit = +94.0 C)
Core 17:      +36.0 C  (high = +86.0 C, crit = +94.0 C)
Core 18:      +34.0 C  (high = +86.0 C, crit = +94.0 C)
Core 24:      +32.0 C  (high = +86.0 C, crit = +94.0 C)
Core 25:      +32.0 C  (high = +86.0 C, crit = +94.0 C)

coretemp-isa-0002
Adapter: ISA adapter
Core 0:       +31.0 C  (high = +86.0 C, crit = +94.0 C)
Core 1:       +37.0 C  (high = +86.0 C, crit = +94.0 C)
Core 2:       +39.0 C  (high = +86.0 C, crit = +94.0 C)
Core 8:       +36.0 C  (high = +86.0 C, crit = +94.0 C)
Core 9:       +33.0 C  (high = +86.0 C, crit = +94.0 C)
Core 16:      +31.0 C  (high = +86.0 C, crit = +94.0 C)
Core 17:      +34.0 C  (high = +86.0 C, crit = +94.0 C)
Core 18:      +33.0 C  (high = +86.0 C, crit = +94.0 C)
Core 24:      +36.0 C  (high = +86.0 C, crit = +94.0 C)
Core 25:      +33.0 C  (high = +86.0 C, crit = +94.0 C)

coretemp-isa-0003
Adapter: ISA adapter
Core 0:       +35.0 C  (high = +86.0 C, crit = +94.0 C)
Core 1:       +37.0 C  (high = +86.0 C, crit = +94.0 C)
Core 2:       +38.0 C  (high = +86.0 C, crit = +94.0 C)
Core 8:       +34.0 C  (high = +86.0 C, crit = +94.0 C)
Core 9:       +35.0 C  (high = +86.0 C, crit = +94.0 C)
Core 16:      +34.0 C  (high = +86.0 C, crit = +94.0 C)
Core 17:      +37.0 C  (high = +86.0 C, crit = +94.0 C)
Core 18:      +37.0 C  (high = +86.0 C, crit = +94.0 C)
Core 24:      +34.0 C  (high = +86.0 C, crit = +94.0 C)
Core 25:      +33.0 C  (high = +86.0 C, crit = +94.0 C)

w83795adg-i2c-0-2f
Adapter: SMBus I801 adapter at 0400
in0:          +0.88 V  (min =  +0.54 V, max =  +1.49 V)
in1:          +1.01 V  (min =  +0.90 V, max =  +1.11 V)
in2:          +1.22 V  (min =  +1.08 V, max =  +1.33 V)
in3:          +1.82 V  (min =  +1.62 V, max =  +1.99 V)
in4:          +1.13 V  (min =  +0.98 V, max =  +1.21 V)
in5:          +0.84 V  (min =  +0.54 V, max =  +1.49 V)
in6:          +0.87 V  (min =  +0.54 V, max =  +1.49 V)
in7:          +0.82 V  (min =  +0.54 V, max =  +1.49 V)
in11:         +1.12 V  (min =  +0.92 V, max =  +1.35 V)
+3.3V:        +3.20 V  (min =  +2.96 V, max =  +3.63 V)
3VSB:         +3.19 V  (min =  +2.96 V, max =  +3.63 V)
Vbat:         +3.32 V  (min =  +2.70 V, max =  +3.63 V)
in15:         +1.87 V  (min =  +1.63 V, max =  +1.99 V)
in16:         +1.52 V  (min =  +1.35 V, max =  +1.65 V)
fan1:        4397 RPM  (min =  709 RPM)
fan2:           0 RPM  (min =  709 RPM)  ALARM
fan3:        4231 RPM  (min =  709 RPM)
fan4:           0 RPM  (min =  709 RPM)  ALARM
fan5:        4440 RPM  (min =  709 RPM)
fan6:           0 RPM  (min =  709 RPM)  ALARM
fan7:           0 RPM  (min =  709 RPM)  ALARM
fan8:        4623 RPM  (min =  709 RPM)
fan9:        4821 RPM  (min =  709 RPM)
fan10:       4856 RPM  (min =  709 RPM)
fan11:          0 RPM  (min =  329 RPM)  ALARM
fan12:       5744 RPM  (min =  709 RPM)
temp1:        +44.2 C  (high = +85.0 C, hyst = +80.0 C)
                       (crit = +75.0 C, hyst = +70.0 C)  sensor = thermal diode
temp2:        +46.0 C  (high = +85.0 C, hyst = +80.0 C)
                       (crit = +75.0 C, hyst = +70.0 C)  sensor = thermal diode
temp3:        +52.5 C  (high = +85.0 C, hyst = +80.0 C)
                       (crit = +75.0 C, hyst = +70.0 C)  sensor = thermal diode
temp4:        +43.8 C  (high = +85.0 C, hyst = +80.0 C)
                       (crit = +75.0 C, hyst = +70.0 C)  sensor = thermal diode
temp7:        +45.5 C  (high = +95.0 C, hyst = +92.0 C)
                       (crit = +95.0 C, hyst = +92.0 C)  sensor = Intel PECI
temp8:        +48.0 C  (high = +95.0 C, hyst = +92.0 C)
                       (crit = +95.0 C, hyst = +92.0 C)  sensor = Intel PECI
temp9:        +45.5 C  (high = +95.0 C, hyst = +92.0 C)
                       (crit = +95.0 C, hyst = +92.0 C)  sensor = Intel PECI
temp10:       +43.2 C  (high = +95.0 C, hyst = +92.0 C)
                       (crit = +95.0 C, hyst = +92.0 C)  sensor = Intel PECI
intrusion0:  OK

2014-03-03 22:27 GMT+01:00 Jean Delvare <jdelvare@suse.de>:
> On Mon, 3 Mar 2014 21:52:43 +0100, Andreas Hollmann wrote:
>> Hi,
>>
>> I have a 4-socket system with 256 GB RAM (32 x 8 GB).
>>
>> Socket 0 shows unstable behavior when running the stream
>> benchmark. It runs well for some time and then the performance
>> drops to 50 %. It seems like throttling of some component.
>>
>> The CPU temperatures are very low and therefore I consider
>> it a problem with one of the 8 DIMM modules on Socket 0.
>>
>> Is there any way to read the temperature?
>
> Yes, it is supported by the jc42 driver. If you are lucky, you can just
> load it and enjoy.
>
> However, on such a beast of a board, odds are that the SMBus is
> multiplexed and you will need proper support for that in order to see
> all DDR3 temperature sensors.
>
> SMBus multiplexing is board-specific so you will have to ask the vendor
> for technical details on how SMBus multiplexing is implemented on your
> specific board. With sufficient information, we can add support to
> Linux for you.
>
> --
> Jean Delvare
> SUSE L3 Support

2014-03-03 22:27 GMT+01:00 Jean Delvare <jdelvare@suse.de>:
> On Mon, 3 Mar 2014 21:52:43 +0100, Andreas Hollmann wrote:
>> Hi,
>>
>> I have a 4-socket system with 256 GB RAM (32 x 8 GB).
>>
>> Socket 0 shows unstable behavior when running the stream
>> benchmark. It runs well for some time and then the performance
>> drops to 50 %. It seems like throttling of some component.
>>
>> The CPU temperatures are very low and therefore I consider
>> it a problem with one of the 8 DIMM modules on Socket 0.
>>
>> Is there any way to read the temperature?
>
> Yes, it is supported by the jc42 driver. If you are lucky, you can just
> load it and enjoy.
>
> However, on such a beast of a board, odds are that the SMBus is
> multiplexed and you will need proper support for that in order to see
> all DDR3 temperature sensors.
>
> SMBus multiplexing is board-specific so you will have to ask the vendor
> for technical details on how SMBus multiplexing is implemented on your
> specific board. With sufficient information, we can add support to
> Linux for you.
>
> --
> Jean Delvare
> SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
