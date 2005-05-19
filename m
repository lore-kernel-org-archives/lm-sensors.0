From: david_knierim@earthlink.net (David Knierim)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: lm93 support
Message-Id: <41DBED37.7020109@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I was just looking around the sensors web site and noticed that the lm93 
is not on the list of supported chips on the web page:

http://www2.lm-sensors.nu/~lm78/supported.html

It's only supported on kernel version 2.4, but it does work very well.

I compiled up lm_sensors 2.9.0 and i2c 2.9.1 and ran sensors-detect. 
The entry for the lm93 looked like this:
Probing for 'National Semiconductor LM93' ... Success!
	(confidence 5, driver 'to-be-written')

Thanks once again for looking into this,
David
