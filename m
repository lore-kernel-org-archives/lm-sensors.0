From: Gabriele Gorla <gorlik@penguintown.net>
Date: Wed, 01 Dec 2010 01:05:48 +0000
Subject: Re: [lm-sensors] [PATCH] adm1026: fix setting fan_div
Message-Id: <20101201010548.GF30973@penguintown.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101130014623.GA26439@penguintown.net>
In-Reply-To: <20101130014623.GA26439@penguintown.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks everyone for the feedback.

I resubmitted 2 bugfixes only patches:
1- to fix the div setting
2- stop rejecting div=1 since it is valid

I left the locking around the entire structure access as requested.

I can submit another patch to validate the input to 1,2,4,8 to be applied in the development 
kernels.

I am not sure if we reached an agreement on the internal representation of fan_div so I 
am leaving it alone for now.

thanks,
GG

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
