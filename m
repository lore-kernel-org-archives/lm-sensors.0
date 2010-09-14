From: "Jan Beulich" <JBeulich@novell.com>
Date: Tue, 14 Sep 2010 08:19:44 +0000
Subject: Re: [lm-sensors] [PATCH] x86/hwmon: fix module init for
Message-Id: <4C8F4C400200007800015EC7@vpn.id2.novell.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C8E139F0200007800015AA5@vpn.id2.novell.com>
 <4C8F167E.40506@linux.intel.com>
 <4C8F36B40200007800015E6B@vpn.id2.novell.com>
 <4C8F2863.5070003@linux.intel.com>
In-Reply-To: <4C8F2863.5070003@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Chen Gong <gong.chen@linux.intel.com>
Cc: fenghua.yu@intel.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

>>> On 14.09.10 at 09:46, Chen Gong <gong.chen@linux.intel.com> wrote:
> 于 9/14/2010 2:47 PM, Jan Beulich 写道:
>>>>> On 14.09.10 at 08:30, Chen Gong<gong.chen@linux.intel.com>  wrote:
>>> 于 9/13/2010 6:05 PM, Jan Beulich 写道:
>>>> In commit 0dca94baeab4a1a514841b0a4c8e3a51dfb4d5ae the call to
>>>> platform_driver_unregister() was made conditional upon !HOTPLUG_CPU,
>>>> but the return value from coretemp_init() was left to indicate an
>>>> error. This isn't correct, as the negative return value indicates to
>>>> the module loader that initialization failed, which isn't intended
>>>
>>> only !HOTPLUG_CPU can remove the driver. That is what we need to do
>>> because under the hotplug condition, we need to consider those "offline"
>>> cpus. I don't understand what you are afraid. Can you give me a scinario ?
>>
>> If the driver's init routine returns -ENODEV (like is the case without this
>> change when HOTPLUG_CPU is enabled and there is no device found),
>> the platform driver will remain registered, yet the driver memory will
>> get freed (leaving dangling pointers into the driver's former image). Or
> 
> Under this condition, I can't fine who frees the memory of the platform
> driver

I'm not talking about the control structure, but about the driver's
code and data.

>> in other words - when leaving the driver registered, the return value
>> of the init function must be zero.
> 
> Is it mandotary or just some kind of convention ?

Mandatory.

Jan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
