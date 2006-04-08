From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 08 Apr 2006 10:40:26 +0000
Subject: [lm-sensors] hwmon/pc87360 as a platform driver
Message-Id: <20060408124026.2af3aac9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4436BE3B.7090306@gmail.com>
In-Reply-To: <4436BE3B.7090306@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> Ive just made a rough pass thru pc87360, and have converted it
> to a non-working, but non-crashing platform_driver that does
> at least a little of what it should:
> 
> soekris:~# modprobe pc87360
> [  964.952000] pc87360: Device 0x09 not activated
> [  966.576000] pc87360 pc87360.26144: VLM conversion set to 1s period, 
> 160us delay
> soekris:~#
> (...)
> so far so good, but:
> 
> soekris:~# sensors -s
> No sensors found!
> soekris:~#
> soekris:~# sensors
> No sensors found!
> 
> my libsensors is unstable debian package:  libsensors 1:2.10.0-3
> That version number looks to contain 2.10.0
> 
> Frankly, Im hoping that with 2.10, the user-side just works, but this is 
> not the case here.
> 
> Any guesses / suggestions as to whats wrong ?

First of all, Juerg's answer is correct, 2.10.0 doesn't play fair with
platform hwmon drivers unless an i2c driver is also present.

Secondly, your driver must have a "name" attribute containing the chip
name (such as "pc87360" or "pc87366" etc. in your case) else libsensors
won't be able to use it. That's probably what you're missing here.

BTW, I don't want to discourage you from working on this, as this will
be needed at some point in time, but remember that I do not plan to
accept any i2c-isa -> platform conversion before next year, because we
need a widely deployed base of working libsensors before we do, and
unfortunately even 2.10.0 doesn't qualify, as Juerg and you found out.

Thanks,
-- 
Jean Delvare

