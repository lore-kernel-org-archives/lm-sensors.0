From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 26 Nov 2014 19:30:34 +0000
Subject: [lm-sensors] libsensors license question - GPL or LGPL ?
Message-Id: <54762A5A.7030601@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

libsensors is supposed to be licensed under LGPL as far as I can see
and recall. However, doc/developers/applications reads:

    Note that libsensors falls under the GPL, not the LGPL.
    In more human language, that means it is FORBIDDEN to link any application
    to the library, even to the shared version, if the application itself
    does not fall under the GPL. This may or may not be changed in the future.
    Contact us if you wish to discuss your application.

Is that an oversight from earlier versions or on purpose ?
The source refers to LGPL as far as I can see, and the comment in
lib/libsensors.3 states that it is distributed under LGPL.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
