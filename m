From: raphael@cs.uky.edu (Raphael Finkel)
Date: Thu, 19 May 2005 06:23:26 +0000
Subject: it works like a charm
Message-Id: <200112020544.fB25i3X13260@joanie.cs.engr.uky.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

According to the FAQ for i2c/lm_sensors, you wanted feedback if everything
worked.  I just spent about a half hour getting and compiling and installing
the i2c stuff on our linux 2.2.18 box, and all seems to work just great.
The sensors program only shows one fan turning, and temp3 at 255 C, so either
we have a failed fan or should ignore one temp, but that will wait until
we can get to the box (locked behind lots of doors; I am working remotely).

The FAQ says you don't know of any software to raise alarms and warn the
gendarms when there is a failure.  I have great home-grown software called
pulsar for just that purpose; I will write a pulsar "pulse monitor" shortly
that generates warnings.  If you are interested in pulsar, look in
ftp://ftp.cs.uky.edu/cs/software/pulsar.tar.gz .

Raphael Finkel
