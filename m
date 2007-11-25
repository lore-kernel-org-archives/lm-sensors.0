From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 25 Nov 2007 01:53:08 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (adm1025) Use dynamic
Message-Id: <20071125015308.GC13717@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2007-10-10 21:11:01 +0200]:
> This lets us get rid of macro-generated functions and shrinks the
> driver size by about 30%.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/adm1025.c |  291 ++++++++++++++++++++++++-----------------------
>  1 file changed, 154 insertions(+), 137 deletions(-)
> 

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
