From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Thu, 16 Jul 2009 18:51:20 +0000
Subject: Re: [lm-sensors] Use the Linux I2C subsystem for a two wire
Message-Id: <4A5F76A8.8080001@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <528f13590907140925h7aa36452o60da32d3bf941241@mail.gmail.com>	 <4A5CB908.4060404@cam.ac.uk>	 <528f13590907141358w17869b6fq450bf223e4f54687@mail.gmail.com>	 <4A5D6C0A.7030903@gmx.de>	 <528f13590907150722q2a91139bve72d65cbd555b8e9@mail.gmail.com>	 <4A5DEB12.3020602@cam.ac.uk>	 <528f13590907151032y30ae62beo486d4e1056219983@mail.gmail.com>	 <4A5E206F.8000001@cam.ac.uk>	 <528f13590907160913n73dcb4fcuf09f4946d7578793@mail.gmail.com> <528f13590907160929r1385c99el6c1ed16ca1b592d2@mail.gmail.com>
In-Reply-To: <528f13590907160929r1385c99el6c1ed16ca1b592d2-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alfred steele <alfred.jaquez-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

alfred steele wrote:
>> ~$ insmod sht15.ko
>> regulator: Unable to get requested regulator: vcc
>> sht15 sht15: Command not acknowledged
> Please ignore the 1st line as i have bypassed the regulator framework.
> Another quick question: The datasheet recommends 3.3V but the
> voltage measured on my lines are ~2.8V. That could be another spoiler.
It'll probably be fine.

I suggest sticking a scope on the signal lines and confirming things
that look about right are going down them.

Jonathan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
