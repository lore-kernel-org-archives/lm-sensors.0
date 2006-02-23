From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 23 Feb 2006 13:02:10 +0000
Subject: [lm-sensors] Bug in initialisation of stopped RTC's in ds1337.c
Message-Id: <CIncD2Wf.1140699730.2844290.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <43FDAF51.50207@gassner-waagen.at>
In-Reply-To: <43FDAF51.50207@gassner-waagen.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hallo Michael,

On 2006-02-23, Michael Burian wrote:
> The current initialisation code for handling the "RTC not running" case
> is buggy. Overwritting the whole 16 regs with zero turned out to be a
> bad idea.
> (...)
> The attached patch can be applied against mainline and should fix the
> problem by detecting if the RTC is not running, changing 2 bits (OSF,
> EOSC) as necessary, and no longer overwriting the whole 16 regs.
>
> Please review, thanks

Looks sane to me, but I don't have a device to test it, and the 16-reg
zeroing might have been done for a reason. James, can you please comment
on the patch and test it?

--
Jean Delvare

