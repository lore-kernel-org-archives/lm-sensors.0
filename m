From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 15 Apr 2007 19:46:07 +0000
Subject: Re: [lm-sensors] kernel/hwmon todo
Message-Id: <462280FF.6080004@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070415161302.GB3158@jupiter.solarsys.private>
In-Reply-To: <20070415161302.GB3158@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark, All

First of all, Mark great to hear you're stepping in to become the Maintainer 
and many thanks for this.

Mark M. Hoffman wrote:
> Hi everyone:
> 
> Here's a list of kernel patches which are not in Jean's queue[1] and which need
> review.  I've only searched the mailing list archives back through March.  I'm
> sure I've missed some, or if there are updated patches available for any of
> these, please let me know.
> 

I think you've missed the admXXXX driver backported from 2.4 which was posted a
while ago.

> PATCH: hwmon-abituguru3-new-driver.patch: Add support for newer uGuru's
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-April/019433.html
> primary reviewer: Juerg Haefliger
> 

The biggest problem with this patch currently is the discussion about the 
included chip model/revision/stepping table, which is (somewhat) needed because 
with the uguru being a software solution every motherboard essentially has its 
own version of the chip.

Jean didn't like this much because he believes this kinda info belongs in 
userspace. I've given a long reply to a mail of Jean where I explain why I 
decided to put the table in kernelspace and that I still believe this to be the 
right decision. Unfortunately that mail has gotten 0 replies.

Thanks & Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
