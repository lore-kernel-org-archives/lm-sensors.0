From: Matt Roberds <mattroberds@cox.net>
Date: Mon, 05 May 2008 00:10:30 +0000
Subject: Re: [lm-sensors] Reverting the probe order
Message-Id: <Pine.LNX.4.64.0805041843450.8511@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080504193054.2a81247b@hyperion.delvare>
In-Reply-To: <20080504193054.2a81247b@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 4 May 2008, Jean Delvare wrote:
> It just occurred to me today that the order in which we probe for
> sensor chips in sensors-detect doesn't make sense. [...] Comments?

I agree that changing the order to do the "safer" probes first is a good
idea.  However, I think that if some probes are skipped based on the
results of earlier probes (like your example of skipping the ISA probe if
a SuperIO chip with monitoring is found), there ought to be some way to
force these probes to be done.  The reason is that as soon as you code
something like that into sensors-detect, Advanced Intel Devices will
come out with the new Athlete Sexium XQ y8 Core Octo processor and a
reference motherboard design that breaks the new version of sensors-
detect.

One of the goals of sensors-detect seems to be that you don't need to
configure it much (no command-line options); you just run it and it
figures things out.  Adding a --force-unsafe-probing option might be
considered to be a bad idea.  One option might be to have two scripts -
say sensors-detect and sensors-detect-this-might-explode-your-hardware -
but then you have duplicate code and have to make the same changes in
two places.  Maybe the script can look at $0 (the Perl equivalent of C's
argv[0]) to decide what to do.

The "dangerous" version or mode of the script should probably also print
out a liberal amount of warnings; Achim isn't that angry about his CPU
dying, but a less technically advanced user might not be so forgiving.
If the script prompts with "This probe might turn your CPU into a $300
paperweight, are you sure?  yes-I-want-to-melt-my-CPU/N >" then you can
avoid the "but nobody TOLD me" complaints.

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
