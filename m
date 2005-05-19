From: DarkEmperor@gmx.net (Emperor)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: flex scanner jammed problem
Message-Id: <1064523148.3814.17.camel@nils>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thank you!

with your help I got it!!

I first uninstalled lm_sensors270... which had deps to kdebase... no
matter ;)

And then uninstalled lm_sensors 2.8.0... 

deleted all sensors executables (yes there was a 2.6.5 one... what a
mess)

And reinstall 2.8.0.

Then reinstall ksensors...

and all works now!

oh and yes I had to clean the sensors.conf file.

Thank you for all your help!
