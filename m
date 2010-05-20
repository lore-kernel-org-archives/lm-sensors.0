From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 20 May 2010 11:57:27 +0000
Subject: Re: [lm-sensors] Simple fan question
Message-Id: <20100520135727.7a0e07bd@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1272518506.24542.163.camel@pasglop>
	<20100429105740.6e3b7716@hyperion.delvare>
	<1272581806.24542.185.camel@pasglop>
	<AANLkTilRvyWK-SEp2pgVAosaJ8GQUbbXsP4BkZBxGphU@mail.gmail.com>
In-Reply-To: <AANLkTilRvyWK-SEp2pgVAosaJ8GQUbbXsP4BkZBxGphU@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ray Lee <ray-lk@madrabbit.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, lm-sensors@lm-sensors.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 17 May 2010 08:59:50 -0700, Ray Lee wrote:
> On Thu, Apr 29, 2010 at 3:56 PM, Benjamin Herrenschmidt <
> benh@kernel.crashing.org> wrote:
> 
> > Now, maybe the best option is to have instead:
> >
> >        fan[1-*]_discrete_value
> >                Discrete value
> >                RW
> >
> >        fan[1-*]_supported values
> >                List of supported discrete values
> >                RO
> >
> 
> Perhaps a granularity (ie, step-size) instead of a full list of values?

A possible addition to the current API, yes. But it may not cover all
cases: the step size isn't necessarily constant.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
