From: tparcina@lama.hr (=?utf-8?B?VG9taXNsYXYgUGFyxI1pbmE=?=)
Date: Wed, 16 Aug 2006 06:08:49 +0000
Subject: [lm-sensors] Vt1211
Message-Id: <79337FA3BA80774F9FE87BF809C9F356430A08@stipe.lama.hr>
List-Id: <lm-sensors.vger.kernel.org>
References: <79337FA3BA80774F9FE87BF809C9F3564309A3@stipe.lama.hr>
In-Reply-To: <79337FA3BA80774F9FE87BF809C9F3564309A3@stipe.lama.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> -----Original Message-----
> From: Juerg Haefliger [mailto:juergh at gmail.com]
> Sent: 9. kolovoz 2006 16:50
> To: Tomislav Par?ina
> Cc: lm-sensors at lm-sensors.org
> Subject: Re: [lm-sensors] Vt1211
> 
> Hi Tomislav,
> 
> No that won't work. The kernel version and the driver need to match 
> and I don't have a precompiled 2.6.11 version. 2.6.11 is too old a 
> kernel anyway.
> You need at least 2.6.17 (I believe). There's no way around a kernel 
> compilation if you want to use the latest driver.

OK, if you send me precompiled driver for Kernel that you have and I'll upgrade to that Kernel. That way it will work, right? And I'll need only to execute rpm -ivh kernel-your_version.rpm Do I have that right?

> What do you mean?

Like, last time I have tried to compile Kernel I didn't have driver (vt1211.ko) compiled? And I have selected it in make menuconfig


Tomislav
