From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 15 Dec 2008 16:08:11 +0000
Subject: Re: [lm-sensors] PATCH: f71882fg: add missing pwm3 attr for f71862fg
Message-Id: <20081215170811.46dc8b27@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <49463C09.60509@redhat.com>
In-Reply-To: <49463C09.60509@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 15 Dec 2008 12:14:17 +0100, Hans de Goede wrote:
> Hi,
> 
> For some reason the fan_attr array for the f71862fg was missing the attr for
> the 3th pwm output. This patch fixes this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
