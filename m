From: azummo-lists@towertech.it (Alessandro Zummo)
Date: Thu, 17 Nov 2005 00:34:41 +0000
Subject: [lm-sensors] [RFC] adding back i2c_get_clients
Message-Id: <20051117003330.21bfff26@inspiron>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


 Hello,

  I'd like to restart a topic that was discussed before, regarding the infrastructure
 required to send a command/ioctl directly to an i2c client.

  The topic was discussed in [1] and [2] more than one year ago. This missing
 functionality led to all sort of tricks in both i2c rtc drivers and media drivers.

  My previous proposal ([3]) addressed the separation between ioctls and
 commands. We now need a way to actually send those commands to the
 device we are interested in.

  I'd like to introduce one or more functions to be able
 to retrieve a client based on its driver id and/or i2c class.

  If there's general consensus, I'd be happy to take care of it.

[1] http://marc.theaimsgroup.com/?t8307854200001&r=1&w=2
[2] http://marc.theaimsgroup.com/?t8324800400004&r=1&w=2
[3] http://lists.lm-sensors.org/pipermail/lm-sensors/2005-November/014343.html

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it
