From: jrickman@myamigos.us
Date: Sun, 20 Dec 2009 22:15:28 +0000
Subject: Re: [lm-sensors] Troubleshooting SCH5127 / DME1737
Message-Id: <2337.66.169.124.218.1261347328.squirrel@webmail.myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <3647.66.169.133.216.1259294200.squirrel@webmail.myamigos.us>
In-Reply-To: <3647.66.169.133.216.1259294200.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

> On Thu, 26 Nov 2009 21:56:40 -0600 (CST), jrickman@myamigos.us wrote:
>> I am trying to troubleshoot why the SCH5127 sensor inside my Acer H340
>> NAS
>> system is not reporting via "lm_sensors". The chip shows to be on the
>> supported devices list. The "dme1737" module is on the system. I now
>> know
>> about the "coretemp" support for Intel Atom CPU coming in the 2.6.32
>> kernel. When I try to run "sensors -f" it tells me to run
>> "sensors-detect". When I run "sensors-detect" it sees the need to load
>> the
>> "coretemp" and "dme-1737" modules, but neither module seems to load.
>
> Actually, the dme1737 driver does load, I can see it in the output of
> "lsmod". But please note that the dme1737 driver is an hybrid driver,
> it supports both SMBus and I/O access to devices, so it will load
> successfully even if no supported device is found - in case an SMBus
> device becomes reachable later.
>
>> (...)
>> [root@acer-nas-01 ~]# sensors-detect
>> # sensors-detect revision 1.1
>> # System: Acer Aspire easyStore H340
>> # Board: Acer WG945GCM
>>
>> This program will help you determine which kernel modules you need
>> to load to use lm_sensors most effectively. It is generally safe
>> and recommended to accept the default answers to all questions,
>> unless you know what you're doing.
>>
>> Some south bridges, CPUs or memory controllers contain embedded sensors.
>> Do you want to scan for them? This is totally safe. (YES/no):
>> Silicon Integrated Systems SIS5595...                       No
>> VIA VT82C686 Integrated Sensors...                          No
>> VIA VT8231 Integrated Sensors...                            No
>> AMD K8 thermal sensors...                                   No
>> AMD Family 11h thermal sensors...                           No
>> Intel Core family thermal sensor...                         Success!
>>     (driver `coretemp')
>> Intel AMB FB-DIMM thermal sensor...                         No
>> VIA C7 thermal and voltage sensors...                       No
>>
>> Some Super I/O chips contain embedded sensors. We have to write to
>> standard I/O ports to probe them. This is usually safe.
>> Do you want to scan for Super I/O sensors? (YES/no):
>> Probing for Super-I/O at 0x2e/0x2f
>> Trying family `National Semiconductor'...                   No
>> Trying family `SMSC'...                                     Yes
>> Found `SMSC SCH5127 Super IO'                               Success!
>>     (address 0x800, driver `dme1737')
>> Probing for Super-I/O at 0x4e/0x4f
>> Trying family `National Semiconductor'...                   No
>> Trying family `SMSC'...                                     No
>> Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
>> Trying family `ITE'...                                      No
>
> The problem is that sensors-detect and the dme1737 driver disagree. The
> former claims that the latter supports the SMSC SCH5127, but looking at
> the driver code, support is _not_ there. Which explains why loading the
> dme1737 driver doesn't have any effect.
>
> Juerg, this part of sensors-detect comes from you [1]. It was a follow
> up of an private discussion we had with a guy named Marcos Dione. You
> sent him a modified dme1737 driver and he tried that, with good results
> as far as I can see, but actual SCH5127 support was never added to the
> public driver. I think I was waiting for you to look at the datasheet
> (which I do not have) and tell me if there were incompatibilities
> between the SCH5127 and SCH311x devices. But it did not happen so we
> still do not have SMSC SCH5127 support at the moment.
>
> [1]
> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022900.html
>
> At the very least, sensors-detect should report what the driver
> actually supports. But if we could have SCH5127 support that would
> obviously be better. Please let me know if you think treating the
> SCH5127 as an SCH311x without other changes is OK, if that's the case
> we can do that easily. Otherwise I'll have to mark the device as
> unsupported in sensors-detect.
>
> jrickman, the good news if that all hope isn't lost ;) You can try
> loading the dme1737 driver with option force_id=0x7c. It will make the
> driver believe that you have an SCH3112 chip. It worked for one user in
> the past, maybe it'll work for you too. That being said, until Juerg
> provides more information, I suggest that you use the driver in
> read-only mode: don't try changing the limits or the fan speeds. Better
> safe than sorry...
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>
My apologies for not replying sooner.

Jean, your suggestion to use the force option works fine on my Acer H340
server. Thank you very much for your help.

[root@acer-nas-01 ~]# uname -r
2.6.31.6-166.fc12.x86_64
# remove the module loaded on boot
[root@acer-nas-01 ~]# modprobe -r dme1737

# load module with suggested option
[root@acer-nas-01 ~]# modprobe -v dme1737 force_id=0x7c
insmod
/lib/modules/2.6.31.6-166.fc12.x86_64/kernel/drivers/hwmon/hwmon-vid.ko
insmod
/lib/modules/2.6.31.6-166.fc12.x86_64/kernel/drivers/hwmon/dme1737.ko
force_id=0x7c

[root@acer-nas-01 ~]# sensors
sch311x-isa-0870
Adapter: ISA adapter
in0:         +1.78 V  (min =  +0.00 V, max =  +3.32 V)
Vcore:       +0.80 V  (min =  +0.00 V, max =  +1.99 V)
+3.3V:       +3.32 V  (min =  +0.00 V, max =  +4.38 V)
+5V:         +5.01 V  (min =  +0.00 V, max =  +6.64 V)
+12V:       +15.77 V  (min =  +0.00 V, max = +15.94 V)
3VSB:        +3.33 V  (min =  +0.00 V, max =  +4.38 V)
Vbat:        +0.00 V  (min =  +0.00 V, max =  +4.38 V)
fan1:        761 RPM  (min =    0 RPM)  ALARM
fan2:          0 RPM  (min =    0 RPM)
fan3:          0 RPM  (min =    0 RPM)  ALARM
temp1:       +48.2°C  (low  = -127.0°C, high = +127.0°C)
SIO Temp:   +127.9°C  (low  = -127.0°C, high = +127.0°C)
temp3:       +38.1°C  (low  = -127.0°C, high = +127.0°C)
cpu0_vid:   +2.050 V

Fan1 is the system fan. It does rotate that slow.

There are no other fans in the Acer H340 system, but there is at least 1
available header, possibly 2, but no time to teardown the server to check.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
