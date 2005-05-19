From: tderooy@optonline.net (Tonko de Rooy)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: PC87366 sensor driver?
Message-Id: <1082293815.2121.9.camel@tderooy>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I just got an Opteron board (http://www.rioworks.com/HDAMB.htm) which
uses the NS PC87366 for its sensors.

Running sensors-detect finds it on the ISA bus, and told me to ask for
the driver, so here I go ;-)

I am running kernel 2.6.5 with Fedora Core 2 test 2 and lm_sensors 2.8.6
