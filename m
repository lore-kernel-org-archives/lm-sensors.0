From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: LM83 driver
Message-Id: <20030709102012.3b0165ef.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030703194558.60bc8955.khali@linux-fr.org>
In-Reply-To: <20030703194558.60bc8955.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> For no longer than the /proc standard is going to last (sysfs anyone)
> I think it would be much better to have a "dummy" value.

Why that? Our structures are flexible enough to support that, libsensors
supports it, sensors supports it. In which case would the dummy value
help? I just can't see any.

As for the procfs vs. sysfs thing, it is unrelated IMHO. If we are to
allow 2-values temperature files for sysfs, we can as well do so for
procfs. If anything needs to be changed to support this (I still don't
see what yet), it will have to for at least sysfs so it maybe won't even
notice it's the same for some recent procfs drivers.

Of course, adding a dummy value is easy and we already have at least one
driver that does it - adm1021 for lm84 - but I don't like adding
constraints when I feel they will only slow us down on our path to
progress. Letting the driver choose how many temperature values it wants
to repport is a good idea, methinks. One could imagine drivers only
repporting the current value, or max and current (this is the case for
my lm83 driver), or over, hyst and current as most of our drivers do.
But there are other possibilities, such as max, min, current (I think we
have some drivers that do that) or max, hystmax, min, hystmin and
current resulting in a 5-value file. The same could apply to other
measures such as in's and fan's.

The fact that we try to have a common base for all sensor drivers
doesn't mean we must ignore chips specificity. Sadly, it looks like this
is what we tend to do when a single drivers support many, many chips. I
think that's something we should think about. After all, that's the idea
Unix is living with for decades (do one thing and do it well).

Comments welcome, of course.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
