From: Matt Roberds <mattroberds@cox.net>
Date: Sun, 14 Jun 2009 06:22:22 +0000
Subject: Re: [lm-sensors] VID on Intel Core Duo
Message-Id: <Pine.LNX.4.64.0906140116330.3300@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <a0bfe2b50906132136s31d71fa5le2bd739245d51c8f@mail.gmail.com>
In-Reply-To: <a0bfe2b50906132136s31d71fa5le2bd739245d51c8f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 14 Jun 2009, Maneki Neko wrote:

/me waves back.

> Here is the output from sensors-detect:

You might grab the latest and greatest sensors-detect at
http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
and see what it says.  sensors-detect is independent of the rest of the
sensors package; you can run it even if you don't have lm_sensors
installed.  (You do need Perl, but if an older version of sensors-detect
works, you already have that.)

If the latest sensors-detect finds more sensors, you can then think
about installing a newer version of lm-sensors and/or the kernel
modules that support your hardware.

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
