From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: MOD_*_USE_COUNT
Message-Id: <20031026220525.70e5e62e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all,

While writing the i2c-2.8.1 patch I plan to send to the kernel people
for inclusion into Linux 2.4, I made sure not to leave any
MOD_*_USE_COUNT call in, since in my understanding, the owner structure
member in i2c_algorithm, i2c_adapter and i2c_driver was precisely
introduced to get rid of them.

Now, taking a look at what was done in the 2.6 kernel tree, it happens
that a few drivers still have these macros used. For example, they are
still used in bt832.c, bttv-if.c and tuner-3036.c. Does it mean that I
should *not* have been removing them there? Should I have been removing
these calls only if they were explicitely linked to our structures
through inc_use and dec_use structure members? Or is it simply that they
should have been removed in 2.6, but have been forgotten?

Explanations would be welcome.
Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
