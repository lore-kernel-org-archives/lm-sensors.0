From: Stephen Warren <swarren@wwwdotorg.org>
Date: Thu, 08 Aug 2013 20:40:22 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/3] ARM: dt: t114 dalmore: add dt entry for nct1008
Message-Id: <52040236.2080701@wwwdotorg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com> <1375944991-29182-3-git-send-email-wni@nvidia.com> <52040146.7060703@cogentembedded.com>
In-Reply-To: <52040146.7060703-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

On 08/08/2013 02:36 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 08/08/2013 10:56 AM, Wei Ni wrote:
> 
>> Enable thermal sensor nct1008 for t114 dalmore.
> 
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>   arch/arm/boot/dts/tegra114-dalmore.dts |   10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
>> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts
>> b/arch/arm/boot/dts/tegra114-dalmore.dts
>> index b5a42f0..9d4d2b2 100644
>> --- a/arch/arm/boot/dts/tegra114-dalmore.dts
>> +++ b/arch/arm/boot/dts/tegra114-dalmore.dts
>> @@ -738,6 +738,14 @@
>>               realtek,ldo1-en-gpios >>                   <&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
>>           };
>> +
>> +        nct1008 {
> 
>    ePAPR [1] says: "the name of a node should be somewhat generic,
> reflecting the function of the device and not its precise programming
> model". So I suggest "thermal"

True, although there's quite some precedent for node-names being the
chip name for external chips in existing DTs. If we change this node
name, I'd like to see a patch that makes all the other "nct1008" nodes
match the new name...


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
