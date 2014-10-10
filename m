From: worley@alum.mit.edu (Dale R. Worley)
Date: Fri, 10 Oct 2014 19:22:51 +0000
Subject: Re: [lm-sensors] systemd integration: Problem with modprobe in lm_sensors.service
Message-Id: <201410101922.s9AJMp0D021102@hobgoblin.ariadne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201410081842.s98Igvmj004161@hobgoblin.ariadne.com>
In-Reply-To: <201410081842.s98Igvmj004161@hobgoblin.ariadne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> From: Jean Delvare <jdelvare@suse.de>

> What really surprises me though is that Dale seems to see the problem
> on Fedora, while I thought Jaromir had already committed his fix there,
> regardless of upstream acceptance.

It's possible that the patch has been put into Fedora 20 but not into
Fedora 19 (which is what I'm running).  (*Not* Fedora 16 as I
mistakenly wrote, ugh.)

> As a summary, I agree that there is a problem, but I am not a big fan
> of using wrapper shell scripts to solve it, for it defeats the purpose
> of systemd.

That's true.  On the other hand, there's no way in systemd to mark an
ExecStart action in a service as "execute this if and only if (some
condition)".

(There are Conditional qualifiers you can put on a unit, but they seem
to apply to the unit as a whole, and we always want the ExecStart of
/usr/bin/sensors to run.  If the ExecStart lines were put into Bash,
we could use shell conditionals to handle it, but that is precisely
what the design wants to avoid.  I suppose you could split the
modprobe into a separate until that is to be executed before
lm_sensors.service, and have the configuration-detector do whatever is
needed to tell systemd to ignore the unit if no modules need to be
loaded.)

> Unfortunately I have to admit that I did not take the time to
> actually implement my idea in openSUSE, so I still don't know for
> sure if it would work OK.

As James Morris said, 

    Finally, I'll offer eight opinions that computer scientists who venture into
    the real world should consider:
	    ...
	    3. Virtual << Real.
	    ...

We have to go with whatever exists.

Dale

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
