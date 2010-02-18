From: david jeong <david.jeong@gmail.com>
Date: Thu, 18 Feb 2010 00:11:47 +0000
Subject: [lm-sensors] Support for Intel S3420GP
Message-Id: <d2bb89841002171611l5311b3a0i13e144ad9cf88a32@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I've been getting a series of these messages:

 CPU3: Temperature above threshold, cpu clock throttled (total events = 60949)
 CPU7: Temperature above threshold, cpu clock throttled (total events = 60949)
 CPU3: Temperature/speed normal
 CPU7: Temperature/speed normal

And I'd like to have some way of testing these messages as credible
error messages.

I have a SUPERMICRO CSE-833T chassis that comes with 6 fans that are
all powered, and I've applied Arctic Silver to my Intel X3460
heatsink.  I'm baffled at the idea that the CPU is getting enough
cooling.

First, any suggestions on other ways to validate these error messages?

And second, does the ls_sensor chip have support for the Intel S3420GP
motherboard?

I'm not sure if these are sensible questions, but please do ask me to
clarify where needed.

Thanks much in advance.

Warmly,
David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
