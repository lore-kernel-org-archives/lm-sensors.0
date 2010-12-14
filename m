From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 14 Dec 2010 09:50:10 +0000
Subject: Re: [lm-sensors] [PATCH] libsensors: Add missing attributes
Message-Id: <20101214105010.73309ddf@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1292010605-22089-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1292010605-22089-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 13 Dec 2010 07:22:32 -0800, Guenter Roeck wrote:
> On Mon, Dec 13, 2010 at 05:19:10AM -0500, Jean Delvare wrote:
> > Please double-check the value of MAX_SUBFEATURES after that. I think
> > you'll have to increase it from 8 to 9.
> > 
> Yes, you are right.
> 
> > We want to either add code to check for such overflows (I have a patch
> > ready) or compute MAX_SUBFEATURES dynamically (see ticket #2378,
> > probably a better move) to avoid such problems again and again in the
> > future.
> > 
> Dynamic computation is definitely much better. I'll wait for your commit 
> before I commit my changes.

Committed, you can go ahead.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
