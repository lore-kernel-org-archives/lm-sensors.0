From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 Apr 2007 17:50:22 +0000
Subject: Re: [lm-sensors] asb_100 sensor location in /sys heirarchy changes
Message-Id: <20070408195022.04b35e90.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4615F494.6070403@hhs.nl>
In-Reply-To: <4615F494.6070403@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Fri, 06 Apr 2007 09:19:48 +0200, Hans de Goede wrote:
> jk wrote:
> > I have a p4pe board with the asb_100 sensor running under linux 2.6.20.
> > 
> > I now notice that the sensors location varies between
> > /sys/bus/i2c/drivers/asb100/0-002d and /sys/bus/i2c/drivers/asb100/2-002d
> > between reboots.
> > 
> > This creates problems for me since I use sensord and a crontab entry to read the
> > sensors but now the location of the sensors in /sys varies with each boot.
> > 
> > Is this a bug?
> > If not is there a way to fix the location of the sensor directory in the /sys
> > heirarch? (Otherwise, I will need to write some klugey shell script to try to
> > find the location at boot-up and then automatically change the crontab entry
> > accordingly.
> 
> Interesting, I've been thinking about this for while, as I foresee problems 
> here in relation to the DMI based motherboard config project we are working on too.
> 
> I think that the currently used scheme where busses are purely numbered instead 
> of named needs fixing.
> 
> Here is what I have on my system:
> /sys/bus/i2c/devices/0-0050
> /sys/bus/i2c/devices/0-0051
> 
> And here is what I would like to have:
> /sys/bus/i2c/devices/viapro-0-0050
> /sys/bus/i2c/devices/viapro-0-0051
> 
> The idea here is that the 0 added here is in case one can have multiple 
> instances of the same i2c master driver

Which directly points to a weakness in your proposal: if you have two
adapters of the same type, they'll get named foo-0 and foo-1. How do
you know which is which? You don't, so you only moved the problem one
step further, you didn't solve it.

My understanding is that this is a problem for user-space to solve, it
should not assume stable device numbering accross reboots. But it used
to be the case and many user-space tools still rely on this.

> So if I would also have an i2c driver for my ati radeon, then it would look like:
> /sys/bus/i2c/devices/viapro-0-0050
> /sys/bus/i2c/devices/viapro-0-0051
> /sys/bus/i2c/devices/radeon-0-00xx
> 
> This way the order in which the drivers get loaded doesn't matter. We do 
> ofcourse need to provide compat symlinks with the old names which will still be 
> driver loading order dependend.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
