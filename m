From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sat, 25 Feb 2006 15:27:16 +0000
Subject: [lm-sensors] Question on platform drivers
Message-Id: <20060225152716.GA3101@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0602191403u1392a3b4hc5d7b93720c57355@mail.gmail.com>
In-Reply-To: <191fb4ca0602191403u1392a3b4hc5d7b93720c57355@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

[ I wrote a quick hack of a patch ]

* Jean Delvare <khali at linux-fr.org> [2006-02-24 23:01:25 +0100]:
> Further investigations reveal that the patch above isn't sufficient. It
> covers the case where no i2c driver at all is loaded, but fails again
> is i2c-core is loaded but no bus driver is. It is also a bit too loose
> with error checking in my opinion.
> 
> Here is the patch I have come up with. Juerg, please give it a try and
> report. It works fine for me at least.

Yep, that looks a lot better.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


