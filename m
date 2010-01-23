From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 23 Jan 2010 19:24:54 +0000
Subject: Re: [lm-sensors] PATCH: hwmon fschmd: Fix a memleak on multiple
Message-Id: <20100123202454.08a094ae@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B5B22D9.2020105@redhat.com>
In-Reply-To: <4B5B22D9.2020105@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 23 Jan 2010 17:24:57 +0100, Hans de Goede wrote:
> When /dev/watchdog gets opened a second time we return -EBUSY, but
> we already have got a kref then, so we end up leaking our data struct.
> This patch fixes this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
