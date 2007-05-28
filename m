From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 28 May 2007 17:22:58 +0000
Subject: Re: [lm-sensors] THMC50 review
Message-Id: <20070528192258.0ed21854@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <web-67221254@hhs.nl>
In-Reply-To: <web-67221254@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Wed, 23 May 2007 20:08:43 +0200, Krzysztof Helt wrote:
> The information about the ADM1022 is not accurate. I have not
> tested the 2.4 kernel, but the thmc50 driver do not handle the
> adm1022 mode. It means that it works if the adm1022 is working as
> the pure thmc50 (which is default). This is not true for my
> motherboard. The adm1022 works in an extended mode (two external
> temperatures) and the 2.4 I used to create the 2.6 patch did not
> handle this.

When we list a device as supported in the wiki, it means that we have a
driver with useful functionality, not that 100% of the features of the
device are supported. When drivers have known limitations, we document
them in Documentation/hwmon/$driver. If we start giving details in the
Devices page, it will grow so fast that it will quickly become unusable.

> The result of incorrect mode wss the fan forced to full speed.

This is a bug.

> I may fix it.

This would be great, yes.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
