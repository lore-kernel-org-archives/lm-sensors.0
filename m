From: t.j.fritz@gmx.de (Tobias Fritz)
Date: Thu, 07 Dec 2006 13:10:47 +0000
Subject: [lm-sensors] fancontrol with IT8705F
Message-Id: <200612071410.47342.t.j.fritz@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4576F2F4.9050200@gmx.de>
In-Reply-To: <4576F2F4.9050200@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cool, this helps! If I set it to e.g. 3MHz it seems to change pretty smoothly 
over the whole range. I have to test this a little more but I don't know when 
I'll find time for it. 

If I find a value that suits me, how can I set this permanently? 

Thanks so much for your help!

Tobias

> isaset 0x295 0x296 0x14 0x00 0x70   # 24 MHz
> isaset 0x295 0x296 0x14 0x10 0x70   # 24 MHz
> isaset 0x295 0x296 0x14 0x20 0x70   # 12 MHz
> isaset 0x295 0x296 0x14 0x30 0x70   # 8 MHz
> isaset 0x295 0x296 0x14 0x40 0x70   # 6 MHz
> isaset 0x295 0x296 0x14 0x50 0x70   # 3 MHz
> isaset 0x295 0x296 0x14 0x60 0x70   # 1.5 MHz
> isaset 0x295 0x296 0x14 0x70 0x70   # 0.75 MHz
>
> As a rule of thumb, lower frequencies should give your better control,
> but you might also bring annoying sounds. Please experiment with
> different values and report.

