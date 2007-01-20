From: daniel@ceregatti.org (Daniel Ceregatti)
Date: Sat, 20 Jan 2007 05:37:37 +0000
Subject: [lm-sensors] Asus P5B Deluxe / Winbond 83627DHG
Message-Id: <45B1AAA1.5090701@ceregatti.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
In-Reply-To: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Seems I also had libsensors from a manually compiled lm_sensors in
/usr/local/lib. I've managed to remove all traces of this, installed
2.10.2 via portage by making my own ebuild (overlay, in case you want
it, is here: http://sh.nu/download/ebuilds) and:

w83627dhg-isa-0290
Adapter: ISA adapter
VCore:     +1.18 V  (min =  +0.00 V, max =  +1.74 V)
in1:      +11.14 V  (min =  +8.40 V, max = +12.04 V)
AVCC:      +3.20 V  (min =  +2.14 V, max =  +0.43 V) ALARM
3VCC:      +3.20 V  (min =  +1.15 V, max =  +2.13 V) ALARM
in4:       +1.18 V  (min =  +0.18 V, max =  +0.11 V) ALARM
in5:       +1.54 V  (min =  +0.69 V, max =  +1.71 V)
in6:       +5.86 V  (min =  +5.27 V, max =  +0.00 V) ALARM
VSB:       +3.20 V  (min =  +0.18 V, max =  +1.90 V) ALARM
VBAT:      +3.14 V  (min =  +2.13 V, max =  +1.34 V) ALARM
Case Fan:    0 RPM  (min = 4500 RPM, div = 4) ALARM
CPU Fan:  2083 RPM  (min = 84375 RPM, div = 8) ALARM
Aux Fan:     0 RPM  (min = 4066 RPM, div = 4) ALARM
fan4:        0 RPM  (min =  703 RPM, div = 16) ALARM
fan5:        0 RPM  (min = 6958 RPM, div = 2) ALARM
Sys Temp:    -65?C  (high =    +0?C, hyst =  +127?C) 
CPU Temp:  +53.5?C  (high = +127.0?C, hyst =  +0.0?C)   ALARM
AUX Temp:  +54.5?C  (high = +127.0?C, hyst =  +0.0?C) 

coretemp-isa-0000
Adapter: ISA adapter
temp1:       +56?C  (high =   +85?C)                    

coretemp-isa-0001
Adapter: ISA adapter
temp1:       +57?C  (high =   +85?C)                    

Here is a screen shot of my bios:

http://sh.nu/download/images/bios.jpg

I guess the next step is to configure it? Seems I'm missing a few things
there.

Daniel

David Holl wrote:
> Yeah, my distro only has 2.10.1 as well.  (Gentoo -- hopefully they'll
> put it up under ~x86 soon... /me wonders how to become the Gentoo
> package maintainer for lm_sensors...)
>
> Try 2.10.2 from http://www.lm-sensors.org/wiki/Download
>
>
> On 1/19/07, *Daniel Ceregatti* <daniel at ceregatti.org
> <mailto:daniel at ceregatti.org>> wrote:
>
>     I have 2.10.1, which is the highest version my distro has. Should
>     I apply a patch? Grab the latest SVN?
>
>     Daniel
>
>
>     David Holl wrote:
>>     Hey Daniel, what version of lm-sensors do you have?  I found the
>>     "sensors" command in lm-sensors 2.10.1 didn't know how to show
>>     the w83627dhg info, so I submitted a fix which should be in
>>     2.10.2.  :)
>>
>>     - David
>>
>>     On 1/19/07, *David Hubbard* <david.c.hubbard at gmail.com
>>     <mailto:david.c.hubbard at gmail.com>> wrote:
>>
>>         Update on the issue:
>>
>>         It looks like the new w83627ehf driver (with patch for
>>         official dhg
>>         support) works fine. His sensors is reporting the following:
>>
>>         ------------------
>>         w83627dhg-isa-0290
>>         Adapter: ISA adapter
>>
>>         coretemp-isa-0000
>>         Adapter: ISA adapter
>>         temp1:       +58?C  (high =   +85?C)
>>
>>         coretemp-isa-0001
>>         Adapter: ISA adapter
>>         temp1:       +57?C  (high =   +85?C)
>>         ------------------
>>
>>         (Note lack of any temperature info from w83627dhg)
>>
>>         But /sys/class/hwmon/hwmon0/device/temp1_input temp2_input
>>         temp3_input
>>         seem OK. Well ... temp1_input = -65000. That's not right.
>>
>>         So sensors should be displaying something. That's as far as
>>         we got tonight.
>>
>>         David
>>
>>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070119/e58dd0da/attachment-0001.html 
