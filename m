From: Wei Ni <wni@nvidia.com>
Date: Mon, 24 Feb 2014 08:07:55 +0000
Subject: Re: [lm-sensors] [PATCH v5] hwmon: (lm90) split set&show temp as common codes
Message-Id: <530AFDDB.3080300@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1381215866-20608-1-git-send-email-wni@nvidia.com>
	<20131011091741.59cdaf31@endymion.delvare>
 <20140222114735.38d36f4a@endymion.delvare>
In-Reply-To: <20140222114735.38d36f4a-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

On 02/22/2014 06:47 PM, Jean Delvare wrote:
> On Fri, 11 Oct 2013 09:17:41 +0200, Jean Delvare wrote:
>> On Tue, 8 Oct 2013 15:04:26 +0800, Wei Ni wrote:
>>> Split set&show temp codes as common functions, so we can use it
>>> directly when implement linux thermal framework.
>>> And handle error return value for the lm90_select_remote_channel
>>> and write_tempx, then set_temp8 and set_temp11 could return it
>>> to user-space.
>>>
>>> Signed-off-by: Wei Ni <wni@nvidia.com>
>>> ---
>>>  drivers/hwmon/lm90.c |  166 ++++++++++++++++++++++++++++++++++----------------
>>>  1 file changed, 113 insertions(+), 53 deletions(-)
>>> (...)
>>
>> Applied with minor edits, thanks.
> 
> Wei, what's the status? With Guenter's recent cleanup of the lm90
> driver, this patch no longer applies. I never sent it upstream as it
> makes no sense without users of the new functions defined by the patch.
> Will this ever happen?
> 
> For now I am discarding this patch. If it still needed, please rebase
> on top of the current lm90 patch set:
> http://jdelvare.nerim.net/devel/linux-3/jdelvare-hwmon/
> and resend.

Hi, Jean
Sorry for no updates on this patch.

I noticed that in lm75.c, it expose itself as thermal zone device and
register on the thermal framework, so I will also implement it for
lm90.c, base on this patch.

Thanks.

> 
> Thanks,
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
