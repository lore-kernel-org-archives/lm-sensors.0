From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 01 Jun 2011 14:07:47 +0000
Subject: Re: [lm-sensors] max1668 support revisited
Message-Id: <20110601140747.GA2102@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTi=0dC7=naE2wY6Wf5scaAtzT9bGwQ@mail.gmail.com>
In-Reply-To: <BANLkTi=0dC7=naE2wY6Wf5scaAtzT9bGwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 01, 2011 at 10:02:36AM -0400, David George wrote:
> Hi Guentor.
> 
> Thanks for all the feedback. I have attached a patch for your approval.
> 
> > The easiest way to proceed would be for you to read and follow the guidelines
> > in Documentation/hwmon/submitting-patches; this would also save us a lot of time.
> 
> I have tried to follow the guidelines as best I can. I still have
> checkpatch errors and warnings for:
> *  do not use assignment in if condition
> * consider using kstrto* in preference to simple_strtol
> I notices that other drivers do the same thing so I figured it may be okay.
> 
Not for new drivers, and we appreciate patch submissions for existing ones. 
[ No, it is not legal to drive above the speed limit, even if everyone does it. ]

I'll have a look.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
