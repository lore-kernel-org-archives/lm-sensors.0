From: "Jan Beulich" <JBeulich@novell.com>
Date: Tue, 14 Sep 2010 06:44:33 +0000
Subject: Re: [lm-sensors] [PATCH] x86/hwmon: fix initialization of	 coretemp
Message-Id: <4C8F35F10200007800015E5E@vpn.id2.novell.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C8E16770200007800015ACC@vpn.id2.novell.com>
 <4C8F178F.2080306@linux.intel.com>
In-Reply-To: <4C8F178F.2080306@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Chen Gong <gong.chen@linux.intel.com>
Cc: mingo@elte.hu, fenghua.yu@intel.com, tglx@linutronix.de, khali@linux-fr.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, hpa@zytor.com

>>> On 14.09.10 at 08:34, Chen Gong <gong.chen@linux.intel.com> wrote:
> 于 9/13/2010 6:17 PM, Jan Beulich 写道:
>> Using cpuid_eax() to determine feature availability on other than
>> the current CPU is invalid. And feature availability should also be
>> checked in the hotplug code path.
>>
>> Signed-off-by: Jan Beulich<jbeulich@novell.com>
>> Cc: Rudolf Marek<r.marek@assembler.cz>
>>
>> ---
>>   arch/x86/include/asm/cpufeature.h |    1 +
>>   arch/x86/kernel/cpu/scattered.c   |    1 +
>>   drivers/hwmon/coretemp.c          |   29 +++++++++++++----------------
>>   3 files changed, 15 insertions(+), 16 deletions(-)
>>
>> --- linux-2.6.36-rc4/arch/x86/include/asm/cpufeature.h	2010-09-13 
> 08:44:55.000000000 +0200
>> +++ 
> 2.6.36-rc4-x86-coretemp-feature-check/arch/x86/include/asm/cpufeature.h	20
> 10-09-01 09:18:17.000000000 +0200
>> @@ -168,6 +168,7 @@
>>   #define X86_FEATURE_XSAVEOPT	(7*32+ 4) /* Optimized Xsave */
>>   #define X86_FEATURE_PLN		(7*32+ 5) /* Intel Power Limit Notification */
>>   #define X86_FEATURE_PTS		(7*32+ 6) /* Intel Package Thermal Status */
>> +#define X86_FEATURE_DTS		(7*32+ 7) /* Digital Thermal Sensor */
> 
> Do we really need a new CPU flag ?

We don't strictly need one, but for one it parallels X86_FEATURE_PTS,
and it allows easy identification of the feature's availability from user
space.

Jan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
