From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 08 Jul 2013 20:06:23 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (lm90) add support to handle irq
Message-Id: <20130708200623.GA1506@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1372924670-16355-1-git-send-email-wni@nvidia.com>
 <1372924670-16355-3-git-send-email-wni@nvidia.com>
 <51D703C9.1060607@wwwdotorg.org>
 <20130705194728.GA24946@roeck-us.net>
 <51DADEE1.1030408@wwwdotorg.org>
In-Reply-To: <51DADEE1.1030408-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TZX6JHB/w77yyCwEArCW2h5@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Jul 08, 2013 at 09:46:41AM -0600, Stephen Warren wrote:
> On 07/05/2013 01:47 PM, Guenter Roeck wrote:
> > On Fri, Jul 05, 2013 at 11:35:05AM -0600, Stephen Warren wrote:
> >> On 07/04/2013 01:57 AM, Wei Ni wrote:
> >>> Add support to handle irq. When the temperature touch
> >>> the limit value, the driver can handle the interrupt.
> >>
> >>> +	if (client->irq >= 0) {
> >>
> >> 0 isn't a valid IRQ, so you can write that as simply if (client->irq).
> >>
> > If I recall correctly, it is valid on some platforms.
> 
> I thought ARM (just some ARM sub-architectures?) might have been the
> last architecture, and even irrespective of that, we were trying not to
> introduce any new code that relies on this strangeness, so it doesn't
> propagate?
> 
Sounds good to me. Another problem, though, may be that NO_IRQ is sometimes
defined as -1, sometimes as 0, sometimes as 0xffffffff, and sometimes as INT_MAX.
Which of course is another mess :(.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
