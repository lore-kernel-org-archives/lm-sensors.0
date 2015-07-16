From: "Odzioba, Lukasz" <lukasz.odzioba@intel.com>
Date: Thu, 16 Jul 2015 13:17:04 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: coretemp: use list instead of fixed size array for temp data
Message-Id: <D6EDEBF1F91015459DB866AC4EE162CCF766C8@IRSMSX103.ger.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436976253-4810-1-git-send-email-lukasz.odzioba@intel.com>
 <20150715230734.76347af2@endymion.delvare>
In-Reply-To: <20150715230734.76347af2@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>
Cc: "linux@roeck-us.net" <linux@roeck-us.net>, "Yu, Fenghua" <fenghua.yu@intel.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On  Wednesday, July 15, 2015 11:08 PM Jean Delvare wrote:
> I see the benefit of removing the arbitrary limit, but why use a list
> instead of a dynamically allocated array? This is turning a O(1)
> algorithm into a O(n) algorithm. I know n isn't too large in this case
> but I still consider it bad practice if it can be avoided.

This patch tries to solve two problems which are present on current hardware:
-cpus with more than 32 cores
-core id is greater than NUM_REAL_CORES

In both cases it ends up with the following error in dmesg:
coretemp coretemp.0: Adding Core XXX failed

We could just bump NUM_REAL_CORES to 128 like we did in 2012 and call it 
solved, but the problem will come back eventually and it is waste of 
memory for cpus with handful of cores.

If there is way to obtain maximum core id during module initialization,
then we can allocate array and keep O(1) access. If we can't figure out
maximum core id then we can increase size of the array when new cores are
added. The problem with this is that core id enumeration can be sparse so
again we have waste of memory.

> Do you expect core IDs to become arbitrarily large?
> Significantly larger than the core count?

The question is what does significantly mean.
According to Documentation/cputopology.txt:
---
2) /sys/devices/system/cpu/cpuX/topology/core_id:

	the CPU core ID of cpuX. Typically it is the hardware platform's
	identifier (rather than the kernel's).  The actual value is
	architecture and platform dependent.
---

Even now we can have one core present with id like 60 (think of Xeon Phi).
I haven't seen in the wild insane core ids like thousands, but I don't see
a reason why we shouldn't handle it in a proper manner.

Current patch does not use more memory than it is needed, but the pitfall is
that it increased access complexity from O(1) to O(n). We could slide another
patch on top of this one to reduce access complexity from O(n) to O(logn)
by using i.e. radix tree. I preferred to send functional fix in the first
place, and then work on optimization if there is a concern about it.
Forgive me if it is not appropriate.


> You need a better patch description for sure. Saying what the patch does
> isn't sufficient, you need to explain why this is needed and why this is
> the right way to do it.

Thanks, I'll address that in the next revision, but first we need to figure out
the way to go. If this patch is not appropriate, then it is a follow up to 
start discussion on how to fix those two problems I mentioned. 

Thanks,
Lukas
--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
