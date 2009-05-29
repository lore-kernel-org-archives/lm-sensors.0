From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 29 May 2009 16:07:43 +0000
Subject: Re: [lm-sensors] PATCH [3/4]: hwmon: f71882fg add temp#_fault sysfs
Message-Id: <20090529180743.49fe017e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A1FA57B.3040505@redhat.com>
In-Reply-To: <4A1FA57B.3040505@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 29 May 2009 11:06:03 +0200, Hans de Goede wrote:
> While working on f71852fg support I noticed that the f8000 sysfs attr
> table was missing entries for temp#_fault, which the f8000 does have and
> which we were already reading.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Looks good, applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
