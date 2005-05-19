From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: Fan speed control on w83781d
Message-Id: <20030820215134.GA29707@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030818182646.GA669@idlestudios.com>
In-Reply-To: <20030818182646.GA669@idlestudios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* apophis@idlestudios.com <apophis@idlestudios.com> [2003-08-18 13:27:58 -0500]:
> I have a EPoX 8KHA+ which has a w83697hf chip and I wasn't able to adjust the fan speeds through the /proc system using LM Sensors and I2C 2.8.0. I looked through the support tickets and noticed someone else had the same problem as I had where they included a fix for 2.7.0(http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket07). I modified the patch a bit for 2.8.0 and it worked flawlessly. I also had tried adjusting the fan speeds with the sensors in 2.6.0-test3 and it appears that it hasn't been fixed in that yet either. 
> 
> I was just wondering why this patch hadn't been fixed in LM Sensors yet as I am sure there are others that have had this problem.
> 
> 	apophis

It was probably just dropped by accident.  Send your new patch to the list
and we'll look at it.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
