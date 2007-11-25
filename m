From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 25 Nov 2007 01:53:39 +0000
Subject: Re: [lm-sensors] [PATCH 3/5] hwmon: (gl518sm) Refactor fan	functions
Message-Id: <20071125015339.GI13717@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071022174642.3c3ce8f0@hyperion.delvare>
In-Reply-To: <20071022174642.3c3ce8f0@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2007-10-22 17:46:42 +0200]:
> This makes the code more readable and the binary smaller (by 5% or so).
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/gl518sm.c |  110 +++++++++++++++++++++++++----------------------
>  1 file changed, 60 insertions(+), 50 deletions(-)
> 

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
