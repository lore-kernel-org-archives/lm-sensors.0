From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 25 Sep 2005 00:07:06 +0000
Subject: [lm-sensors] Asus Z80V/M6V i2c support
Message-Id: <4335CDF5.1030601@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <318b1df00509211647a24cdec@mail.gmail.com>
In-Reply-To: <318b1df00509211647a24cdec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Thanks for the patch, but I would prefer a single one for the region quirk and you will recive
the credits when this will be in kernel :)

Hmm it seems you have ACPI PNP that will put correct IO regions to  /proc/ioports,
Please try booting without the quirk patch with pnpacpi=off

and then cat /proc/ioports
and then with same kernel option but with the quirk patch.

Thanks

Regards
Rudolf
