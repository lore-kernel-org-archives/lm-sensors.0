From: "Fred ." <eldmannen@gmail.com>
Date: Tue, 17 Feb 2009 01:29:04 +0000
Subject: Re: [lm-sensors] Chassis intrusion detection
Message-Id: <f188924b0902161729k5f808385i2b5e98901da17c20@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <f188924b0901240908g1fde798fsfaba824938e9dc03@mail.gmail.com>
In-Reply-To: <f188924b0901240908g1fde798fsfaba824938e9dc03@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 16, 2009 at 10:39 AM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Fred,
>
> On Sun, 15 Feb 2009 14:19:37 +0100, Fred . wrote:
>> Why does 'libsensors' not have support support for chassis intrusion?
>
> Because libsensors builds on top of a standardized sysfs interface, and
> said interface doesn't include chassis intrusion at the moment. So the
> first step would be to define such a standard interface at sysfs level,
> then make sure all drivers implement it properly, and only then it
> will be possible to add support in libsensors.
Okay, could you tell the sysfs guys to define a standard interface the
sysfs level,
or cooperate with them on that or something, I don't know how to talk to them.

>
>> As I understand it, chassis intrusion is a feature that is supported
>> by the Super-I/O integrated circuit?
>
> By any hardware monitoring chip, optionally.
>
>> How is communication done with the Super-I/O circuit? Is it via I2C? LPC?
>
> Most often SUper-I/O chips are accessed via LPC, but some of them
> (SMSC) have their hardware monitoring block accessed via the SMBus
> instead.
>
>> Where in /sys/class/hwmon/ would I find chassis intrusion?
>> In my /sys/class/hwmon/ there are links to other directories, there
>> are hwmon0, hwmon1, hwmon2 where hwmon0 and hwmon1 are linked to
>> coretemp.0 and coretemp.1.
>> hwmon2 points to /sys/devices/platform/f71882fg.2560/hwmon/hwmon2/
>>
>> /sys/devices/platform/f71882fg.2560/hwmon/hwmon2$ ls
>> device  power  subsystem  uevent
>>
>> /sys/devices/platform/f71882fg.2560$ ls
>> driver      fan2_alarm  fan3_beep   fan4_input  in1_beep   in3_input
>> in7_input  power        temp1_crit       temp1_max       temp2_beep
>>   temp2_input     temp3_alarm      temp3_fault     temp3_type
>> fan1_alarm  fan2_beep   fan3_input  hwmon       in1_input  in4_input
>> in8_input  subsystem    temp1_crit_hyst  temp1_max_hyst  temp2_crit
>>   temp2_max       temp3_beep       temp3_input     uevent
>> fan1_beep   fan2_input  fan4_alarm  in0_input   in1_max    in5_input
>> modalias   temp1_alarm  temp1_fault      temp1_type
>> temp2_crit_hyst  temp2_max_hyst  temp3_crit       temp3_max
>> fan1_input  fan3_alarm  fan4_beep   in1_alarm   in2_input  in6_input
>> name       temp1_beep   temp1_input      temp2_alarm     temp2_fault
>>   temp2_type      temp3_crit_hyst  temp3_max_hyst
>
> The f71882fg driver doesn't support chassis intrusion detection at the
> moment (although the chip can do it, if wired properly, as you found
> out yourself already.)
When will it support that?
The PDF datasheet should include the necessary information needed for
implementing that.
Source: http://www.fintek.com.tw/files/productfiles/F71882_V028P.pdf

>> The 'sensors' tool is supposed to mention chassis intrusion. Does it
>> always do this, or only if its supported, or only if its triggered and
>> is in alarm mode?
>
> sensors 3 goes on top of libsensors 3 which doesn't support chassis
> intrusion detection.
But I have seen in many tickets on the lm-sensors website people who
posted their logs,
and they indicate a presence chassis intrusion support.
Source: http://www.lm-sensors.org/ticket/2334
How come?

>
>> I have the Fintek f71882fg super-io circuit which is supposed to
>> support chassis intrusion according to this PDF
>> http://www.fintek.com.tw/files/productfiles/F71882_ab.pdf
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
