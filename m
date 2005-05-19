From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: negative voltages
Message-Id: <401F0150.4070005@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075721644.401e35ac8e6fc@imp.gcu.info>
In-Reply-To: <1075721644.401e35ac8e6fc@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I didn't understand what was going on either, until I saw your fix to lib/chips.c.
Sorry I was no help.
You did it right.

As you have said, the /sys or /proc values are raw values.
So min < max. 
If you don't do it that way, the alarms won't work.

So if (and only if) you have an inverting compute line in userspace, 
then you MUST flip the limits for userspace.
Somewhere it has to be done, I think you'll agree.
That's what was done in lib/chips.c for 2.4.
So for those sensors, rather than the /proc values being mapped to min/max/reading,
they are mapped to max/min/reading. This was done by substituting VALUE(1) for VALUE(2), etc.

Chips that use external resistors for level shifting don't 
need inverting compute lines and don't need anything swapped
Think about it. (simplification) If I add 6 volts externally to
my -5V signal, that doesn't change which is min and which is max.
But if I multiply the -5V signal externally by -1, then min and max must be swapped.

Since 2.6 used the names (in1_max -> in_max1), the lib/chips.c swapping that was
implemented for 2.4 didn't happen any more.
Your change today fixes that.

All the chips referred to in Ticket #800 (both "classes")
had bad compute lines in sensors.conf.eg at the time,
for example:
	set in5_min -12 * 0.95
	set in5_max -12 * 1.05
which was clearly wrong.
But also, at the time, there was no swapping in libsensors.
So as ticket 800 says, it was somewhat confusing at the
time and it was a 2-part fix.

mds


Jean Delvare wrote:
> Hi all,
> 
> I've made the necessary fixes to libsensors. This is the way that
> requires the less changes and it doesn't break 2.4 drivers so I suggest
> we stick to it for now.
> 
> Tested to work with my AS99127F rev.1 (driver w83781d). More testers
> welcome.
> 
> That said and done, the question is still opened how we will handle the
> negative voltage limits in libsensors2. Since I believe we want a
> chip-independant library, which means that some chips would have min <
> max and some others would have the contrary, and userspace apps would
> have to cope with it. I don't really see major problems doing this.
> 
