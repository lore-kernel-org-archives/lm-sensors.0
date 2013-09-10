From: Wei Ni <wni@nvidia.com>
Date: Tue, 10 Sep 2013 04:25:50 +0000
Subject: Re: [lm-sensors] [PATCH v3 2/2] Documentation: dt: hwmon: add OF document for LM90
Message-Id: <522E9F4E.2060109@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1378722552-10357-1-git-send-email-wni@nvidia.com> <1378722552-10357-3-git-send-email-wni@nvidia.com> <522E489D.6080903@wwwdotorg.org> <20130909222330.GA31708@roeck-us.net>
In-Reply-To: <20130909222330.GA31708-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 09/10/2013 06:23 AM, Guenter Roeck wrote:
> On Mon, Sep 09, 2013 at 04:15:57PM -0600, Stephen Warren wrote:
>> On 09/09/2013 04:29 AM, Wei Ni wrote:
>>> Add OF document for LM90 in Documentation/devicetree/.
>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/lm90.txt
>>> b/Documentation/devicetree/bindings/hwmon/lm90.txt
>>
>>> +Optional properties:
>>
>>> +- interrupts: Contains a single interrupt specifier which
>>> describes the +              LM90 pin6 output.
>>
>> Does the pin also have a standard name you could include here, rather
>> than (or in addition to) just the pin number?
>>
> This is the "ALERT" pin (or maybe "-ALERT" to reflect that it is low-active).

Thanks, Guenter, I will update it.
> 
> Guenter
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
