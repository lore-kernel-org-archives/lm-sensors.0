From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: header files installed by i2c
Message-Id: <20041207023355.GB5295@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041206225703.6b3f48e7.khali@linux-fr.org>
In-Reply-To: <20041206225703.6b3f48e7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2004-12-06 22:57:03 +0100]:
> I can see that i2c install many headers in /usr/local/include/linux. All
> these are *kernel* headers. As I understand it, they are useless for
> user-space applications and should not be copied there. Any objection to
> me removing their export from i2c/kernel/Module.mk?

At least i2c-dev.h and maybe parts of i2c.h are needed for userspace access
to the i2c /dev interface.  What we probably should do is provide sanitized
headers for that.  There might be other files that are legitimate parts of
the userspace API too, I haven't looked closely.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
