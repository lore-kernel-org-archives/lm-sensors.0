From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: RFC parameter based voltage scaling
Message-Id: <0dn381l7s6fcq1kdvkaokn235437a29mbj@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
In-Reply-To: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Tue, 10 May 2005 14:35:31 +0200 (CEST), "Jean Delvare" <khali@linux-fr.org> wrote:

Sorry for mixing the thread up.  Just got a working set of computes 
for w83697hf chip using sensors.conf.

Its the comments up the top of file wrong, down further they mention 
the 3.6 volt offset but unfortunately comment:
"
# The math is convoluted, so we hope that your motherboard
# uses the recommended resistor values.
"
I'd have to agree with convoluted math :)

>and motherboards have a long history of not following the
>recommendations anyway.

This is the issue what I'm trying to redress by exposing resistor 
values in the computes, and providing (planning?) a user-space 
program for those with non-standard values on their mobo's.

I've changed Winbond datasheet values to E24 values as I suspect 
that is what's on my mobo.  These work for me, CVS lm_sensors 
(so I did compile that other patch, later :)

ignore in1
compute in3 @ * (50 + 34) / 50,         @ * 50 / (50 + 34)
compute in4 @ * (56 + 20) / 20,         @ * 20 / (56 + 20)
compute in5 ((@ - 3.6) * 100 / 24) + @, 3.6 - ((3.6 - @) * 24 / (100 + 24))
compute in6 ((@ - 3.6) * 120 / 56) + @, 3.6 - ((3.6 - @) * 56 / (120 + 56))
compute in7 @ * (33 + 17) / 33,         @ * 33 / (33 + 17)

These can be simplified back, but then we lose traceability?  

From a documentation point of view the verbose example may be 
better?

At least I've learned a bit more about libsensors + sensors.conf 
today, not quite as bad as first look :o)

This is using 2.6.12-rc3-mm3 standard driver (lsmod):

w83627hf               29480  0
i2c_sensor              2944  1 w83627hf
i2c_isa                 1856  0

--Grant.
