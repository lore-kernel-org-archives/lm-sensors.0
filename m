From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 11 May 2012 09:45:18 +0000
Subject: Re: [lm-sensors] Coretemp: Fix threshold attributes patch
Message-Id: <20120511114518.39725c19@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D68720C2E767A4AA6A8796D42C8EB591185A1@BGSMSX102.gar.corp.intel.com>
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591185A1@BGSMSX102.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 9 May 2012 08:15:49 -0700, Guenter Roeck wrote:
> On Mon, 2012-05-07 at 11:33 -0400, R, Durgadoss wrote:
> > Some time ago, you had submitted a patch to fix the usage of threshold
> > attributes
> > 
> > in coretemp driver. But we had some discussions and it did not get
> > merged.
> > 
> > I would really like to see that patch in mainline. Is there something
> > that we
> > 
> > can discuss/decide and I can work on it to submit it again, with
> > changes needed,
> 
> problem is that neither Jean nor me are happy with it. I think it is
> something that should, by its nature, reside in the thermal subsystem.

IIRC my main concern was that nobody was ever able to explain what
semantics the thresholds were supposed to have, i.e. whether they were
low or high limits, what was supposed to happen when they were crossed
and who was responsible for acting upon alarm and clearing these alarms.

As long as these questions are unanswered I don't feel safe applying
your patch, because I suspect it could conflict with the BIOS, and I
also don't see any value for the users.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
