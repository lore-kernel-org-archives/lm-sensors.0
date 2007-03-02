From: david.c.hubbard@gmail.com (David Hubbard)
Date: Fri, 02 Mar 2007 17:52:01 +0000
Subject: [lm-sensors] Using lmsensors with Winbond w83627ehf
Message-Id: <4dfa50520703020952w5d7f3cc4g7bc0431bbc274c75@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <279611.78053.qm@web53210.mail.yahoo.com>
In-Reply-To: <279611.78053.qm@web53210.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gnom,

On 3/2/07, Gnom Gnom <gnom108 at yahoo.com> wrote:
> Dear David,
>
> I sent reply to list yesterday but it never was posted.  I will try to post
> there again if you
> would prefer to not help me "offline".

I am not sure why your message was not received. I have CCed Axel
Thimm who operates the mailing list. Axel, can you help us debug this
issue?

You should not send HTML-only emails. I remember yahoo having an
option to send plain text.

I will help you, offline if necessary, but the first thing we should
get resolved is the mailing list issue.

> What I need to figure out is why sensors list temp1, temp2, and temp3, while
> BIOS only
> give CPU temp and MOBO temp.  I am experiencing overheating problems with
> these
> MOBOs (we are building beowulf cluster) and need to rely on lm_sensors for
> monitoring
> temp while system is running processes.

Thank you for this information. It really clears up your question.
From what I can see, you have the w83627ehf chip working correctly.
See below for more details, but essentially, you can just put "ignore"
lines in sensors.conf for the sensors that are not meaningful.

I would be interested to know what kind of overheating problems you
are having with the Asus P5LD2-VM motherboard. Please post a message
if you get the problems resolved.

> I did as you suggested in your reply (use cpuburn, record values from
> "sensors", and
> then bring down to BIOS and record values, and then compare.   temp2 in
> "sensors"
> is very likely what BIOS calls "CPU temp".  And temp1 is probably MOBO temp,
> but
> I don't understand temp3.
>
> I can forward you "sensors" outputs if you wish.
>
> Regards,
> gnom

I did receive your previous email. Once we get the email list to work
for you, please re-send it to lm-sensors at lm-sensors.org so it is part
of the official thread.

This motherboard (the Asus P5LD2-VM) uses a config often found with
w83627ehf motherboards. temp2 is wired to the CPUTIN pin on the
w83627ehf chip, which is connected to the processor's thermal diode.
It is my opinion that temp3 (the AUXTIN pin) is not connected to
anything meaningful. It is probably floating. Although the w83627ehf
reports the voltage on the pin, it does not measure temperature at
all. temp1 (the SYSTIN thermal diode inside the w83627ehf chip) is
properly measuring the temperature inside the chip, which represents
the temperature of the motherboard.

The w83627ehf is also configured to control pwm2 and fan2 based on
temp2. Since you only have one fan on the motherboard, you should also
ignore the other fans.

This may not resolve your overheating issues, but you can rely on
temp2 and fan2_input to give you accurate readings of the CPU temp and
the fan RPM. Further, you can configure sensors to report alarms when
the fan RPM goes too low or the CPU temp goes too high. man sensors &&
man sensors.conf will give you more information.

Hope that helps,
David

