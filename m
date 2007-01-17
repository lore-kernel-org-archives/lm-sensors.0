From: juergh@gmail.com (Juerg Haefliger)
Date: Wed, 17 Jan 2007 16:13:10 +0000
Subject: [lm-sensors] HP Compaq ProLiant DL380 detect failure
Message-Id: <191fb4ca0701170813u5bd07d9ci808220ba83eb1ed6@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4568C502.6070305@lymenet.org>
In-Reply-To: <4568C502.6070305@lymenet.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> Hey, it's great to hear you're making progress :) Please keep informed,
> and good luck!

The iLO people came back to me and they are a little bit reluctant at
this point. They are concerned that we screw up the HW or interfere
with the BMC if we mock around with fans and I2C registers :-)

They suggested to use IPMI, so I started to look into it and it does
seem promising. I noticed that Yani has a patch to interface IPMI to
lm-sensors (see
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-August/017071.html).

What is the state of this patch and is there any chance it'll make it
into mainline? Anything I can help with, Yani?

I have a DL385 G2 at my hand that I can use and I'll play around with
the patch probably next week after returning from vacation.

...juerg

