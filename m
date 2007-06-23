From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 23 Jun 2007 12:46:57 +0000
Subject: Re: [lm-sensors] Change in reported CPU temperatures
Message-Id: <20070623144657.7a6483fb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070613223645.40f82f42.rkimber@ntlworld.com>
In-Reply-To: <20070613223645.40f82f42.rkimber@ntlworld.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Richard,

On Wed, 13 Jun 2007 22:36:45 +0100, R Kimber wrote:
> Asus M2N-E with amd64x2
> Ubuntu 7.04
> lm-sensors 1:2.10.1-2ubuntu2
> 
> When I upgraded to Ubuntu 7.04 I got kernel 2.6.20-15.14
> This allowed me to monitor CPU temperatures with k8temp.
> 
> When running Boinc (5.4.11-5) projects on both processors, CPU
> temperatures were reported as being around 53C.  Idle temperature was
> around 28C.
> 
> However, on 1 June the kernel was upgraded to 2.6.20-16.28 and the
> reported temperatures immediately dropped to around 38C, without any
> config changes on my part, or as far as I know a Boinc-manager/client
> upgrade. Idle temperature remained the same.
> 
> On 9 June the kernel was upgraded again to 2.6.20-16.29 and the
> reported temperatures remained around 38C.
> 
> Is k8temp reliable?

It is known to report erroneous values for some CPU models IIRC, but
this is a hardware problem, I don't see it changing with a kernel
upgrade.

> Was there a significant change to it with the recent kernels?

You upgraded from an Ubuntu kernel to another Ubuntu kernel, both based
on the same upstream kernel version (2.6.20.) So any change in "recent
kernels" is hardly relevant. You need to check what changed in the
_Ubuntu_ kernels themselves.

> Which set of temperatures should I trust? If the
> higher, how should I go about getting the correct report?

Maybe you should trust both. You seem to assume that the k8temp driver
was reporting a wrong value, or is now. But maybe it is correct and has
always been, and your CPU temperature really is different now. This
could happen if you have a different CPUFreq policy for example (or
CPUFreq wasn't working on your CPU before and is now.)

Don't you have another hardware monitoring chip on the board? On an
Asus M2N-E, I'd really guess so. Probably an ITE or Winbond Super-I/O
with integrated sensors.

Also, what temperature does the BIOS report? That would be an
interesting comparison point.

> I have seen newsgroup comments from two other people both reporting
> different levels on similar machines !

"Similar machines" doesn't mean much. There are sooooo many things
which can affect the temperature of a system, both in hardware and
software. Every system is different.

> The bios is set for optimal fan performance (varying with temp). The
> reported fan revs are consistent with the temperatures (i.e. lower revs
> with 38C) and the machine feels, subjectively, very cool (exhaust air
> feels cool to the hand, unlike previous machines I have owned).
> 
> I should be grateful for any comments on this. I would not be overly
> worried with 53C at current ambient temperatures, but when the
> weather gets really hot I suspect it might rise quite a lot.
> 
> Naturally, I'd be very happy with 38C.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
