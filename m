From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: EMC6D100
Message-Id: <20050112223448.071b5d0f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200501120730.58623.rafael.espindola@gmail.com>
In-Reply-To: <200501120730.58623.rafael.espindola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rafael,

> Attached is a patch to add support for the EMC6D100 in the 2.6.9
> kernel. I did  it by following the changes that were made to the cvs
> lm_sensors2 to add  support for the same chip.
> 
> It works for me on a d865glc.

I don't have an EMC6D10x chip to test on but the code looks correct to
me. I would have the following suggestions to improve the patch though
(some of which are admittedly nit-picking):

1* Don't define constants you don't use.

2* I don't think that the introduction of LM85_VERSTEP_VMASK increases
the code readability, and in fact I even think it decreases it.

3* Preserve that extra white line before the "/* Conversions. (...)"
comment. It looks innocent and doesn't deserve to get inadvertently
killed! ;)

4* Don't "indent" the body of the '100 vs. '101 comment.

I'm fine with the rest. Please update what you agree with, then resubmit
your patch to Greg KH (with CC to the list) with a "Signed-off-by: Your
Name <email@address>" line before the inlined patch and your patch will
be included into Greg's tree.

Thanks for the good work!
-- 
Jean Delvare
http://khali.linux-fr.org/
