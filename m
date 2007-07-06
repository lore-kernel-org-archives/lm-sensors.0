From: "Bart van Kuik" <lmsensors@vankuik.nl>
Date: Fri, 06 Jul 2007 13:57:22 +0000
Subject: Re: [lm-sensors] Odp:  Sensors working on DL360?
Message-Id: <50821.83.87.167.242.1183730242.squirrel@webmail4.transip.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <468e04f3cde05@wp.pl>
In-Reply-To: <468e04f3cde05@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

>> I'm trying to get sensor readouts on a Compaq DL360
> My bet it uses thmc50 driver which is just being ported to 2.6.

I must be doing something wrong. I've retrieved the latest lm-sensors code
from SVN using

    svn checkout http://lm-sensors.org/svn/lm-sensors/trunk lm-sensors

Then compiled and installed with "make user && make user_install". But I
don't get results:

    # sensors -c /etc/sensors.conf "thmc-*"
    Specified sensor(s) not found!

Also, can I visually identify this chipset somehow on the motherboard?
I've tried to look for an IC marked "TI", but couldn't find it.

Output of lsmod is here:
    http://www.vankuik.nl/download/lsmod_output

Output of "uname -r" is:

    2.6.18-8.1.6.el5xen

Any ideas?

Bart



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
