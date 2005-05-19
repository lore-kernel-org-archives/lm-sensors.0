From: j.ellerbroek@student.tudelft.nl (Joost Ellerbroek)
Date: Thu, 19 May 2005 06:24:14 +0000
Subject: problem with it87.o
Message-Id: <200308261111.49787.j.ellerbroek@student.tudelft.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308161353.53028.j.ellerbroek@student.tudelft.nl>
In-Reply-To: <200308161353.53028.j.ellerbroek@student.tudelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I still haven't been able to resolve my problem with the fan spinup,
you asked for the value in 'alarms':

cat /proc/sys/dev/sensors/it87-i2c-1-2d/alarms returns:
26130

Do you think this problem can be resolved by means of a specific config, or is 
it really a driver problem?

cheers

Joost
