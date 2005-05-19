From: marius.reiner@hdev.de (Marius Reiner)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: pwmconfig
Message-Id: <20030721190646.12205824.marius.reiner@hdev.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030721115123.11b859d1.khali@linux-fr.org>
In-Reply-To: <20030721115123.11b859d1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I didn't try that. What values am I supposed to put there? I have two
> pwm files and their default values are different:
> 
> hyperion:/proc/sys/dev/sensors/as99127f-i2c-3-2d> cat pwm1
> 0 1
> hyperion:/proc/sys/dev/sensors/as99127f-i2c-3-2d> cat pwm2
> 143 1

The first value can take 0-255 giving the fan speed, the second one sould AFAIK be 0 or 1, for on/off, actually I didn't code that cleanly in fancontrol and pwmconfig.
What happens to your temps when doing:

echo 0 0 > /proc/sys/dev/sensors/as99127f-i2c-3-2d/pwm1
echo 255 1 > /proc/sys/dev/sensors/as99127f-i2c-3-2d/pwm1

and:

echo 0 > /proc/sys/dev/sensors/as99127f-i2c-3-2d/pwm1
echo 255 > /proc/sys/dev/sensors/as99127f-i2c-3-2d/pwm1

> Ah, that's the page I had been looking for. In your script, you suggest
> to go there: http://www.almico.com/speedfan.php. Don't you think we
> should change this URI in your script to
> http://www.almico.com/forumindex.php? That's where the information
> really is.

Committed this.

Marius
