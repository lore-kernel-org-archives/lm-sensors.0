From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 05 May 2008 08:10:38 +0000
Subject: Re: [lm-sensors] Reverting the probe order
Message-Id: <20080505101038.22ec2f94@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080504193054.2a81247b@hyperion.delvare>
In-Reply-To: <20080504193054.2a81247b@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matt,

On Sun, 4 May 2008 19:10:30 -0500 (CDT), Matt Roberds wrote:
> On Sun, 4 May 2008, Jean Delvare wrote:
> > It just occurred to me today that the order in which we probe for
> > sensor chips in sensors-detect doesn't make sense. [...] Comments?
> 
> I agree that changing the order to do the "safer" probes first is a good
> idea.  However, I think that if some probes are skipped based on the
> results of earlier probes (like your example of skipping the ISA probe if
> a SuperIO chip with monitoring is found), there ought to be some way to
> force these probes to be done.  The reason is that as soon as you code
> something like that into sensors-detect, Advanced Intel Devices will
> come out with the new Athlete Sexium XQ y8 Core Octo processor and a
> reference motherboard design that breaks the new version of sensors-
> detect.

Of course. Maybe I haven't been clear enough in my original post, but
all I meant to change was the default answer. The users must always have
the possibility to force a probe if they know they need it.

> One of the goals of sensors-detect seems to be that you don't need to
> configure it much (no command-line options); you just run it and it
> figures things out.  Adding a --force-unsafe-probing option might be
> considered to be a bad idea.  One option might be to have two scripts -
> say sensors-detect and sensors-detect-this-might-explode-your-hardware -
> but then you have duplicate code and have to make the same changes in
> two places.  Maybe the script can look at $0 (the Perl equivalent of C's
> argv[0]) to decide what to do.

The lack of command line options to sensors-detect is for historical
reasons, mostly. That and the fact that nobody took the time to design
and propose a command line interface. The trick with command line
interfaces is that it's easier to add flags or parameters than to
remove or change them. Once people - or external scripts - are used to
a command line syntax, you get a lot of complaints if you change it.
So, when we add a command line interface to sensors-detect - and I
think we should - we need to put some thinking into it first.

> The "dangerous" version or mode of the script should probably also print
> out a liberal amount of warnings; Achim isn't that angry about his CPU
> dying, but a less technically advanced user might not be so forgiving.
> If the script prompts with "This probe might turn your CPU into a $300
> paperweight, are you sure?  yes-I-want-to-melt-my-CPU/N >" then you can
> avoid the "but nobody TOLD me" complaints.

I agree. As I gain experience with the different ways hardware
manufacturers can use the most unexpected chips in PC mainboards, I
realize that the first goal of sensors-detect must be changed from
"detect as many possible sensor chips as possible" from "detect sensors
on as many boards as possible without breaking any". At least for the
default behavior. As you wrote before, we will probably want a command
line option to revert to the previous behavior for people who really
want that.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
