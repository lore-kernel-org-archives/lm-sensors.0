From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: Patches for 2.6.0 (lm83 and misc)
Message-Id: <20031011135522.464265b7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031004160750.70561b1d.khali@linux-fr.org>
In-Reply-To: <20031004160750.70561b1d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Apart from the above-mentioned reason (I am a step-by-step guy), I
> > have so many things to do that I can reasonably delay the two
> > additional drivers. In particular, I have to prepare a i2c-2.8.1
> > patch for submission to the LKML and integration into Linux 2.4.23.
> > I think you remember about that. At least, I hope so, since I
> > definitely count on your help in the process :)
> 
> Yes you can.  But remember, no sysctl crap :)

The sysctl crap belongs to i2c-proc.c and is already in the 2.4 kernel.

What the patch does is removing the usage counters in favor of
THIS_MODULE. I think that this is generally a good thing and that the
kernel people will enjoy that, but this change in the i2c core requires
all i2c drivers to be modified accordingly - so the final patch is
somewhat huge. This is why I may need your support to convince them to
accept my patch. I think they'll trust you much more easily than they
would do for me.

The whole thing is already explained in my i2c/lm_sensors 2.8.x
installation guide, but the intended audience is different. The guide
was for the users, it doesn't enters the code detail. If you want me to
explain more in detail what the changes are and why they are good, just
tell me. I think it has already been discussed over the mailing-list
however (and that's great because I alone wouldn't be able to explain it
all).

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
