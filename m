From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: [PATCH] Port of w83627hf to kernel 2.6
Message-Id: <20040225051106.GB20698@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <000801c3f596$0f1ffd00$0300a8c0@berninoti>
In-Reply-To: <000801c3f596$0f1ffd00$0300a8c0@berninoti>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2004-02-21 16:50:17 +0100]:
> > I have corrected this and attached the new patch to the mail.
> 
> I just commited a new fix to the w83627hf driver (CVS). Could you
> incorporate it in your driver? (Sorry ;))
> 
> Also, please consider changing this:
> +     If you say yes here you get support for the Winbond W836X series
> to:
> +     If you say yes here you get support for the Winbond W836X7 series
> 
> Not very important, I admit, but I think it designates the family better.
> 
> MMH, can you take care about this port (review, test if possible, and
> send to Greg)?

I have reviewed and tested it, btw, on w83627thf.

I can take over and make the changes you (Jean) mentioned.  But, what
about the sysfs names?  Do we want this driver to go through -mm tree
first?  If so, I'll make those changes as well and prepare a patch.

Better still, Greg, please apply Bernhard's most recent patch as-is for
-mm; then I will send another patch within a couple days for the rest.

(This way there's a clear attribution for Bernhard's good work before
I take over and foul it up. ;)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
