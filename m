From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 24 Nov 2012 09:31:50 +0000
Subject: Re: [lm-sensors] [GIT PULL] x86 fixes for 3.7-rc7 v2
Message-Id: <20121124103150.54fd940a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Peter,

On Fri, 23 Nov 2012 21:15:42 -0800, H. Peter Anvin wrote:
> Hi Linus,
> 
> Here is a collection of fixes for 3.7-rc7.  This is a superset of
> tglx' earlier pull request.
> 
> The following changes since commit 8f0d8163b50e01f398b14bcd4dc039ac5ab18d64:
> 
>   Linux 3.7-rc3 (2012-10-28 12:24:48 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus
> 
> for you to fetch changes up to ee4eb87be2c3f69c2c4d9f1c1d98e363a7ad18ab:
> 
>   x86-64: Fix ordering of CFI directives and recent ASM_CLAC additions (2012-11-20 22:23:57 -0800)
> 
> ----------------------------------------------------------------
> Alex Elder (1):
>       rbd: reset BACKOFF if unable to re-queue
> 
> Andre Przywara (1):
>       x86, amd: Disable way access filter on Piledriver CPUs
> 
> Andreas Herrmann (1):
>       x86, microcode_amd: Change email addresses, MAINTAINERS entry
> 
> Boris Ostrovsky (1):
>       x86, microcode, AMD: Add support for family 16h processors
> 
> Borislav Petkov (3):
>       x86, AMD: Change Boris' email address
>       EDAC: Change Boris' email address
>       MAINTAINERS: Change Boris' email address
> 
> Cesar Eduardo Barros (1):
>       x86: remove dummy long from EFI stub
> 
> David Zafman (1):
>       ceph: fix dentry reference leak in encode_fh()
> 
> Florian Fainelli (1):
>       x86/ce4100: Fix pm_poweroff
> 
> H. Peter Anvin (2):
>       Merge commit 'efi-for-3.7-v2' into x86/urgent
>       x86-32: Export kernel_stack_pointer() for modules
> 
> Ingo Molnar (1):
>       Merge tag 'please-pull-tangchen' of git://git.kernel.org/.../ras/ras into x86/urgent
> 
> Jan Beulich (1):
>       x86-64: Fix ordering of CFI directives and recent ASM_CLAC additions
> 
> Jean Delvare (3):
>       i2c-stub: Move to drivers/i2c
>       i2c-i801: Simplify dependency towards GPIOLIB
>       i2c-i801: Fix comment

Something went wrong with this pull request. The commits above were
already in Linus' tree, so they shouldn't be mentioned here.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
