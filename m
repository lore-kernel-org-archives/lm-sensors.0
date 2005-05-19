From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: I2C patch for Linux 2.4.23-rc1 [Was: i2c oops]
Message-Id: <20031116145353.463076d4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031115212538.677d0fd2.khali@linux-fr.org>
In-Reply-To: <20031115212538.677d0fd2.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Thanks for the patch on the website.  However, I personally am more 
> interested in a patch for 2.4.23 (when it becomes available).

The fact that I made one available for 2.4.23-rc1 doesn't mean I won't
make one available for 2.4.23. I *will* support 2.4.23 as it becomes
available (probably not before a few weeks), and I should be able to be
rather quick since there probably won't be much changes compared with
-rc1.

> However, I do appreciate your time.  Have been able to successfully
> patch my kernel with the mkpatch.pl scripts from i2c and lm_sensors2. 
> Of course, I had to modify $diff_command in each script, but I was
> successful.  I compiled 2.4.23-rc1 with it and everything went fine. 
> I was really trying to do this just to make sure I could create one
> when 2.4.23 was released.
> 
> Do you think that this method should be sufficient for 2.4.23, or
> should I wait before I do it and use your unified patch?  I know that
> you put more into it than just simply running the mkpatch.pl scripts.

As said before, there probably won't be important changes between -rc1
and final (that's why it is called a release candidate). So what works
with -rc1 is likely to work the same with final.

That said, yes, my patches have more than just that. They have modified
Makefile and Config.in (I suspect that some drivers do not properly
appear in your configuration menu) and the required fixes for
non-sensors i2c drivers (mostly video devices such as the bttv/zoran and
similar drivers, matroxfb and some more. Read the installation guide for
a detailed list. If you don't use these drivers, than you don't need my
patch.

My patch also fixes a few incorectnesses here and there, that I
discovered while finding all the drivers that would need fixing.

I would really appreciate if you could take some time to test my patch
and make sure it's working OK for you.

> Anyway, thanks again!

You're welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
