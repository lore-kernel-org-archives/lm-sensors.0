From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: sensors.conf: explain how to enable/disable beeps
Message-Id: <200405131054.i4DAs9gX060640@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040509222513.GA20557@pc.aurel32.lan>
In-Reply-To: <20040509222513.GA20557@pc.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>>>I'd like to make another suggestion.  Put meaningful text strings as the
>>>contents of the _status file:
>>>
>>>  LOW  (for low alarm)
>>>  HIGH  (for high alarm)
>>>  FAIL  (for diode failure)
>>>  ALARM  (for generic alarm)
>>>  HIGH, FAIL  (for multiple alarms)
>>>  ""  (null string for no alarm)
>>>
>>>Then the sensors library and other tools/languages can just "cat" the
>>>contents to get the status and test for non-null string to see if there
>>>is an active alarm or not.
>>
>>Ah, I like this even better.  We would never need to display more than
>>one status at a time per device, right?
>
>
>I suppose it depends on what you mean.  As I said, there is a case like:
>
>  "ALARM, FAIL"  (for multiple alarms)
>
>
>
>Which could be construed as "more than one status" but they are all
>alarms for the same parameter so I see this as a single value.

Correct, some chips have individual alarm bits for several failure
conditions, so there could be more than one alarm.

For example, the PC87366 temperature channels have a low limit alarm, a
high limit alarm, a critical limit alarm and a diode fault alarm. Plus a
common alarm bit which is set if any of the individual bits is. This
common bit can additionally be masked out.

Unless we only show the more relevant element each time? FAIL would take
precedence over alarms, CRIT over HIGH, HIGH over LOW (although this
conflict denotes a configuration error).

I guess that different chips have more or less individual bits (to start
with, they may have less than three limits), each of which could be
individually maskable. All in all this means that hendling all possible
cases will probably lead us to an unnecessary complex interface.

My point is that most users probably won't need these fine-grained
controls. They typically want to know what temperature their system is,
and be warned if it's too hot. Some chips have become over-featured and
I don't think we need to export all the configurability to user-space.
For one thing, the BIOS is supposed to have set most things up for us,
and the reasonable chip defaults should do the rest. Having too much
files in our sysfs interface is likely to just confuse the user with no
benefit.

For this reason, I think that the first question we should ask ourselves
is what we really want the user to see and have control on. Are we
interested in exporting individual alarms for, say, low, high and
critical limits? Most chips have a single bit for all these. Maybe we
can make the other chips look the same, if we think that there is not
much added value in detailing the alarms. Probably it's different for
failed readings, for which we want a different bit, because the error is
of a different nature.

Then there's the same question for alarm masks where they exists, and
beep mask where they exist. Is it worth giving the user full control
over these? I'm not sure. BIOS is supposed to have done it properly,
and I believe most users don't care.

The choice of individual files vs. commom files and strings vs. numbers
merely depends on the level of details we want to give to the user, IMHO.

>But having to read multiple files to get the complete alarm status for a
>given input would be annoying.  Especially if it means having to read
>all of (_min_status, _max_status, _crit_status, _fail_status, etc...)

I think I agree with that. Having separate files is probably not very
script-friendly.

All in all, Philip's proposal seems to be the best one (single file with
comma-separated strings), although I was a bit reluctant with exporting
alarms as strings in the first place (because it promises some parsing
overhead for the future libsensors). Looks like we are condemned to
choosing between script-oriented or library-oriented optimizations?

It could also be discussed whether we want to add ALARM when any of LOW,
HIGH or CRIT is set so that scripts can simply grep for ALARM.

A completely different approach is to hide these fine grained alarms to
the user. This means we have just two possible alarms (at most) for each
channel: limit crossed or hardware failure. Since these are two
different things, having two different (boolean) files may make sense.

As you can see, I really have no strong opinion on what should be done...
I hate this when we just can't figure out the "correct" approach to
follow, because most likely we'll find out why we did not choose the
correct one *after* the decision was made and the choice implemented ;(

Jean
