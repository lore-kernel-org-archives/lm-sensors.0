From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [PATCH 2.6.12-rc2-mm3] i2c: modify lm87 to use auto fan_div
Message-Id: <3mc461hnrpdqi6cf6674u4ub81sdgg16lo@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
In-Reply-To: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Sun, 17 Apr 2005 08:14:21 +1000, Grant Coady <grant_lkml@dodo.com.au> wrote:

I changed the test generator, it spits out values of interest, 
rather than the boring 20% test I was using.  The generator does 
rounding and produces a much more interesting test set.

The critical test point is the switch from too low a fan speed 
limit to a valid low fan speed limit, this is happening on the 
664 -> 667 rpm (255 -> 254) transition which is correct for 
max fan_div = 8 on adm9240.

The 'auto fan clock divider stepper' is disabled during this 
testing to isolate what we're testing.

Thus I propose that some limit be set on this loss of resolution, 
where?  5 or 6 bits?  4 bits is still about 8% resolution, going 
less would be a problem.  Plus the user fan speed limit is likely 
to drift as resolution drops.

The limit I chose was zero change on fan low speed limit setting, 
though I see there may be some room to move, but how much?

Returning to this document after the last -- I'll try out the idea
of forcing correct fan speed display at cost of fan limit resolution, 
if I can avoid auto fan divider _change_, I will, I'm beginning to 
think it is wrong track.  

So I see it more as me putting wrong priorities on things, thus 
I now accept your argument of valid alarm + fan speed display, 
the 'sufferer' will be fan speed resolution, but that does not 
matter for ridiculous settings, which is what we want handle 
with "Just Works".  Agree?

Cheers,
Grant.

Test generator, just in case I goofed.

#!/bin/bash
#
# test auto fan clock divider algorithm
#
# Copyright (C) 2005 Grant Coady <gcoady@gmail.com>
#
# GPLv2 per linux/COPYING by reference
#
minpath="/sys/bus/i2c/devices/0-002d/fan1_min"
fanpath="/sys/bus/i2c/devices/0-002d/fan1_input"
values=(92 93 94 95 96 97 98 190 191 192 193 194 253 254 255 256 257 258 259)
#
function test_two ()
{
	local y=0
	
	for fan_div in 1 2 4 8; do
		while [ $y -lt 19 ]; do
			fan_limit=$(( (1350000 + ($fan_div * ${values[${y}]}) / 2)\
					/ ($fan_div * ${values[${y}]}) ))
			echo -e "$fan_limit" >> "$TMPFILE"
			(( y++ ))
		done
		y=0
	done

	sort -n < "$TMPFILE" | uniq > "$TMPFILE.sort"
	
	while read fan_limit rest; do
		echo $fan_limit > "$minpath"
		sleep 1
		read fan_rpm < $fanpath
		echo "set fan_limit=$fan_limit, read fan_rpm=$fan_rpm"
		sleep 1
	done < "$TMPFILE.sort"
}

TMPFILE=$(mktemp -t xyz.XXXXXX)
echo "Grant's auto fan_div tester..."
test_two
rm -f $TMPFILE
rm -f $TMPFILE.sort
#end
