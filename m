From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 10 Jul 2008 15:57:29 +0000
Subject: Re: [lm-sensors] [PATCH 0/3] lm90: Changes to support sfc hardware
Message-Id: <20080710175729.32629cca@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1215701481.git.bhutchings@solarflare.com>
In-Reply-To: <cover.1215701481.git.bhutchings@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

On Thu, 10 Jul 2008 15:58:26 +0100, Ben Hutchings wrote:
> These patches apply on top of the testing branch of hwmon-2.6.git plus
> Jean Delvare's patch series <http://jdelvare.pck.nerim.net/sensors/lm90/>.
> 
> Jean, I expect you may want to do the 3rd patch differently.

In fact I already have a patch ready:
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/hwmon-lm90-convert-to-new-style.patch

But it depends on i2c-core changes which will go in kernel 2.6.27:
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-core-add-detection-capability-to-new-style-drivers.patch

If you look in http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/
you'll see that I have a lot of conversion patches ready for hwmon
drivers (including the lm87 driver.) These will go to Linus through my
i2c tree, because I don't want to burden Mark with them and technically
they only affect the i2c interface of the drivers. But OTOH I have to
make sure that they don't collide with patches Mark will send to Linus
at about the same moment.

So the schedule I have in mind for the 2.6.27 merge window is as
follows:

1* I send to Linus all my i2c patches.
2* I send to Linux all my conversion patches which touch drivers I know
   Mark has no patches for currently.
3* Mark sends his patches.
4* I adjust the remaining patches on top of Mark's patches and send
  them to Linus.

This should be transparent to Mark. The goal is to have all hwmon
drivers converted in 2.6.27.

Obviously, steps 2 and 4 depend on what patches Mark adds to his tree
in the next few weeks. There is a rather important amount of pending
hwmon patches which aren't in Mark's tree yet, so I just can't predict
which ones will make it into 2.6.27-rc1.

> I've tested the new-style lm90 driver with a slightly modified sfc driver
> and it seems to work correctly for our SFE4001 board which uses MAX6647.
> I have not tested the legacy driver after these changes.

I have an ADM1032 evaluation board which I can use to test both the
new-style binding and the legacy binding.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
