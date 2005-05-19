From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:24 +0000
Subject: Important CVS changes
Message-Id: <20041126055355.GG5231@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041125230447.5ccf3f79.khali@linux-fr.org>
In-Reply-To: <20041125230447.5ccf3f79.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2004-11-25 23:04:47 +0100]:
> Hi all,
> 
> I just commited the second wave of CVS changes required to be compatible
> with Linux 2.4 again. This time this is for i2c_adapter so this is a
> much more important change.
> 
> lm_sensors-CVS obviously needs i2c-CVS now.
> 
> Please test as much as possible, the changes are large but very similar
> from file to file, I have good hope it'll work OK. Works well enough for
> me at least.
> 
> Once this is tested I'll finish the work with the client part (even more
> changes).

I reviewed the i2c changes and an adapter or two as well - can't see
anything obviously wrong with it.  I haven't actually compiled it yet
though... I'll do that Friday.  I'll have to get some 2.4.x kernels fired
up around here first.  :)  Thanks for doing this!  Here are some comments...

Are there any users of i2c-core:i2c_use_client()?  I find none in our
package nor in 2.4.28-rc2.  I ask because that's the only caller of
i2c_inc_use_client() which you modified.  I see some v4l2 users in 2.6.x
though; so maybe there are out-of-kernel (2.4.x) drivers that need it?

Also, should we backport this?

http://marc.theaimsgroup.com/?l=linux-kernel&m7867638300901&w=3

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
