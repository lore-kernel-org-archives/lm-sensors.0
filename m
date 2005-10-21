From: gcoady@gmail.com (Grant Coady)
Date: Fri, 21 Oct 2005 11:39:07 +0000
Subject: [lm-sensors] [Ticket #2078] sensor values are sometimes wrong
Message-Id: <4358B6C8.40401@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051021083606.GB19748@westend.com>
In-Reply-To: <20051021083606.GB19748@westend.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Christian Hammers wrote:
> Hello
> 
> It seems to be related to the above mentioned bug number but the FAQ was
> a bit unclear how to include the ticket number in the subject :)
> 
> My problem is that sensors sometimes reports confusing values i.e.
> - it prints ALERT although the corresponding values are fine, the ALERT
>   then vanished in the next read

Yup, that is what the sensor chip reports.  It is up to _you_ properly
process the signals to suit your requirements.  ALERT is typically
cleared by the act of reading a value.
> - sensor values give suddenly 0 or arbitrary values

The sensor chips operate in an extremely noisy electrical environment,
stuff happens, your application software may denounce this.

> - configured limits are 0 for one or two reads and then go back to the
>   defined value

Again nature of the beast, your expectations do not match reality :o)

> - chassis intrusion is set just for a couple of seconds

So denounce it?
> 
> This makes it absolutely unusable for monitoring in production use.

No, you expect a kernel driver to do the work of a custom user-space
solution, IOW you want the kernel to enforce policy.  The kernel +
drivers do not enforce policy, they control access to resources.

> I had have this before on several other mainboards, too. It can be
> circumvented by reading the sensors output trice and only alert if you
> get an alert in all three readings but this should not be the task of
> the user :) On this mainboard here it is worse than ever though.

Yes, because you need to better understand the issues, when everything
looks wrong, it is time to check the viewer.  No?

> Data for this mainboard although the problem is more general and
> experienced on several other models and brands, too:

I don't do free consulting.

Grant.
