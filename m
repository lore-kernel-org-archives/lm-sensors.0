From: "Fred ." <eldmannen@gmail.com>
Date: Sun, 15 Feb 2009 13:19:37 +0000
Subject: [lm-sensors] Chassis intrusion detection
Message-Id: <f188924b0902150519o2a67a7bds3b15bc756730226b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <f188924b0901240908g1fde798fsfaba824938e9dc03@mail.gmail.com>
In-Reply-To: <f188924b0901240908g1fde798fsfaba824938e9dc03@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Why does 'libsensors' not have support support for chassis intrusion?

As I understand it, chassis intrusion is a feature that is supported
by the Super-I/O integrated circuit?
How is communication done with the Super-I/O circuit? Is it via I2C? LPC?

Where in /sys/class/hwmon/ would I find chassis intrusion?
In my /sys/class/hwmon/ there are links to other directories, there
are hwmon0, hwmon1, hwmon2 where hwmon0 and hwmon1 are linked to
coretemp.0 and coretemp.1.
hwmon2 points to /sys/devices/platform/f71882fg.2560/hwmon/hwmon2/

/sys/devices/platform/f71882fg.2560/hwmon/hwmon2$ ls
device  power  subsystem  uevent

/sys/devices/platform/f71882fg.2560$ ls
driver      fan2_alarm  fan3_beep   fan4_input  in1_beep   in3_input
in7_input  power        temp1_crit       temp1_max       temp2_beep
  temp2_input     temp3_alarm      temp3_fault     temp3_type
fan1_alarm  fan2_beep   fan3_input  hwmon       in1_input  in4_input
in8_input  subsystem    temp1_crit_hyst  temp1_max_hyst  temp2_crit
  temp2_max       temp3_beep       temp3_input     uevent
fan1_beep   fan2_input  fan4_alarm  in0_input   in1_max    in5_input
modalias   temp1_alarm  temp1_fault      temp1_type
temp2_crit_hyst  temp2_max_hyst  temp3_crit       temp3_max
fan1_input  fan3_alarm  fan4_beep   in1_alarm   in2_input  in6_input
name       temp1_beep   temp1_input      temp2_alarm     temp2_fault
  temp2_type      temp3_crit_hyst  temp3_max_hyst


The 'sensors' tool is supposed to mention chassis intrusion. Does it
always do this, or only if its supported, or only if its triggered and
is in alarm mode?

I have the Fintek f71882fg super-io circuit which is supposed to
support chassis intrusion according to this PDF
http://www.fintek.com.tw/files/productfiles/F71882_ab.pdf

On Fri, Jan 30, 2009 at 6:23 PM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Fred,
>
> On Sat, 24 Jan 2009 18:08:47 +0100, Fred . wrote:
>> Some computer cases (chassis) have a switch that gets triggered if the
>> case is opened, this sends a signal to the motherboard via a wire
>> connected to the switch.
>>
>> Can lm_sensors read this? Does lm_sensors have support for this?
>
> Some of our hardware monitoring drivers have support for this feature.
> However we don't have an established standard for it. libsensors
> doesn't have support.
>
>> How do I use it?
>
> Read the documentation of your hardware monitoring driver, and look for
> the appropriate sysfs attribute somewhere under /sys/class/hwmon.
>
>> Can I have a script that wipes encryption keys if the case is opened?
>
> We don't have anything like that, so you'll have to write some custom
> code if you need to do this.
>
> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
