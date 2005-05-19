From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: How to get the Fan-Speed of an slow Papst fan
Message-Id: <20030516041313.GA1258@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200305151928.36836.mzenke@gmx.de>
In-Reply-To: <200305151928.36836.mzenke@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Michael Zenke <mzenke@gmx.de> [2003-05-15 19:28:36 +0200]:
> Dear Developers,
> I recently bought a Papst fan whitch rotates with only about 1500 rpm. In the 
> documentation I found that fan speeds below 2600 rpm are not representable 
> and ProcMeter3 and sensors show me a fan-speed of 0 rpm. I have a W83727HF 
> chip and use the w83781d module. What do I have to change that I get the fan 
> speed?

This is a FAQ...

> 4.1.1 Fans sometimes/always read 0!!
> 
> You may not have a three-wire fan, which is required. 
> 
> You may need to increase the 'fan divisor'. See doc/fan-divisors in our
> package for further information. 

The rest are here:

http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html

-- 
Mark M. Hoffman
mhoffman@lightlink.com
