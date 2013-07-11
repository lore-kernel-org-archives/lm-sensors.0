From: Wei Ni <wni@nvidia.com>
Date: Thu, 11 Jul 2013 08:34:41 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/2] ARM: dt: t30 cardhu: add dt entry for nct1008
Message-Id: <51DE6E21.7090305@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1373455798-2944-1-git-send-email-wni@nvidia.com> <1373455798-2944-2-git-send-email-wni@nvidia.com> <20130710171319.GB15665@dhcp-172-17-186-34.nvidia.com>
In-Reply-To: <20130710171319.GB15665-RcKxWJ4Cfj3FNiLNb7+IINdj8bHVeoWogfoxzgwHRXE@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 07/11/2013 01:13 AM, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Wed, Jul 10, 2013 at 07:29:57PM +0800, Wei Ni wrote:
>> Enable thermal sensor nct1008 for t30 cardhu.
> 
> Nit: "Tegra30 Cardhu"
> 
>> diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
> [...]
>>  				};
>>  			};
>>  		};
>> +
>> +		nct1008: nct1008 {
> 
> I don't think it's very likely that this chip will need to be referenced
> by a phandle, in which case the "nct1008:" label can be dropped. Even if
> it was used at some point in the future, it's better to add it at that
> time.

Ok, I will remove it.

In the future, I may use this node in the thermal framework, something like:
thermal_zone {
sensor = <&nct1008>;
cooling = <&xxxx>;
....
}
So, at that time I will try to add it again.

Thanks.
Wei.

> 
> Thierry
> 
> * Unknown Key
> * 0x7F3EB3A1
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
