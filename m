From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 22 Mar 2006 10:06:27 +0000
Subject: [lm-sensors] ASUS and Wibond donating a motherboard
Message-Id: <442121A3.6000202@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

As you might read from the subject line ASUS and Winbond donated a motherboard to the project!
We have now ASUS P5MT-S with the W83792D chip with a CPU Intel(R) Celeron(R) CPU 2.80GHz and 512MB RAM from Winbond.
I added the case + PSU and 60GB hardrive.

This donation will help us with the W83792D driver testing plus maintanance. I have in plan to implement some
missing features for this chip like VID line handling and possibly a watchdog support.

Moreover the machine has an ICH7 SMBUs so it might help us with the i2c-i801 driver.
0000:00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)

And as some of us here might remmeber this motherboard has that multiplexer so this machine might help
when developing the multiplexer bus driver.

The machine is up and running and is connected to internet so developers can use it when they need.
I updated the website with the news.

I would like to thank both companies for this donation and I'm looking forward for further cooperation.

Regards
Rudolf

