From: grant_lkml@dodo.com.au (Grant Coady)
Date: Fri, 30 Sep 2005 04:16:53 +0000
Subject: [lm-sensors] Re: 2.6.14-rc2-mm2
Message-Id: <um7pj19n3et32jcergv4ep2qunpu6vlmjl@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050929143732.59d22569.akpm@osdl.org> <20050930010931.5beb174e@werewolf.able.es>
In-Reply-To: <20050930010931.5beb174e@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "J.A. Magallon" <jamagallon@able.es>
Cc: khali@linux-fr.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Fri, 30 Sep 2005 01:09:31 +0200, "J.A. Magallon" <jamagallon@able.es> wrote:

>Another issue. Is there any divisor value for fans hardcoded intially ?
>I have 3 fans in my mobo, and 2 report 0 RPM until I put the divisor at 8
>This fans are two for the xeons, and one for the box. Strangely, the fans that
>are misread are the one for the board and one of the xeons ?

I've done auto fan divisor, see drivers/hwmon/adm9240.c for example and 
  http://bugsplatter.mine.nu/hwmon/autofan/
for info, test results.

Cheers,
Grant.
