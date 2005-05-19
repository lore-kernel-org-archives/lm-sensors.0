From: martin.bene@icomedias.com (Bene Martin)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: bmcsensors port to 2.6
Message-Id: <FA095C015271B64E99B197937712FD02510AFF@freedom.grz.icomedias.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

the bmcsensors port for kernel 2.6 by Yani Ioannou (available on
sourceforge, http://bmcsensors-26.sourceforge.net/) looks quite
functional now.

As also noted by Yani, one thing is really ugly right now: at compile
time, bmcsesnors has no idea how many sensors a board provides; this
seems to range from ~20 Sesnors for simple boards up to > 60 for a dell
1750.

The sysfs interface requires a seperate callback function for read, min,
max, label, write min and write max; currently the driver assumes 100
sensors max and just declares callback functions for all of them; while
this works ist neither nice code nor especially efficient since most of
those functions generaly aren't required.

Anyone got an idea how to better handle an unknown number of sensors in
the driver?

Thanks, Martin
