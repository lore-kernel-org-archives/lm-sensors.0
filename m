From: root@n952.dyndns.ws (root)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: success report
Message-Id: <Pine.LNX.4.62.0503222149001.27188@n952.dyndns.ws>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Just a note of thanks for your effort.
I've an Abit IC7-G that works like a charm.
The VID lines on this particular motherboard
appear to not be connected.

I may have some items you may be interested
in for your "Hardware Hacking" page.

Analog Devices ADM1031 is a convenient package
for monitoring a few extra fans and temperatures,
and the IC7-G provides an SMBUS connector.
This all leads to this weeks project:
     http://n952.dyndns.ws

I'll have some pictures of the actual circuit board
later this week if you would like to add some of
this to your web site.

Which brings up a comment/suggestion:

   It seems that most of the chip drivers depend on th BIOS
to perform setup functions.  Have you considered providing
some means of performing chip setup in the configuration file?
This would allow simple integration of off-board monitoring.

regards
-Willy
William Robison
Physics & Astronomy
University of Iowa
http://cassini.physics.uiowa.edu/cassini
