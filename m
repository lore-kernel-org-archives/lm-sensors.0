From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: Linux 2.6.0-test11 and lm_sensors 2.8.2
Message-Id: <3FDB5B31.63CF3DBE@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200312131634.hBDGYrix013282@twopit.underworld>
In-Reply-To: <200312131634.hBDGYrix013282@twopit.underworld>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

You inspired me to add support for eeproms in libsensors,
I just checked it into CVS if you would like to try it.
mds

Chris Rankin wrote:
> 
> Hi,
> 
> I am having trouble using the lm_sensors 2.8.2 user tools with the
> 2.6.0-test11 kernel. My machine has 2 built-in LM87 chips and 2 SDRAM
> EEPROMs, all of which worked fine under Linux 2.4.
> 
> The new 2.8.2 sensors tools are refusing to recognise my EEPROMs:
