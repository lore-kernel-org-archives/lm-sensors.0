From: kress@hal.saar.de (Michael Kress)
Date: Sun, 15 Oct 2006 20:56:40 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors not working
Message-Id: <4532A088.5020404@hal.saar.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <451FF905.60001@hal.saar.de>
In-Reply-To: <451FF905.60001@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Jean Delvare wrote:
>> I recompiled the kernel without CONFIG_PCI_MSI and the same thing
>> happened. It's absoluteley the same config as before...
>>     
>
> Did you also cycle the pc87427 module several times this time?
>   

No, I just loaded it once.

> Well the problem occurs in vfs_read(), so even before reaching the
> pc87427 code. I don't quite see how my driver could be responsible.
>
> You could try repeatedly reading other random sysfs files instead, to
> see if you can reproduce the problem.
>
> Which 2.6.16 kernel are you using exactly? The 2.6.16.y series was
> quite long, please make sure you are using one of the latest updates.
>
> If this is an SMP and/or PREEMPT kernel, you may want to try UP and/or
> non-PREEMPT to see if it makes a difference.
>   
It's the one that's being downloaded with xen-3.0.2, i.e.
linux-2.6.16.tar.bz2
I tried it with the stock kernel from CentOS (kernel-2.6.9-42.0.3.EL)
but pc87427 doesn't compile with that, although there's lots of stuff
back-patched.
I can't get another kernel than 2.6.16, because all the xen patches rely
on this version and I need xen.
I will try the newest from the 2.6.16.y series, give me another day to
try it, I think xen provided the oldest 2.6.16 one it could find. I'll
tell you if I got further with that.
Maybe it's also related with the "nobody cared" phenomena from
http://www.ussg.iu.edu/hypermail/linux/kernel/0610.1/0101.html - I
suspect the irq issue to be Supermicro related.

Salut - Michael

-- 
Michael Kress, kress at hal.saar.de
http://www.michael-kress.de / http://kress.net
P E N G U I N S   A R E   C O O L


