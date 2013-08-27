From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Tue, 27 Aug 2013 14:50:50 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon: (acpi_power_meter) Fix incorrect placement of __initdata
Message-Id: <CAK9yfHwU5Txo=_Sa+GKwTSj8bEnjM+FvxM2HJJcpCG7TzSAhsA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375868833-566-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1375868833-566-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 27 August 2013 19:40, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Aug 27, 2013 at 03:57:53PM +0200, Jean Delvare wrote:

> Yes, better not to change what's already there if it works fine.
> However, as I mentioned in my previous email, it's probably better to
> have a convention here for new code rather than having people stick
> these markers in random places within the declaration and hit the "it
> silently doesn't work" case.

 init.h header file mentions the following about the attribute placement:

 For initialized data:
* You should insert __initdata between the variable name and equal
* sign followed by value, e.g.:
*
* static int init_variable __initdata = 0;
* static const char linux_logo[] __initconst = { 0x32, 0x36, ... };

-- 
With warm regards,
Sachin

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
