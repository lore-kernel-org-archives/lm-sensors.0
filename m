From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: AW: New max6626.c driver for linux 2.6
Message-Id: <20041120121906.0d49a108.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <NHBBLBCCGMJFJIKAMKLHMEHECCAA.ralf.roesch@rw-gmbh.de>
In-Reply-To: <NHBBLBCCGMJFJIKAMKLHMEHECCAA.ralf.roesch@rw-gmbh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I have done this, and i have read back the shadowed register values.
> 
> The max6626 data sheet says:
> Pointer Register - D7 to D2: Will read all zeros, cannot be written.
> 
> Because the D2..D7 cannot be written, the leaving pinter register bits
> are 0..1
> which shows the register shadow effect.

Please understand that there are two different phenomenons on the LM75:
1* Registers cycle over 8-addr boudaries.
2* addresses 0x04-0x07 are not mapped to any register.

If I read you correctly, the MAX6626 is somewhat different in that it
cycles over 4-addr boudaries. This would be enough to reliably
differenciate between both chips.

Note that this is really a detection/identification trick. Both chips
only really have 4 registers at addresses 0x00-0x03.

I would really like to see the output of i2cdump. Care to post it here?

> O.k. I aggree, but the problem I currently see is,
> that I have to distinguish between the LM75 and MAX6626 to select
> the appropriate conversion and detection functions.
> Because both chips use the same addresses I think it is not possible
> to do this in automated way. What do you think?

According to what I said above it doesn't sound impossible (unless I
missed your point).

That said I see no reason to differenciate. On the LM75 the extra bits
(10-12) will always read 0 which is compatible with the MAX6626.
Considering that every (LM75-compatible) chip has 12-bit resolution
shouldn't hurt. Note that in 2.6 all temperatures are reported to
user-space in millidegree C anyway.

If you are able to differenciate between both chips, then you can
introduce a new kind for the max6626 and handle the 3 extra resolution
bit for it only. However, a new kind means that you have to add support
to libsensors, sensors, and virtually any application relying on
libsensors. I seriously doubt it's worth the pain, which is why I'd
stick to the lm75 name for everyone and extend the reolution to 12 bits
for everyone as well.

Thanks,

-- 
Jean Delvare
http://khali.linux-fr.org/
