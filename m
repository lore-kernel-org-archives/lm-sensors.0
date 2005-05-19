From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: AW: PWM on a W83697HF
Message-Id: <20040324223023.307f706a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1079973316.405f15c4abd09@imp.gcu.info>
In-Reply-To: <1079973316.405f15c4abd09@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> But not your information is bad but the Winbond documentation itself
> is bad! On page 27 (Winbond W83697HF, Rel.Date: 04/2003, Rev. 1.2) you
> will find:"The duty cycle of PWM can be programmed by 8-bit registers
> which are defined in the Bank0 CR5A and CR5B" On page 56 you can read:
> "FAN 1 Duty Cycle Select Register-- 01h(Bank0)"

Correct, the datasheet is ambiguous. Quite usual from Winbond anyway.
They cut'n'paste most datasheets from each other and often forget to
change what needs to be.

> I contacted Winbond already to ask which information is right.

Let us know if you have an answer, although you shouldn't hope too much.

> It is fair to assume that the register 0x01 and 0x03 are the right
> ones because the values of the registers 0x01 - 0x04 after power on
> are identical to the defaults printed in the datasheet. Are you really
> sure that you are workink with 0x5A and 0x5B on a W83697HF because in
> your w83627hf.h I found:
> 
> #define W83697HF_REG_PWMCLK1		0x00
> #define W83627THF_REG_PWM1		0x01	/* 697HF too */
> #define W83697HF_REG_PWMCLK2		0x02
> #define W83627THF_REG_PWM2		0x03	/* 697HF too */

You're correct once again. I clearly need some rest or something. I
can't pretend our code actually works, I just thought that we would have
had complaints if it didn't. To make it clear, I don't own such a chip
myself, or I would have tried.

The bad thing here is that this doesn't leave much hope that you'll be
able to get PWM to work on your system. All I can think of is that you
need register 0x04 to be correctly configured for it to work (0x00,
which is the default value, is what you want according to the
datasheet). If you already have tried that (and I guess you did) and it
didn't help, there's nothing else I can think of, sorry.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
