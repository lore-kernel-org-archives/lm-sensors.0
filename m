From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 24 Aug 2006 20:28:13 +0000
Subject: [lm-sensors] PATCH: hwmon-abituguru-timeout-fixes.patch
Message-Id: <20060824222813.98404cfe.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44DB23B1.1060102@hhs.nl>
In-Reply-To: <44DB23B1.1060102@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> To the latest version of abituguru.c which I send to you (in the form of 
> my original submission + all accepted patches). But someone upstream has 
> been fixing some spelling mistakes in the comments, which caused the 
> patch to not apply to upstream's tree, I've attached a new version 
> against upstreams latest tree (2.6.18-rc4-git1).

Works better, great :) I'll push it to Greg tomorrow.

In general you shouldn't expect your local copy to be the latest
version of the driver, even if you are the maintainer. Generic changes
can be applied to your driver anytime.

> >> @@ -331,7 +338,8 @@
> >>  	/* And read the data */
> >>  	for (i = 0; i < count; i++) {
> >>  		if (abituguru_wait(data, ABIT_UGURU_STATUS_READ)) {
> >> -			ABIT_UGURU_DEBUG(1, "timeout exceeded waiting for "
> >> +			ABIT_UGURU_DEBUG(retries? 1:3,
> > 
> > Broken coding style.
> > 
> 
> How exactly, I guess I should have used spaces somewhere, but where exactly?

retries ? 1 : 3

(I've changed it for you.)

-- 
Jean Delvare

