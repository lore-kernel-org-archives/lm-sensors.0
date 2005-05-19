From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: fan speed for it87?? chips added
Message-Id: <20030923232236.3f8e7e91.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309232035.29480.michael.hufer@freenet.de>
In-Reply-To: <200309232035.29480.michael.hufer@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> First, I added a new mod parameter "reset_it87" which controls whether
> or not the chip is reset on module load (modprobe it87 reset_it=1,
> default) or not(modprobe it87 reset_it87=0).
> Since this worked out quiet nicely I decided to go one step further
> and also add the chips manual and automatic temperature controlled fan
> speed features (PWM etc.).
> 
> Finally I also updated the doc to document the new features.
> 
> Attached is a diff against the current cvs version.

Not tested yet (when I say tested, I should say review, since I don't
have any it87 chip here) but I already like it. The "fan to a very noisy
full speed" was already reported once (Hi Joost!) and I was analysing
the phenomenon no later than one hour ago - just to come to the same
conclusion as yours: the reset thing is silly.

(quickly reading the patch)

Mmm, looks good, except one part in init_client_it87. Not only the
reset_it parameter prevents the reset, but it also disables all default
settings - so it acts like the "init=0" parameter some of our drivers
have. I think that only the reset command (writing 0x80 in register
0x00) is evil. The rest of the init isn't dangerous (also it has also
been discussed wether it should be done or not). Also, did you checked
your fan3_div code? Looks buggy.

Your patch looks overall great and I'm willing to apply it after the
points above are fixed and the questions below are discussed.

1* Should the reset command be kept at all? I really believe it should
go away. The chip is obviously initialized with correct values by the
BIOS, so the reset is unnecessary at least, and can break thinks
(experience showed it did). If we decide to keep it in the code, I'd at
least expect it not to be the default.

2* Should we provide a init=0 parameter? I think yes. Should it be the
default? Not too sure. (But actually, some things *need* to be
initialized, while some others do not need to. Especially, temperature
and voltage limits belong to userspace, as it has already been
discussed). Greg, what's your policy in 2.6 (if you have one)?

So, what do you mean?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
