From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: user/kernel bug and memory leak in i2c-dev
Message-Id: <20030805211609.4a3a66d2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Greg,

As you may have seen on LKML (and this list) we have a patch ready to
fix the two problems mentioned in topic. I will submit it for inclusion
into Linux 2.4 tomorrow. I think I need to CC: Marcelo for it to work,
right?

I checked wether the fix should be applied somewhere else. It doesn't
apply to Linux 2.2 (there were no I2C subsystem there) but it *does*
apply to 2.6.0-test2. The proposed patch won't apply cleanly because the
code was reindented, but it *has* to be applied though. What do you want
me to do? Prepare and submit a patch to the LKML and CC: Linus, as I
plan to do for 2.4? Prepare the patch and send it to you? Leave you
handle the problem alone?

See you,

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
