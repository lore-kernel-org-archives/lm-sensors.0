From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 May 2011 14:24:33 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110510162433.0dbd4d76@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jeff,

On Tue, 10 May 2011 08:54:21 -0500, Jeff Rickman wrote:
> I checked for any packages that could manipulate the CPU frequency. I 
> only found "cpuspeed". I removed the "cpuspeed" package and rebooted to 
> ensure a known state. Attempting to install the "stock i8k" module 
> causes a crash. Reboot to return to known state.
> 
> I changed the "maxcpus=4" in "grub.conf" to "maxcpus=1". Reboot.
> 
> Attempt to load "stock i8k" module. Crash. "/proc/cpuinfo" shows 1 CPU.

Care to try again with maxcpus=0? I seem to recall that this disables
even more of SMP than maxcpus=1 does.

> Return system to previous configuration with "cpuspeed" and reboot.
> 
> My only other choice would be to physically pull CPU2, leaving CPU1 in 
> the system, but we know that config should work based on Harry's testing.

We don't, actually. You have different software environments and maybe
different BIOS options. And not exactly the same hardware either...

But I totally understand that you don't want to physically remove the
second CPU. I'm not even sure if that would help.

OTOH, if you see an option in the BIOS to disable HT, that would be
worth trying.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
