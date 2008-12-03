From: Matt Roberds <mattroberds@cox.net>
Date: Wed, 03 Dec 2008 23:29:50 +0000
Subject: Re: [lm-sensors] sensors-detect: testers wanted!
Message-Id: <Pine.LNX.4.64.0812031718120.18822@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081203182216.5be504cf@hyperion.delvare>
In-Reply-To: <20081203182216.5be504cf@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 3 Dec 2008, Jean Delvare wrote:
> On Wed, 3 Dec 2008 15:55:12 -0600 (CST), Matt Roberds wrote:
>> The difference is that it didn't find the adt7475.
>
> Yes, this is by design. One of the goals of the new probing logic is
> to skip probes which aren't expected to work by default.

I remember the discussion about this a few months ago, yes.

> For Asus (and Tyan) we would keep probing the SMBus even in the
> presence of an enabled Super I/O.

This is probably helpful, as long as these boards are also known not to
blow up too badly when you do probes that have to write to the hardware.
I would suggest that you keep the heuristic in sensors-detect pretty
broad; going by manufacturer and possibly by top-level CPU type (AMD,
Intel, or other) is probably as fine as you want to go in
sensors-detect.  Otherwise you end up having to maintain all kinds of
special-case stuff in sensors-detect, instead of actually working on the
hardware drivers etc.

>>> Do you want to scan the ISA I/O ports? (yes/no/IPMI ONLY):
>>
>> You should include a few words in the help text about what IPMI ONLY
>> does and why you would want to choose it or not choose it.
>
> I wanted to keep things as simple as possible, assuming that most
> users would just go with the default answer, but you are more curious
> than I expected ;)

I don't know how much you should tune to me, because I am probably not a
typical end-user.  In general, there are limits, but I don't mind having
a few choices, as long as I have some idea of what the different choices
do, or a pointer to documentation.  (The kernel configuration has lots
of things like "If you have an Acme 100, say "Y" here and read
Documentation/acme-100.txt.")  Just having the "IPMI ONLY" option pop up
with no further discussion in the prompt text is a little jarring IMHO.

> An alternative would be to simply split IPMI interface probing to its
> own section, as these are fundamentally different from legacy ISA
> chips.

I think this might be useful.  That might let you spend a sentence or
two explaining IPMI and why you might want to probe it or not before
asking the user for a choice.

> I didn't want to explain everything in detail in the script, again to
> not frighten the user with long explanations, when most users should be
> able to just hit "Return" and be done with it.

This is a useful goal.  But also, most users are only going to run
sensors-detect once or a small number of times while they are getting
things set up, and then they don't have to deal with it again for quite
a while.  IMHO it's OK to be a little more wordy in this case; I think
it tends to help people make better choices the first time through,
which means they are more likely to end up with a working configuration.

> I'm not sure how to add more information without making sensors-detect
> painful to use in the main case.

Links to the man page might be a good idea.  ("See the MICROCHANNEL
heading on the sensors-detect man page.")  Maybe URLs, if you are
prepared to fight URL rot.

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
