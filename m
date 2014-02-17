From: David Anderson <davea42@gmail.com>
Date: Mon, 17 Feb 2014 21:17:26 +0000
Subject: Re: [lm-sensors] sensors command now hangs [update 2]
Message-Id: <53027C66.60608@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Well, even without ipmi sensors hangs up
at (hand typing this) after just 6 hours:

...
w83795adg-i2c-0-27
Adapter: SMBus I801 at 0400



Google search shows someone using redhat has a hanging
sensors command too :

https://bugzilla.redhat.com/show_bug.cgi?id51274

Note there the apparent workaround of nouveau.runrpm=0
on the kernel command line.
I'm using Nvidia driver  319.60 for the GTX 760

DavidA.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
