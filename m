From: nemesis@icequake.net (Ryan Underwood)
Date: Mon, 13 Nov 2006 18:56:34 +0000
Subject: [lm-sensors] sensord and missing alarms
Message-Id: <20061113185634.GA23281@dbz.icequake.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061110190557.GA25801@dbz.icequake.net>
In-Reply-To: <20061110190557.GA25801@dbz.icequake.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Sat, Nov 11, 2006 at 04:20:44PM +0100, Jean Delvare wrote:
> 
> Actually, most chips, including the LM78, assert the alarm flag as long
> as the condition is true *and* the flag wasn't read, so the condition
> might no longer be true when you read the flag.

Right, that's the problem behavior.  I need a monitoring application to
be able to pick up any alarm event that happened, even one that may no
longer be true, so that it can make its own decision whether to act on
it or not.  Since multiple apps independently can read the sensors, then
somebody running gkrellm at the desktop will cause the alarm to be
cleared and then the monitor program will miss the alarm and never act
on it, even if the event that caused the alarm is still a problem.

> No, this wasn't done. The rule so far is that drivers should report the
> alarm bits exactly as read from the hardware. I can't really tell what
> I think about the idea until you tell us exactly which chip you are
> working with, which exact problem you encountered, and how (where) you
> intend to fix it (driver, libsensors, application...)

W83871D and LM78.

> My first impression is that, if you are really interested in the past
> states of the sensors, then you better continuously log all the values
> (some applications do that, drawing nice graphs.) A single alarm bit
> isn't going to tell you much.

We aren't that interested in past states of the sensors as we are in the
alarms, but the possibility of missing alarms in the monitor due to some
other app polling the sensors just won't work.

Does that make any sense?

I guess something besides an alarm latch that would work, is some way
through the libsensors API to quickly tell if any voltage, temperature,
or fan sensor has a current out of range condition (even if the alarm is
not asserted).

-- 
Ryan Underwood, <nemesis at icequake.net>

