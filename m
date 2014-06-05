From: =?UTF-8?B?UGVyIERhbMOpbg==?= <per.dalen@appeartv.com>
Date: Thu, 05 Jun 2014 13:21:08 +0000
Subject: Re: [lm-sensors] [RFT][PATCH] hwmon: (ltc4151) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53906EC4.90101@appeartv.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1401925632.5828.1.camel@phoenix>
In-Reply-To: <1401925632.5828.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

On 06/05/2014 01:47 AM, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups to
> simplify the code a bit.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi,
> I don't have the h/w to test, I'd appreciate if someone can review and test this
> patch.
> Thanks,
> Axel

I have tested it on our board (PowerPC e500v2) and it works fine.

/Per

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
