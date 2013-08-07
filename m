From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 07 Aug 2013 06:30:34 +0000
Subject: Re: [lm-sensors] New Sensors, which info you need off me?
Message-Id: <5201E98A.40403@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <5201DF24.1040803@rzschernsdorf.de>
In-Reply-To: <5201DF24.1040803@rzschernsdorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/06/2013 10:46 PM, Martin Herrholz wrote:
> Hi lm-sensors-team,
>
> got a new Mainboard which doesnt have any sensors detected with lm-sensors yet, what infos could help you do get it running?
>
> Mainboard:
> Asus F2A85-M LE
>
> Message where sensors-detect seems to find an unknown chip:
>
> Trying family `ITE'...                                      Yes
> Found unknown chip with ID 0x8623
>      (logical device 4 has address 0x290, could be sensors)
>
>

Chip is ITE IT8623E. I don't think there is much we can do. There is no public datasheet,
and it is difficult to get one without signing an NDA ... which makes writing a driver
almost impossible, even if you find someone who has the time to do it.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
