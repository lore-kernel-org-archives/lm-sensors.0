From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 02 Nov 2005 21:29:14 +0000
Subject: [lm-sensors] New Abit uGuru driver + libsensors patch, review
Message-Id: <20051102212840.36e80c35.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4358B291.6070702@hhs.nl>
In-Reply-To: <4358B291.6070702@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> I know that there is a dislike among the lm_sensors developers against 
> not having the exact hardware specs but in practice, we never have. Even 
> if we have the sensorschip datasheets we still don't know how the 
> motherboard manufacturer has hooked the sensorchip up.

Sometimes we do. I am currently writing a driver for the Fintek F71805F
Super-I/O hardware monitoring features. I have the full specifications
of the chip itself, and I also have the wiring schematics of the Jetway
K8M8MS motherboard it sits on, generously provided by Jetway. I had a
working configuration file in no time, and writing the driver was a
pleasure.

Anyway, the motherboard specific parts are not needed to write the
drivers. They are needed to write configuration files. I don't say it's
not important, and I do want (probably more than anyone else)
motherboard manufacturers to provide complete and accurate data for us
to write these configuration files. But just because most of them
currently do not is no excuse for chip makers not to provide technical
documentation for their chips.

Also, motherboard specific configuration (mostly resistor values and
input labels) can sometimes be guessed from the BIOS setup screen or
from Windows tools. It's not ideal, but doable even by an average user.
By contrast, deriving a driver from the BIOS code or a Windows tool's
code is way more difficult when not simply impossible, let alone the
fact that it isn't necessarily legal in all countries.

So I would be grateful if you could avoid irrelevant comparisons.
Undocumented chips suck more than anything else, period.

> Actually I have used lm_sensors for a long time and my current uGuru 
> driver gives the most believable readings of all my setups all my 
> previous (asus) motherboards always had a couple of readings which were 
> significantly different from the BIOS, and those from the BIOS where 
> more realistic imho.

If your other Asus boards were using an AS99127F or ASB100 chip, no
wonder as we did not have datasheets for these ones either - and this
is the exact reason why I do not want to support more undocumented
chips: people tend to complain to us while we did our best.

Asus boards do not exactly have a good reputation when it comes to
hardware monitoring, and this ain't related to lm_sensors. Windows
tools such as Motherboard Monitor had the same issues we had. Alex van
Kaam stopped developping it in part because of this.

> I guess that we just have to accept that there will always be some guess 
> work in lm_sensors, untill motherboard manufacturers start giving away 
> full specs including schematics.

Guessing 5% out of the 95% you have documentation for is fine with me,
and I don't actually expect anything better than that, for nothing is
perfect in the real world.

Guessing 95% out of 5% requires a completely different nature and
amount of work, and that's something I have no interest in. We also
know by experience that it unsurprisingly results in much lower quality
drivers.

> I'm a big believer of opensource and openness in general for both soft- 
> and hardware (where are the good old days your radio/tv would come with 
> full schematics?) but in the end I'm also pragmatic and when I have to 
> choose between a blackbox approach to support XXX or bad/no support at 
> all I choose for a blackbox approach*

No. What you are providing right now IS bad support. I've read the
thread by Matthew Stamp on this list, and I know it's only the first
one of a long series of "doesn't work for me" posts about the uGuru.
This is the unavoidable consequence of writing drivers without any
technical documentation.

Whether bad support is better or worse than no support at all is a
different and open question. My opinion is that no support is better
because it avoids fooling hardware buyers into thinking that a chip is
supported when it isn't really. But I can understand that others have a
different opinion, especially when these others have themselves already
bought the cursed hardware in question.

> * going offtopic: One of the reasons for me to choose for a blackbox 
> approach if nescesarry is because I want Linux or more general 
> open-engineering to succeed, I really wish everything would be fully 
> open. But untill that day we need todo what we can to support as much 
> hardware as possible, so that people will be able to switch to an 
> opensource OS, whatever their hardware.

Your reasoning would hold if hardware wasn't obsolete after only a few
years these days. Given the little manpower we have to run the
lm_sensors project, it is way more efficient to let everyone know what
hardware not to buy than trying to support every chip, whatever
undocumentd crap that chip is. This is my way of being pragmatic.

> Once opensource has a significant place in the marketplace hopefully
> hardware will become more open too.

So we have the same goal in mind, but have different views on the best
ways to reach it. I do want manufacturers to open up their
specifications, and you say you want that too. You think this will
happen when open source has been successful enough. I think this is a
requirement for open source to be successful, because the key to open
source success it product quality, and you can't achieve that without
proper technical documentation.

-- 
Jean Delvare
