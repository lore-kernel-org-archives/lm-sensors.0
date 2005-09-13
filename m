From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 13 Sep 2005 19:12:04 +0000
Subject: [lm-sensors] no sensors found beyond eeproms - OEM laptop
Message-Id: <4327082D.2080904@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <a2967b6d05090101374c7f1294@mail.gmail.com>
In-Reply-To: <a2967b6d05090101374c7f1294@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

It is difficult to find out what laptops are using. Maybe the ACPI
thermal zone will work for you.

Did you try to load:
modprobe thermal
acpi -V

it should tell you the temp.

If you still want to use lm_sensors please send us output of following:

modprobe i2c-sis96x
modprobe i2c-dev

i2cdump 0 0x6a
i2cdump 0 0x10

Jean? Any other ideas?

regards
Rudolf

