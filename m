From: Charles <c@catcons.co.uk>
Date: Fri, 02 Dec 2011 09:59:01 +0000
Subject: [lm-sensors] Enhancement request: fancontrol error messages to
Message-Id: <4ED8A09B.20601@catcons.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello :-)

How about modifying the fancontrol script to write error messages to stderr?

It would be more conventional and, for example could be used to make it
less verbose -- while allowing any error messages to appear -- when run
from boot scripts  by something like:

fancontrol > /dev/null

Best

Charles

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
