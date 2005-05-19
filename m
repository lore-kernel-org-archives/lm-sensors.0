From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: i2c-nscacb.c
Message-Id: <1080742705.406ad3319e3b8@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040330205254.65af94aa.khali@linux-fr.org>
In-Reply-To: <20040330205254.65af94aa.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

According to David Goodenough:

> OK, I have read that page, and it says that 2.6 stuff is not in 
> CVS but rather in BK.  I have never used BK, so when it gets
> to completing this stuff, to whom (or where) do I submit it, and
> in what format?

Sorry for the confusion. There are actually two repositories you may
need to access to:

* The lm_sensors' CVS repository, which holds the 2.4 drivers and
user-space tools (kernel-independant). This is where the i2c-nscacb
could go if it is GPL.

* Greg's bitkeeper tree, which holds the latest 2.6 kernel developments.
I'm not used to bitkeeper either, so I can't give you much more
details. See with Greg. For me, I track the patches that show up on the
mailing list and compile them into a collection and unified patch
here:
http://delvare.nerim.net/i2c/linux-2.6/
When I want to send a patch to Greg, I simply check that it applies
cleanly on top of the latest Linus tree + the unified patch. After some
times, Greg syncs up with Linus and we start from a common ground
again. I guess it would be easier to use BK, but for now it works well
enough for me.

> Philip, can you please subscribe me.  Also is there any chance of
> adding a ListId: tag to the list mail, it makes it much easier
> to filter into the right place.

Philip, I leave this to you :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
