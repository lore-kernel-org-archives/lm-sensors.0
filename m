From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Fri, 01 Feb 2008 02:35:56 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (w83627hf) Add individual	alarm
Message-Id: <20080201023556.GO8290@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2008-01-03 23:00:30 +0100]:
> The new libsensors needs these individual alarm and beep files. The
> code was copied from the w83781d driver. I've tested the alarm files
> on a W83627THF. I couldn't test the beep files as the system in
> question doesn't have a speaker.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
> Carlos, Jim, could any of you please test and/or review this patch?
> 
>  drivers/hwmon/w83627hf.c |  142 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 139 insertions(+), 3 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
