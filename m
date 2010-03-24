From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 24 Mar 2010 10:33:00 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] [RFC] hwmon: f71882fg: Add watchdog
Message-Id: <4BA9EA5C.9060506@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100323141718.GA23172@salidar.me.mortis.eu> <1269385936-3440-1-git-send-email-me@mortis.eu> <1269385936-3440-2-git-send-email-me@mortis.eu> <1269385936-3440-3-git-send-email-me@mortis.eu> <1269385936-3440-4-git-send-email-me@mortis.eu> <4BA9CF57.4030504@redhat.com> <20100324093651.GG6368@salidar.me.mortis.eu>
In-Reply-To: <20100324093651.GG6368@salidar.me.mortis.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Giel van Schijndel <me@mortis.eu>
Cc: Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <jic23@cam.ac.uk>, Laurens Leemans <laurens@signips.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi,

On 03/24/2010 10:36 AM, Giel van Schijndel wrote:
> On Wed, Mar 24, 2010 at 09:37:43AM +0100, Hans de Goede wrote:
>> Nack:
>> As the watchdog has its own SIO logical device number, it should
>> have a separate driver, not have support glued to the hwmon driver.
>
> Thus, if I understand correctly, you would suggest for me to implement a
> new driver in drivers/watchdog/ to implement this driver?
>

Yes, correct.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
