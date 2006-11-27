From: ukessler@uni-bonn.de (=?ISO-8859-1?Q?Ulrich_Ke=DFler?=)
Date: Mon, 27 Nov 2006 09:14:14 +0000
Subject: [lm-sensors] CPU temperature(s) of Conroe
Message-Id: <456AAC66.9040206@uni-bonn.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20061123T125301-366@post.gmane.org>
In-Reply-To: <loom.20061123T125301-366@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, Rudolf,

>
> Yep I can. What distribution are you using? Debian? Fedora? Suse? ..?
>
It's SUSE 10.1, Kernel 2.6.16.21-0.25-smp
(ASUS P5B-VM, E6600, 2 x 1 GB DDR2-667 CL4)

>
> Yes you will need to uninstall the package called "lm-sensors" or 
> libsensors3 the make user_install stuff is "outside" your packaging 
> system. Ie it is same as you would just copy some software to your 
> disk drive. And because you want that newer version without installer 
> (no package) you  need to uninstall the package first. In short:
>
> Because now you have installed two in the system. One sensors detect 
> you have in /usr/sbin/sensors-detect and other you have in (the new 
> one) /usr/local/sbin
>
> Try to issue following command:
>
> /usr/local/sbin/sensors-detect
>
Okay, this one finds the Winbond W83627ehf and the Core2Duo processor 
(revision 4242 of sensors-detect, 2006-11-17) .
I tried to remove the old "SUSE version" with YAST but I get a lot of 
missing dependencies warnings. Is it safe to delete all those things 
(kdebase3-*, amarok-*,kdeaddons-*, susehelp* etc.)?

>
> Well this is a bit tricky to do. First I need to know what 
> distribution you are using. Compiling new kernel image is certainly 
> not task for beginners, but we may try.


SUSE 10.1, Kernel 2.6.16.21-0.25-smp, last kernel patches installed 
(SUSE Online Update).

I'm beginning to see the ligth at the end of the tunnel.

Best regards
Uli




