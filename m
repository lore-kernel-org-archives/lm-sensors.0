From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 29 May 2006 17:36:08 +0000
Subject: [lm-sensors] procedure for submitting patches
Message-Id: <20060529193608.16a37ac3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060510173848.GC30963@grok.co.za>
In-Reply-To: <20060510173848.GC30963@grok.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Thomas,

Sorry for the late answer.

> I'm not about to submit a patch, but sometime in the future I will be
> doing so, so I want to understand fully how it works around here.
> Firstly some notes though:
> 
> In the module that I'm working on:
> 
>     (a) I have found (and fixed) a bug in the original code.
>     (b) I have made enhancements that are not all related to one
>         another.
> 
> Should I submit seperate patches for all the different bits that I've
> done, or should I (at least initially) submit one huge patch for the
> lot?

Alawys submit seperate patches. There are no exceptions to this rule.

> Is there one specific person that I should send the patch(es) to, or is
> the list the place where it all happens?

Yes, this list is the right place (assuming your work is related to
hardware monitoring or i2c). For bug fixes, or if you think your patch
is ready to be pushed upstream, it's a good idea to Cc me.

> I'm pretty new to all this, so I can imagine that my code will have to
> be massaged a bit to fit in properly..

Probably, but we try to be nice with newcomers, so don't worry :)

-- 
Jean Delvare

