From: Bruce@Ivn.cl (Ivan Barrera A.)
Date: Thu, 07 Sep 2006 00:10:25 +0000
Subject: [lm-sensors] sconfig - lm_sensors mainboard detector
Message-Id: <44FF6371.90504@Ivn.cl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi.

Some time ago, i let the list know about a fedora project, which will
release a program to "autodetect" mainboard and configure lm_sensors
accordingly.
As many know, this is a difficult task, as not every bit of info is
exact, nor accurate. So the program is combining some ideas to make it
to a functional one.

The program is named sconfig, and currently is in a development stage.
Some mainboard have been tested (although not all of them been
configured properly, as some sensors are difficult).
Actually, sconfig parses the output from dmidecode, check a DB, and then
checks lspci output for onboard devices. (isa bridge, etc). With that,
it determines a score, and set/show the configuration stored.
The program has a rewrite pending, so the code is messy now. However,
some testint is appreciated, as i need to incorporate more methods and
data to the system.

Every (hopefully constructive) tought is welcome.

Code may be downloaded at :

http://ivn.cl/sensors

Over there, you can upload information about your mainboard, if you have
sensors running.

rpm's for fedora/redhat/centos systems will be available soon.




