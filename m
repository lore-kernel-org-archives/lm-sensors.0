From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Wed, 25 Jul 2007 02:28:13 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-fscher-bugfix-control-update.patch
Message-Id: <20070725022813.GC3767@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <46A39EC3.5070005@hhs.nl>
In-Reply-To: <46A39EC3.5070005@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans, Jean:

* Jean Delvare <khali@linux-fr.org> [2007-07-23 22:19:28 +0200]:
> On Sun, 22 Jul 2007 20:15:31 +0200, Hans de Goede wrote:
> > Here is another small fscher bugfix for 2.6.23 merging, this was caught by Jean
> > while reviewing my other bugfix. The driver was updating its copy of the
> > control register as if it was clear to write, but its regular read/write.
> > This patch fixes this.
> > 
> > Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
