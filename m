From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 20 Feb 2011 19:51:41 +0000
Subject: Re: [lm-sensors] [PATCH 3/4 v2] Move lis3lv02d drivers to
Message-Id: <20110220195141.GA6010@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Feb 20, 2011 at 07:19:54AM -0500, Jean Delvare wrote:
> The lis3lv02d drivers aren't hardware monitoring drivers, so the don't
> belong to drivers/hwmon. Move them to drivers/misc, short of a better
> home.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Eric Piel <eric.piel@tremplin-utc.net>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
