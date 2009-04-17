From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 17 Apr 2009 07:17:49 +0000
Subject: Re: [lm-sensors] [PATCH] assign a default class to MPC adapter
Message-Id: <20090417091749.20404d2d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

please keep the list CC'd.

On Fri, 17 Apr 2009 08:32:16 +0200, Michael Lawnick wrote:
> Jean Delvare said the following:
> > That's right, but why do you insist on instantiating them at runtime?
> > 
> Because we have 2 different boards with same main processor but
> different on-board peripherals. They should run with same binary kernel
> to avoid duplicate production tests. On boot the system checks on which
> of the boards it is running and loads the necessary drivers with
> matching parameters.

Why would the system check need to be done in user-space? I can easily
imagine a single kernel supporting more than one system, all I2C
devices being described in the kernel and the right subset of I2C
devices being instantiated at boot based on which system the kernel is
running on.

> > The question is: why every other user of i2c-mpc is apparently able 
> > to declare i2c devices through dts and you aren't?
>
> The question was: does dts work for drivers that are loaded on runtime.

Answer is yes.

> I did not check before I asked, because it is a bit complicated here to
> do. In difference to you Wolfram was able to give a verbose 'yes' which
> I will check now.

In difference to Wolfram I have no specific knowledge of embedded
boards. I try to help with i2c in general but I am limited when it
comes to embedded.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
