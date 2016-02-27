From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 27 Feb 2016 18:55:56 +0000
Subject: Re: [lm-sensors] Missing Code v4.5-rc1 [Patch v3 25/25] IT8628E
Message-Id: <56D1F13C.1030601@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <56D1B0EF.9050603@gmx.de>
In-Reply-To: <56D1B0EF.9050603@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 02/27/2016 06:21 AM, Sardaukai wrote:
> Hello everyone
>
> i have some questions about chip support cause my main-board uses the IT8628E.
> I saw a patch that these chip should work. So i decided to give it a try.
>
Seeing a patch on a mailing list doesn't mean it is upstream. In this case it isn't.

> Normally sensors-detect works with my cpu, with the kernel-rc it did not.
> If i skip that, the ITE is also not found.
>
> -------------------------------------------
> # sensors-detect revision 6284 (2015-05-31 14:00:33 +0200)
> # System: Gigabyte Technology Co., Ltd. Z170X-UD3
> # Board: Gigabyte Technology Co., Ltd. Z170X-UD3-CF
> # Kernel: 4.5.0-rc5 x86_64
> # Processor: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz (6/94/3)
>
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>
> Some south bridges, CPUs or memory controllers contain embedded sensors.
> Do you want to scan for them? This is totally safe. (YES/no): Yes
> Module cpuid loaded successfully.
> Silicon Integrated Systems SIS5595...                       No
> VIA VT82C686 Integrated Sensors...                          No
> VIA VT8231 Integrated Sensors...                            No
> AMD K8 thermal sensors...                                   No
> AMD Family 10h thermal sensors...                           No
> AMD Family 11h thermal sensors...                           No
> AMD Family 12h and 14h thermal sensors...                   No
> AMD Family 15h thermal sensors...                           No
> AMD Family 16h thermal sensors...                           No
> AMD Family 15h power sensors...                             No
> AMD Family 16h power sensors...                             No
> Intel digital thermal sensor...                             Cannot seek /dev/cpu/0/cpuid at /usr/sbin/sensors-detect line 6820.
>
Maybe something changed in the ABI, though that would be unusual.
We'll have to check.

> Some Super I/O chips contain embedded sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no): y
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor/ITE'...               No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
> Trying family `ITE'...                                      Yes
> Found unknown chip with ID 0x8628

That just means that your version of sensors-detect doesn't know
about the chip.

> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor/ITE'...               No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
> Trying family `ITE'...                                      No
> ------------------------------------------------
>
> In addition i searched drivers/hwmon/it87.c in order to find the patched code from kernel 4.5-rc5.
> Unfortunately i found no code changes from Patch v3 (i tested about 5 patches).
> Should it not be patched within 4.5-rc1 or do i miss here something?
>
Does it say anywhere that the patches were reviewed and/or accepted
for upstream integration ?

Problem is that there is hardly anyone willing to review hwmon kernel
patches nowadays, meaning they have to go in unreviewed or not at all.
Given the complexity and scope of the series, I don't want to just push
the patches into the upstream kernel without review. With that in mind,
it may take a while for the code to be upstream.

> Second question
> Is it possible to take your code from github to patch/replace it in another kernel, like 4.3 / 4.4 ?
>
Yes, that should be possible. I have been running it on earlier kernels
myself.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
