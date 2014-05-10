From: Andreas Werner <wernerandy@gmx.de>
Date: Sat, 10 May 2014 11:08:07 +0000
Subject: [lm-sensors] Question: hwmon: adding addition features
Message-Id: <20140510130432.GA28301@awedesk.fritz.box>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,
i am currently working on an implemenation of my Board Management Controlle=
r (BMC).

This Controller is a MCR assembled on almost all of our Compact PCI or Comp=
act PCI Serial
Cards as well as on some other CPU Boards.

The BMC includes LED=B4s, Watchdog, Voltage Monitoring and some other featu=
res.
I have already implemented an MFD driver, LED and Watchdog driver.

Currently i am working on the hwmon implemenation. This includes for the fi=
rst step the
voltage monitoring.

The BMC has some other feature which are not supported by any of the subsys=
tem.
 - Errorcounter (Board status)
 - Power Failure status
 - Operating ours
 - Do software reset, do cold reset
 - Set power modes
 - Backplate Geographical Address

These are all informations related to the Board where the BMC is assembled =
to.
I think all those features could be part of the hwmon implementation.

Is it possible to add "custom" sysfs entries in my hwmon driver to support =
all these features?
Does lm-sensor ingore those custom features or is it a problem for lm-senso=
rs?

What is the normal way to add those features?

Regards
Andy



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
