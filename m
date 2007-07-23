From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 23 Jul 2007 20:19:28 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-fscher-bugfix-control-update.patch
Message-Id: <20070723221928.01a8d8e4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46A39EC3.5070005@hhs.nl>
In-Reply-To: <46A39EC3.5070005@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 22 Jul 2007 20:15:31 +0200, Hans de Goede wrote:
> Here is another small fscher bugfix for 2.6.23 merging, this was caught by Jean
> while reviewing my other bugfix. The driver was updating its copy of the
> control register as if it was clear to write, but its regular read/write.
> This patch fixes this.
> 
> Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
