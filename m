From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Mar 2011 08:16:35 +0000
Subject: Re: [lm-sensors] [PATCH resend] sensors: Add support for additional
Message-Id: <20110316091635.655e8184@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110210030757.GA22858@ericsson.com>
In-Reply-To: <20110210030757.GA22858@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 15 Mar 2011 15:54:15 -0700, Guenter Roeck wrote:
> On Tue, Mar 15, 2011 at 05:50:46PM -0400, Jean Delvare wrote:
> > Apparently our unit selection algorithm picks the smallest unit if
> > value is 0? Wouldn't it make more sense to pick the base unit instead
> > (W in this case)?
> > 
> I'll add
> 	if (abs_value = 0) {
>                 *prefixstr = "";
>                 return;
>         }
> to the beginning of scale_value(). Seems to be the easiest fix.

Agreed, that's what I had in mind too.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
