From: mr-smoke@spinning-plates.eu.org (Romain Riviere)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: Ticket 1400 : corollary
Message-Id: <1063685016.19354.16.camel@marla.spinning-plates.eu.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello there,

I've just posted a ticket about sensord that couldn't compile in 2.8.0.
The reason why I wanted to compile sensord is that after a certain
amount of time, the kernel unload the i2c modules because via686a is
reported as "unused". I somehow hope that sensord will make "use" of the
module, although I've got the feeling it won't change much.
What bugs me is that I modprobe the modules without the -k option, and I
have no crontab entry for rmmod.
Question is : how to "use" this module so that it's not automagically
removed ?

Thanks and regards,
Romain
