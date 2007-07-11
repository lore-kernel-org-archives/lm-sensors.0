From: =?windows-1250?Q?Petr_Jake=9A?= <petr.jakes@tpc.cz>
Date: Wed, 11 Jul 2007 18:08:41 +0000
Subject: Re: [lm-sensors] py-smbus
Message-Id: <8110465348.20070711200841@tpc.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1183894739.4690ccd3a0748@webmail.monix.cz>
In-Reply-To: <1183894739.4690ccd3a0748@webmail.monix.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


MMH> Hi Petr:

MMH> * petr@tpc.cz <petr@tpc.cz> [2007-07-08 13:38:59 +0200]:
>> Hi,
>> trying to install py-smbus but no success. I am sending install log in the
>> attachment. Thanks for your comments and suggestions...
>> Petr Jakes

MMH> Log file says...
>> smbusmodule.c:19:20: Python.h: No such file or directory

MMH> On RedHat/Fedora systems, this is resolved by installing the python-devel
MMH> package.  Whatever is the equivalent for Ubuntu - install it and try again.

Mark,
I am sending this message to provide feedback for other users:

I have successfully installed py-smbus on command line version of
Ubuntu 7.04 "Feisty Fawn".

My hardware is AMD Geode GX low power (1.1W) motherboard (equipped by
the SMBus connector).

Before to install py-smbus it was (according to your suggestions) necessary:
1) install package python-dev
2) install package libsysfs-dev
3) download lm-sensors and install: 'make user && sudo make user_install'

   After that it was possible to installl py-smbus
4) download py-smbus and install

5) my board is equipped by the AMD Geode CS5536 south bridge, so
   necessary SMBus module is "scx200_acb"
   "modprobe scx200_acb" installs this module to the kernel

6) finally: "modprobe i2c-dev" allows to access smbus(0)

many thanks

Regards

Petr Jakes






_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
