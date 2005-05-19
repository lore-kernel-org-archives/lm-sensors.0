From: phil@netroedge.com (Philip Edelbrock)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: problem with lm_sensors
Message-Id: <3E949925.5040708@netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E9496EA.3020302@t-online.de>
In-Reply-To: <3E9496EA.3020302@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Does you kernel have sysctl support turn on?  I.e., do you see anything 
in /proc/sys/dev/sensors?  Also make sure you don't have any old 
libsensors floating around from a previous install.  A good sample 
/etc/sensors.conf file can be found in 
lm-sensors-2.7.0/etc/sensors.conf.eg.  You likely don't need to modify 
it after copying it to /etc/sensors.conf.


Phil


Stephan Zerhau wrote:

> hi,
> I have a problem with lm_sensors. Maybe it is easy for you to solve 
> it, but be assured that I?ve tried anything I know before contacting 
> you guys.
> After successfully compiling and installing i2c and lm_sensors with no 
> error messages at all (even all modules seem to be loaded correctly), 
> I get this message whenever I make "sensors -s":    No sensors found!

