From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 28 Oct 2009 09:16:07 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] hwmon-f71882fg: Fix sysfs file removal
Message-Id: <20091028101607.4e4eb5e8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AE02F6A.1080200@redhat.com>
In-Reply-To: <4AE02F6A.1080200@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 22 Oct 2009 12:09:46 +0200, Hans de Goede wrote:
> There is a bug in the old sysfs file removal, as it uses fxxxx_in_temp_attr
> to remove the in and temp sysfs attributes, but fxxxx_in_temp_attr has
> temp#_alarm, where as f71858fg_in_temp_attr has temp#_max_alarm, so
> the temp#_max_alarm attributes for the f71858fg never get removed.
> 
> This patch fixes this by doing the sysfs removal exactly the same way as
> the creation instead of being (too) clever, this will also avoid similar
> bugs in the future.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Looks good to me.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
