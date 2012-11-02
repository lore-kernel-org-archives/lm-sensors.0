From: Logan Freijo <loganfreijo@embarqmail.com>
Date: Fri, 02 Nov 2012 05:29:40 +0000
Subject: Re: [lm-sensors] f71882fg not showing motherboard temps
Message-Id: <50935A44.5010501@embarqmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5091A80D.3090101@embarqmail.com>
In-Reply-To: <5091A80D.3090101@embarqmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 11/1/2012 11:20 PM, Guenter Roeck wrote:
> Hi,
>
> On Thu, Nov 01, 2012 at 01:34:35PM -0400, Logan Freijo wrote:
>
> [ ... ]
>
>> After my last reply I searched the web again and noticed that some
>> places indicate "acpi-enforce-resources=lax" and others
>> "acpi_enforce_resources=lax". So I decided to try all options again.
>> I found after several reboots that "pnpacpi=off" did when I passed
>> it by itself. I now have a full range of sensor readings. Is there
> Would be great if you can provide the logs Hans asked for.
>
>> anyway to determine which sensor is which? My output for sensors is
>> below. in1 - in6 seem to be reading incorrect values.
>>
> Not incorrect - simple reason is that there are voltage dividers on the board.
> Tricky part now is to find out what the divider values are. A good starting point
> is http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling.
>
> Thanks,
> Guenter
>
>> Thanks,
>>
>> Logan
>>
>> f71882fg-isa-0220
>> Adapter: ISA adapter
>> +3.3V:        +3.50 V
>> in1:          +1.06 V  (max =  +2.04 V)
>> in2:          +0.42 V
>> in3:          +0.98 V
>> in4:          +1.13 V
>> in5:          +0.96 V
>> in6:          +0.75 V
>> 3VSB:         +3.31 V
>> Vbat:         +3.33 V
>> fan1:        1492 RPM
>> fan2:           0 RPM  ALARM
>> fan3:        1007 RPM
>> fan4:           0 RPM  ALARM
>> temp1:        +33.0 C  (high = +85.0 C, hyst = +81.0 C)
>>                         (crit = +100.0 C, hyst = +96.0 C)  sensor >> transistor
>> temp2:        +32.0 C  (high = +85.0 C, hyst = +81.0 C)
>>                         (crit = +100.0 C, hyst = +96.0 C)  sensor >> transistor
>> temp3:        +32.0 C  (high = +70.0 C, hyst = +68.0 C)
>>                         (crit = +85.0 C, hyst = +83.0 C)  sensor >> transistor
>>
>> k10temp-pci-00c3
>> Adapter: PCI adapter
>> CPU Temp:     +26.1 C  (high = +70.0 C)
>>
>>
Here is the new output for "cat /proc/ioports"

0000-0cf7 : PCI Bus 0000:00
   0000-001f : dma1
   0020-0021 : pic1
   0040-0043 : timer0
   0050-0053 : timer1
   0060-0060 : keyboard
   0064-0064 : keyboard
   0070-0071 : rtc_cmos
     0070-0071 : rtc0
   0080-008f : dma page reg
   00a0-00a1 : pic2
   00c0-00df : dma2
   00f0-00ff : fpu
   0170-0177 : 0000:00:14.1
     0170-0177 : pata_atiixp
   01f0-01f7 : 0000:00:14.1
     01f0-01f7 : pata_atiixp
   0220-0227 : f71882fg
   0376-0376 : 0000:00:14.1
     0376-0376 : pata_atiixp
   03f6-03f6 : 0000:00:14.1
     03f6-03f6 : pata_atiixp
   0800-0803 : ACPI PM1a_EVT_BLK
   0804-0805 : ACPI PM1a_CNT_BLK
   0808-080b : ACPI PM_TMR
   0810-0815 : ACPI CPU throttle
   0820-0827 : ACPI GPE0_BLK
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
   8000-800f : 0000:00:11.0
     8000-800f : ahci
   9000-9003 : 0000:00:11.0
     9000-9003 : ahci
   a000-a007 : 0000:00:11.0
     a000-a007 : ahci
   b000-b003 : 0000:00:11.0
     b000-b003 : ahci
   c000-c007 : 0000:00:11.0
     c000-c007 : ahci
   d000-dfff : PCI Bus 0000:01
     d000-d0ff : 0000:01:05.0
   e000-efff : PCI Bus 0000:02
     e800-e8ff : 0000:02:00.0
       e800-e8ff : r8169
   ff00-ff0f : 0000:00:14.1
     ff00-ff0f : pata_atiixp


Device 09 no longer shows up.
ls -lR /sys/bus/pnp/devices/00\:09/
and
cat /sys/bus/pnp/devices/00\:09/id
return "No such file or directory"

I will take a look at the wiki entry.

Thanks,

Logan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
