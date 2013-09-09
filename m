From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 09 Sep 2013 22:23:30 +0000
Subject: Re: [lm-sensors] [PATCH v3 2/2] Documentation: dt: hwmon: add OF document for LM90
Message-Id: <20130909222330.GA31708@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1378722552-10357-1-git-send-email-wni@nvidia.com>
 <1378722552-10357-3-git-send-email-wni@nvidia.com>
 <522E489D.6080903@wwwdotorg.org>
In-Reply-To: <522E489D.6080903-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Sep 09, 2013 at 04:15:57PM -0600, Stephen Warren wrote:
> On 09/09/2013 04:29 AM, Wei Ni wrote:
> > Add OF document for LM90 in Documentation/devicetree/.
> 
> > diff --git a/Documentation/devicetree/bindings/hwmon/lm90.txt
> > b/Documentation/devicetree/bindings/hwmon/lm90.txt
> 
> > +Optional properties:
> 
> > +- interrupts: Contains a single interrupt specifier which
> > describes the +              LM90 pin6 output.
> 
> Does the pin also have a standard name you could include here, rather
> than (or in addition to) just the pin number?
> 
This is the "ALERT" pin (or maybe "-ALERT" to reflect that it is low-active).

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
