From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 04 May 2010 19:16:29 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: applesmc: Add temperature
Message-Id: <20100504211629.40d0d1bf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1272980343-3880-1-git-send-email-rydberg@euromail.se>
	<1272980343-3880-2-git-send-email-rydberg@euromail.se>
In-Reply-To: <1272980343-3880-2-git-send-email-rydberg@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Alex Murray <murray.alex@gmail.com>

Hi Henrik,

On Tue,  4 May 2010 15:39:03 +0200, Henrik Rydberg wrote:
> From: Alex Murray <murray.alex@gmail.com>
> 
> The Apple SMC uses a systematic labeling scheme for the hardware
> temperature sensors. This scheme is currently hidden from
> userland. Since the sensor set, and consequently the numbering,
> differs between models, an extensive database of configurations is
> required for an application such as fan control. This patch adds the
> SMC labels to the hwmon sysfs interface, allowing applications to use
> the sensors more intelligibly.
> 
> [rydberg@euromail.se: fixed error handling]
> Signed-off-by: Alex Murray <murray.alex@gmail.com>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
>  drivers/hwmon/applesmc.c |  148 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 147 insertions(+), 1 deletions(-)
> (...)

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
