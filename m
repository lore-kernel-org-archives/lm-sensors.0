From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 01 Apr 2008 08:47:47 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] Define sysfs interfaces for ibmaem
Message-Id: <20080401084747.GE7183@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080328213646.GC7191@tree.beaverton.ibm.com> <20080329145603.7e47418f@hyperion.delvare> <20080331210135.GC7183@tree.beaverton.ibm.com> <20080401102228.712acbb5@hyperion.delvare>
In-Reply-To: <20080401102228.712acbb5@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

[Got in a car accident tonight; replies will be scarce for the next week
or two.... :(]

On Tue, Apr 01, 2008 at 10:22:28AM +0200, Jean Delvare wrote:

> OK. Another question that comes to my mind now is the unit... Do the
> chips express the value in Joules internally? I would have expected
> Watt-hours. Of course we can convert as needed, but if all known chips
> use the same unit then I think we should that unit too, to minimize the
> required conversions.

The IBM chips report some form of Joules, not Wh.

> It really depends on what the chips report. Typically the drivers
> should report the values from the chip without too much tinkering
> (other than conversion to standard units). If some chips can report
> both "instantaneous" and "average" power uses, it makes sense to have
> both sets of filenames in the standard interface. If not then I am fine
> getting rid of one set.

Hmm, I'll think about what I want to do with this.  Probably just leave
them.

> I don't think there is any precedent yet. I suggested this for
> unambiguity rather than consistency.

Ok.

> Oh well, I guess that anything shorter than 1 ms can be considered
> "instantaneous power use", so we can go with millisecond.

Ok.

> Out of curiosity, what are the values supported by the ibmaem chip?

I don't know what the lower limits are; it depends on how often the BMC
decides to update the counters, and that seems to vary by machine.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
