From: Wei Ni <wni@nvidia.com>
Date: Thu, 31 Oct 2013 03:30:42 +0000
Subject: Re: [lm-sensors] [PATCH v5 0/3] Add power control for lm90
Message-Id: <5271CEE2.4000202@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1381137940-22608-1-git-send-email-wni@nvidia.com>
	<525E05E3.4040708@nvidia.com>	<526092A6.4050205@nvidia.com>
	<52707138.10903@nvidia.com> <20131030155542.7a09b861@endymion.delvare>
In-Reply-To: <20131030155542.7a09b861-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 10/30/2013 10:55 PM, Jean Delvare wrote:
> Hi Wei,
> 
> I'm sorry again that I always take so much time reviewing your patches.
> I always have higher priority tasks at work and at the end of the day
> reviewing the lm90 patches never makes it to the top of my to-do
> list :( I'll try to review a few lm90 patches today...

I really appreciated you reviewed my patch so carefully.
Since this series will block the lm90 on tegra board, so we wish to add
this before v3.13 merge window.
Looking forward your comments on this series :)

Thanks.
Wei.

> 
> Jean
> 
> On Wed, 30 Oct 2013 10:38:48 +0800, Wei Ni wrote:
>> Hi, Jean
>> Since no more comments on this series, could you take this series before
>> the 3.13 merge window ?
>> Because if without this series, the lm90 will be broken on the Tegra
>> Dalmore board, and this problem will be get into the v3.13 release.
>>
>> Looking forward to your reply :)
>>
>> Thanks.
>> Wei.
>>
>> On 10/18/2013 09:45 AM, Wei Ni wrote:
>>> On 10/16/2013 11:20 AM, Wei Ni wrote:
>>>> Hi, Jean
>>>>
>>>> Do you have any comments on this series, or will you take them ?
>>>
>>> Hi, Jean, will you apply this series befor the 3.13 merge window?
>>>
>>> Since I forgot to tell Stephen not to apply the "[PATCH 0/2] Update dts
>>> file to support lm90 well" untile this series are accept, so if without
>>> this change, the lm90 may be broken on the Dalmore board.
>>>
>>> Thanks.
>>> Wei.
>>>
>>>>
>>>> Thanks.
>>>> Wei.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
