From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Wed, 25 Jun 2008 13:19:29 +0000
Subject: Re: [lm-sensors] [PATCH 02/10 v2] hwmon: (lm85) Coding-style
Message-Id: <20080625131929.GA23797@mars.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2008-04-29 14:03:37 +0200]:
> Fix most style issues reported by checkpatch, including:
> * Trailing, missing and extra whitespace
> * Extra parentheses, curly braces and semi-colons
> * Broken indentation
> * Lines too long
> 
> I verified that the generated code is the same before and after
> these changes.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
> Updated to include the comments from Juerg Haefliger.
> 
>  drivers/hwmon/lm85.c |  505 +++++++++++++++++++++++++-------------------------
>  1 file changed, 255 insertions(+), 250 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
