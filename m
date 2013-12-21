From: Paul Walmsley <pwalmsley@nvidia.com>
Date: Sat, 21 Dec 2013 05:47:16 +0000
Subject: Re: [lm-sensors] Unhandled LM90 irq 308 on Dalmore?
Message-Id: <52B52B64.5020304@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <52B2C5AD.5080405@nvidia.com> <20131219114500.1b1ea0b7@endymion.delvare> <alpine.DEB.2.02.1312191423090.30198@tamien> <52B3B679.20206@nvidia.com> <52B46FD2.1030409@wwwdotorg.org>
In-Reply-To: <52B46FD2.1030409-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>


On 12/20/2013 08:26 AM, Stephen Warren wrote:
> On 12/19/2013 08:16 PM, Wei Ni wrote:
>>> Hi, Paul
>>> When I developed it, my Dalmore board used GPIO 116 (GPIO_PO4) as
>>> interrupt line, but according to our downsttream kernel, there also have
>>> other Dalmore board used GPIO 190 (GPIO_PX6). So I think your
>>> problems was caused by it. Please try to change the interrupt line in
>>> dts file.
> Paul, which board revision of Dalmore do you have?

Looks like an A03.

> According to the schematics, Dalmore A02 and A03 had TEMP_ALERT routed
> to GPIO PX6, and that was the only option. Dalmore A04 and A05 can route
> TEMP_ALERT to either GPIO PO4, or GPIO PX6 using 0-Ohm resistors, with
> GPIO PO4 being the default stuffing option.
>
> Note that upstream Linux *only* supports Dalmore A04, and no other
> version. If you have a different board revision, it's not expected to
> work with upstream. IIRC, Eric Brower volunteered to track down the
> correct board revision for people working on upstream.

Indeed, that's probably the problem, then

It would be good if this was documented somewhere in the upstream kernel 
tree.  And even better if the kernel was able to read the Dalmore EEPROM 
and print out a warning upon kernel boot...

thanks,

- Paul

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
