From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 01 Apr 2006 18:54:57 +0000
Subject: [lm-sensors] PIIX4 and fix_hstcfg
Message-Id: <20060401205457.42a2f9a5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <442E9B64.50909@sh.cvut.cz>
In-Reply-To: <442E9B64.50909@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf, Tom,

> > Note that I just use this as a crashbox now so if it's more trouble than
> > it's worth, I wouldn't mind it being dropped.
> 
> Thanks for the lspci. It seems it has no PCI subsystem ID regs???
> Because of this much easier would be just drop.

Maybe we can use DMI instead. Tom, can you please provide the output of
dmidecode for this system? Maybe others still use it.

Tom, do you remember if any other system ever needed this option?

> I will drop the param + the warning of course.

If we do that, we must update the documentation and maybe have a
dedicated section for the faulty system. I guess that setpci can be
used to change the register value?

Thanks,
-- 
Jean Delvare

