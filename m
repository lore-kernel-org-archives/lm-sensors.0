From: margitsw@t-online.de (Margit Schubert-While)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: LM85 - To Mark D. Studebaker
Message-Id: <4.3.2.7.2.20030213173806.00b65a20@mail.dns-host.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
 > Have you looked at doc/developers/new-drivers?
 > I would like the /proc names to be standard.
 > If you plan on continuing to work on it, I can do the initial checkin
 > and you can request CVS access, or send me patches...
 > Or if you are making changes soon I can wait.
 > Which would you prefer?

	Mark - Yep, I used these names so that my grey cells didn't get
	confused looking at the proc entries :-)
	I know that they have to be changed :-)

	I'm still looking at what we can get out of all these registers.
	Give me another week to get this in some sort of shape.
	There are a couple of things that Intel seem to have changed :-(

	Can you E-Mail your E-address to margitsw@t-online.de
	and, as soon as I have something that's compatible, I'll
	send it. I'd prefer to get the driver to 90% complete before we shove it
	into CVS.

	Two things :
	1)  Can you reserve an I2C device Id (and E me)
	2)  Do I have to dig through the sensors and related
	     progs myself or can somebody take that over ?

	sensors-detect just needs the trivial change from
		driver => "Unwritten: lm85",
	to
		driver => "lm85",

	Should have mentioned in my original mail that I'm using 2.7.0

	Cheers

	Margit
