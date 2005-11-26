From: daniel.n.nilsson@home.se (Daniel Nilsson)
Date: Sat, 26 Nov 2005 08:37:50 +0000
Subject: [Fwd: Re: [lm-sensors] Kernel hangs with i2c-i801 driver?]
Message-Id: <20051126073613.GG26906@oden.homeip.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Nov 25, 2005 at 08:56:49PM +0100, Rudolf Marek wrote:
> 
> Hello all,
> 
> I have a theory that changing limit values will assert SMI interrupt
> and SMI code will hang the machine. 
> Maybe the interrupt is raised via SMBALERT line which can be
> disabled in the i2c-i801.c driver. 
> 
> Eventualy i think if we switch the interrupt generation to IRQ9 so
> inux should report "IRQ9 nobody cared" instead of crarsh ... if I'm
> correct with the SMI assumption. 
> 
> you can try to:
> setpci  -s 0:1f.3 40.b=1
> 
> This will set the SMB routing interrupt to IRQ9 (or some other but
> not on SMI)
> 
> and then repeat with sensors -s
> This is a bit dangerous so please do it with filesystems mouted RO.
> 
> If you get instead of crash no crash and/or some message in dmesg we
> have won :) 

This sounds like an interesting theory, but I have a small problem
here... I can't reproduct the problem on my machine :-( I know it
happened at least 4 times before, but now it doesn't seem to happen. I
have not changed any software or recompiled the kernel. All that might
have changed are the sensors limits in sensors.conf which I did
restore to default values. There are also a few reboots that have
happened since then.

I obviously need to be able to reproduce fairly easily so that we can
see if a change has any significant effect or not, so any tips or
tricks that might force the issue would be welcome! I'm leaning
towards writing a script that will loop and write all possible values
to the limits files under sysfs. Other then that I'm out of ideas...

/Daniel
