From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: Sensor chip - Asus ASM58 Mozart-2
Message-Id: <20030203195825.C22344@earth.solarsys.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1043937006.31089.19.camel@stag02.ccs.usherbrooke.ca>
In-Reply-To: <1043937006.31089.19.camel@stag02.ccs.usherbrooke.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* David Lauzon <wildz@videotron.ca> [2003-01-30 09:30:06 -0500]:

> We're working on a 180 nodes Cluster and we trying to monitor the cpu
> temperature on these PC. This project is our prototype for the Mammouth
> Project starting this summer : a 1024 nodes cluster.

Hmmm, have you purchased 1k machines yet?  Maybe such a large
sale entitles you to some support (i.e. datasheets) from Asus?

> LM Sensors does not support the Mozart-2 chip, but I found Mbmon,
> another program which support it. So with the help of the author, we
> manage to get his program working on the 144 first motherboards. But
> Mmbon doesn't support the sis961 chipset and his author does not have
> time to implement such support. So I would like to know if you're
> planning on making a driver for the Mozart-2 chip (i know it says ?not
> planned? on your website, but i'm just asking... )

From what I can tell, xmbmon has BSD-ish license.  I'm willing
to work on porting the Mozart-2 over to the sensors project.
Standard disclaimers (esp. no warranty) apply.

> Or you know any other way to get the cpu heat, fan speed,etc
> informations. I imagine if the BIOS can show us this information, he
> must keep it somewhere in memory.. is there a way to read it via a BIOS

Almost certainly not.  BIOS probably reads the hardware while
displaying it to you, but not otherwise.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
