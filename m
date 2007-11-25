From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 25 Nov 2007 01:54:10 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] hwmon: (gl520sm) De-macro the
Message-Id: <20071125015410.GP13717@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071104234514.1b60d6f0@hyperion.delvare>
In-Reply-To: <20071104234514.1b60d6f0@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2007-11-04 23:45:14 +0100]:
> Use standard dynamic sysfs callbacks instead of macro-generated
> wrappers. This makes the code more readable, and the binary smaller
> (by about 11%).
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/gl520sm.c |  416 +++++++++++++++++++++++++++--------------------
>  1 file changed, 243 insertions(+), 173 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
