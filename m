From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 04 May 2010 19:19:14 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] emc1403: thermal sensor support
Message-Id: <20100504211914.613506b4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100414125205.23181.15562.stgit@localhost.localdomain>
In-Reply-To: <20100414125205.23181.15562.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again Alan,

On Tue, 4 May 2010 12:33:00 +0100, Alan Cox wrote:
> > I have no problem with individual power up/down of devices. But this
> > doesn't make it a hwmon-specific requirement, so I insist that it
> > doesn't belong to the hwmon framework.
> 
> I guess that can stay a vendor applied patch for now as it really isn't
> obvious where else you would put it given the need to associate it
> accurately with a specific emc1403.

I am just realizing that my indent may have been misinterpreted. All I
was saying was that it wasn't up to the hwmon subsystem to _standardize_
on power up/down sysfs attributes. I didn't mean to object against such
attributes being added to a hwmon device. So feel free to add back the
power attribute you just removed if it makes your life easier.

Sorry for the confusion.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
