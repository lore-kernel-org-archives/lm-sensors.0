From: gianluca@interbartolospa.it (gianluca interbartolo)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: i2c-dev
Message-Id: <4051F5A2.8030209@interbartolospa.it>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
I'm using kernel 2.6.4 and module i2c-viapro (I have an Asus A7V8X).
When I load i2c-dev I get no error, but under /proc/bus there is no i2c
directory. So using sensors-detect gives an error trying to open
/proc/bus/i2c.
Instead there is a /sys/bus/i2c directory, with subdirs that have no
files. What does it mean? There is a different approach despite of
documentation or a bug in i2c-dev?
Bye,

Gianluca Interbartolo


