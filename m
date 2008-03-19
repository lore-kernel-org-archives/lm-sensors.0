From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 19 Mar 2008 09:40:00 +0000
Subject: Re: [lm-sensors] possible bug in 2.6.25-rc6: message going "Setting
Message-Id: <20080319024000.44658f87.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <47E0DDAD.2090900@hhs.nl>
In-Reply-To: <47E0DDAD.2090900@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 19 Mar 2008 10:12:26 +0100 Uwe Bugla <uwe.bugla@gmx.de> wrote:

> Hello Andrew,
> 
> if I boot my machine with kernel 2.6.25-rc6 the following message appears:
> "Setting sensors limits failed!" ("failed" appears red coloured).
> 
> This message does not appear as failure message in all precedent kernels (<= 
> 2.6.25-rc5).
> 
> As I do not know from which module the error derives from I would appreciate 
> you to route that mail to the appropriate maintainer.
> 

lm-sensors, I guess.

I assume that 2.6.24 kernel don't do this?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
