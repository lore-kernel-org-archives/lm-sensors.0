From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 01 Dec 2010 08:18:34 +0000
Subject: Re: [lm-sensors] [PATCH] adm1026: fix setting fan_div
Message-Id: <20101201091834.42a994bb@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101130014623.GA26439@penguintown.net>
In-Reply-To: <20101130014623.GA26439@penguintown.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gabriele,

On Tue, 30 Nov 2010 17:05:48 -0800, Gabriele Gorla wrote:
> Thanks everyone for the feedback.
> 
> I resubmitted 2 bugfixes only patches:
> 1- to fix the div setting
> 2- stop rejecting div=1 since it is valid
> 
> I left the locking around the entire structure access as requested.
> 
> I can submit another patch to validate the input to 1,2,4,8 to be applied in the development 
> kernels.

Yes, please. This looks like a very good plan, thank you.

> I am not sure if we reached an agreement on the internal representation of fan_div so I 
> am leaving it alone for now.

This can be done later, by you or by me (but then I'll count on you for
testing, as I assume you have an ADM1026 chip and I don't.)

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
