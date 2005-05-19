From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: Turn off alarm?
Message-Id: <cmZUjwzm.1098878172.1733130.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041027104054.BBF3.TIMEBANDIT@dzn.mine.nu>
In-Reply-To: <20041027104054.BBF3.TIMEBANDIT@dzn.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


(please reply to the list, not to me only)

>I installed 2.8.8 and it seems to work better but when i'm doing
>"/usr/local/bin/sensors -s # recommended" that part all readings do
>whatever thet want and the alarm starts to sound... and is says ALARM on
>every reading :( If i skip doing that sensors -s part it seems to work.
>So i'm using kernel 2.6.7 and sensors version 2.8.8 with libsensors
>version 2.8.8.

OK so this is quite different from the other report.

However, you say that you got it working for two months or so. Maybe you
were not running sensors -s before? Did you change anything on your
system at the time things broke (lm_sensors, kernel, BIOS...)?

>My motherboard is Gigabyte GA-8IE533
>
>Chipset
>------------
>Intel? 845E
>Intel? 82801DB ICH4
>Super I/O: ITE8702 chip

Aha. Interesting. We do not officially support the IT8702. We only
support the IT8705 and IT8712 (and SiS clone). I bet that the IT8702 is
mostly compatible with the two chips we support (or you would get broken
readings), but maybe not completely.

Are you 100% sure it is an IT8702?

First, please make sure that you are using a configuration file from
lm_sensors 2.8.8. The configuration file is installed at
/etc/sensors.conf but old files are not overwritten. Get the file from
lm_sensors2/etc/sensors.conf.eg and copy it manually to /etc.

Then, you may try to isolate the lines causing trouble. Candidates are
obviously in the "it87-*" section. Lines which are taken into account
by "sensors -s" are those begining with "set". Comment them all out
except one, and see if it helps. Maybe only one or few lines are causing
trouble. Or maybe any write to the chip will break it.

A comparison between IT8705 and IT8702 datasheets could help too.

--
Jean Delvare
