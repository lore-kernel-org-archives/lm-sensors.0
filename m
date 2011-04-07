From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 07 Apr 2011 14:05:06 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: Add submitting-patches checklist
Message-Id: <20110407140506.GA31160@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302110273-23692-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1302110273-23692-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Apr 07, 2011 at 04:12:23AM -0400, Jean Delvare wrote:
> On Wed, 6 Apr 2011 10:17:53 -0700, Guenter Roeck wrote:
> > When writing hardware monitoring drivers, there are some common pitfalls which
> > keep coming up in code reviews. This patch provides a document describing all
> > those pitfalls and how to avoid them.
> > 
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> Minor suggestion below - but no need to resend.
> 
> > +* Provide a detect function only if a chip can be detected reliably. On the
> > +  other side, if the chip can be detected reliably, provide a detect function.
> 
> Could be expressed in a more compact way as:
> 
> * Provide a detect function if and only if a chip can be detected reliably.
> 
Mathematically correct, but would people understand it ?

> (But maybe this is the mathematician in me speaking!)
> 
Mathematician myself, I prefer your wording as well. I'll go with it.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
