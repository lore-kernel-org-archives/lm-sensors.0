From: Stevie Trujillo <stevie.trujillo@gmail.com>
Date: Tue, 10 Jul 2012 14:24:55 +0000
Subject: [lm-sensors] GA-Z77X-UD3H with ITE IT8728F, modprobe it87 freezes system
Message-Id: <CAJiZuY3QBnkcAsisvbg9pEzMt044aVBF+vwzrCHsGTS_N9ez1A@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have a Gigabyte GA-Z77X-UD3H motherboard with a 3570k CPU and 32GiB ram.
  * ISA bus, address 0xa30
    Chip `ITE IT8728F Super IO Sensors' (confidence: 9)

I run Gentoo with linux-3.4.4, if I do "modprobe it87" the system freezes.
I was told GA-Z77X-D3H (not UD3H) works in Debian Squeeze with 3.2
kernel from Debian backports.
I installed Squeeze, for me it freezes there too:

# modprobe it87
it87: Found IT8728F chip at 0xa30, revision 1
it87: Beeping is supported
* here it froze*

How can I fix/debug this?

Thank you!
Stevie Trujillo

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
