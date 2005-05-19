From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: temperatures
Message-Id: <200406171355.i5HDtQBq097627@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <opr9pzmdztlsrnb1@localhost>
In-Reply-To: <opr9pzmdztlsrnb1@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


FYI:

>become root with this command:
>su
>(type your root password)
>cd /etc/rc.d/
>joe rc.modules

For Slackware, I don't think there is a rc.modules file. Put the lines
in rc.local, it should be fine. Make sure that rc.local is executable
(chmod +x rc.local if it isn't). Commands in that file will be run for
you at each boot.

Khali
