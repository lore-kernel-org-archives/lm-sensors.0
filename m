From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: sensors.conf: explain how to enable/disable beeps
Message-Id: <200405121246.i4CCki4N023998@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040509222513.GA20557@pc.aurel32.lan>
In-Reply-To: <20040509222513.GA20557@pc.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>> Maybe it would be worth adding that some chips also have individual beep
>> enable/disable bits mapped on alarm bits? Not sure though, since the
>> rest of the sensors.conf.eg file does mention neither the alarms nor the
>> beeps entries.
>
>I have thinked of that, however it may be difficult for the users to
>look into the sources to get the masks to enable or disable individual
>alarms.
>
>Maybe the first thing to do is to list the masks for each chip that
>support individual alarms in the documentation.

You're right. The fact that it's chip dependant doesn't help.
Documenting all chips would be much work, not necessarily worth it (most
people probably don't care about enabling individual beeps).

BTW, this is something that we are supposed to work on for the sysfs
(2.6) interface: splitting alarm files over individual files, such as
temp1_status, etc... so that the interface is truly chip-independant.

There are several approaches to the problem. Either we attach alarms to a
channel, or to a limit. And beeps can be part of it or in different
files. If we leave beeps apart for now, here are the two possibilities I
see:

1* One status file per channel:

in0_input
in0_min
in0_max
in0_status <-- new file
temp1_input
temp1_min
temp1_max
temp1_crit
temp1_status <-- new file

Each status file would be a bitfield.
0x01 = min limit alarm
0x02 = max limit alarm
0x04 = crit limit alarm
0x08 = open diode

etc... The value of each bit would have to be defined once for all, and
be as common as possible between channel types, where it makes sense. Of
course, not all alarms would be possible for every type, nor for every
real channel within a type (depending on what the chip implements).

2* One file by limit:

in0_input
in0_min
in0_min_alarm <-- new file
in0_max
in0_max_status <-- new file
temp1_input
temp1_input_alarm <-- new file
temp1_min
temp1_min_alarm <-- new file
temp1_max
temp1_max_alarm <-- new file
temp1_crit
temp1_crit_alarm <-- new file

Here, each file would simply contain 1 or 0. The temp1_input_alarm file
is used for non-limit related alarms (open diode for example). I can't
think of a case where the alarm files would have non-boolean values, but
maybe there are.

Each approach has its pros and cons:

Method #1: Pros: Fewer files, scripts can easily know if there is any
alarm set for a channel (non-zero value). Cons: The user-space needs to
know the meaning of the bits. The bits have to be wisely chosen once and
for all, covering all possibilities (at lest of all chips we know of as
of today).

Method #2: Pros: No preliminary knowledge necessary, the interface is
self explaining. Can be easily implemented and extended. Cons: almost
doubles the number of files in the sysfs interface.

I have no string preference (yet). Insight welcome.

(After that, the same shall be done for the individual beep bits, of
course.

Note that in any case the old alarm files will have to be kept, at least
in a first time, so as to preserve compatibility with existing tools
(sensors & libsensors).

Thanks,

Jean
