From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 08 Aug 2013 21:33:45 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/3] ARM: dt: t114 dalmore: add dt entry for nct1008
Message-Id: <52040EB9.2050908@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com> <1375944991-29182-3-git-send-email-wni@nvidia.com> <52040146.7060703@cogentembedded.com> <52040236.2080701@wwwdotorg.org>
In-Reply-To: <52040236.2080701@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Wei Ni <wni@nvidia.com>, khali@linux-fr.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, MLongnecker@nvidia.com, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 08/08/2013 01:40 PM, Stephen Warren wrote:
> On 08/08/2013 02:36 PM, Sergei Shtylyov wrote:
>> Hello.
>>
>> On 08/08/2013 10:56 AM, Wei Ni wrote:
>>
>>> Enable thermal sensor nct1008 for t114 dalmore.
>>
>>> Signed-off-by: Wei Ni <wni@nvidia.com>
>>> ---
>>>    arch/arm/boot/dts/tegra114-dalmore.dts |   10 +++++++++-
>>>    1 file changed, 9 insertions(+), 1 deletion(-)
>>
>>> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts
>>> b/arch/arm/boot/dts/tegra114-dalmore.dts
>>> index b5a42f0..9d4d2b2 100644
>>> --- a/arch/arm/boot/dts/tegra114-dalmore.dts
>>> +++ b/arch/arm/boot/dts/tegra114-dalmore.dts
>>> @@ -738,6 +738,14 @@
>>>                realtek,ldo1-en-gpios >>>                    <&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
>>>            };
>>> +
>>> +        nct1008 {
>>
>>     ePAPR [1] says: "the name of a node should be somewhat generic,
>> reflecting the function of the device and not its precise programming
>> model". So I suggest "thermal"
>
> True, although there's quite some precedent for node-names being the
> chip name for external chips in existing DTs. If we change this node
> name, I'd like to see a patch that makes all the other "nct1008" nodes
> match the new name...
>

On the other side, one should not use a bad example as an argument or excuse
to make the same mistake again (though I keep hearing it all the time ... ).
I for my part tend to use something like temp-sensor or temp-sensor@1c.
Advantage of that kind of node name is that it auto-describes the node.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
