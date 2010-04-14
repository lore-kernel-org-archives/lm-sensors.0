From: Andre Prendel <andre.prendel@gmx.de>
Date: Wed, 14 Apr 2010 18:28:19 +0000
Subject: [lm-sensors] [PATCH v4 0/2] Add sensors config tools
Message-Id: <20100414182819.GA1985@andre-laptop>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

here is the updated version of the sensors config tool.

For some help take a look at my initial post:

  http://lists.lm-sensors.org/pipermail/lm-sensors/2010-January/027615.html

Some options are obsolete in the meantime. If you have more questions
just ask.

How will you test it? Setting up a local webserver or are you going to
update some of the config files at lm-sensors.org?

For testing you can overwrite the DMI data in the install.sh script
the simulate another machine. See line 14 # only for testing.

Regards,
Andre

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
