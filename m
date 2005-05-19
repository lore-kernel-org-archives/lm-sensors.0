From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: [Fwd: Smbus transaction issues using the i2c-algo-bit implementation]
Message-Id: <3D1A21EF.61701061@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

As you know I've been working closely with Dori Eldar of Intel on adding ICH4 support
to i2c-i801 and SMBus 2.0 support to I2C.

She has implemented a full SMBus 2.0 implementation (for bit-banging interfaces)
that is similar to, and a replacement of,
i2c-algo-bit. She had some specific issues with our smbus/i2c implementation that
caused her to do so. I asked her to document those issues for us so that
we could investigate fixing/enhancing our existing implementation to resolve those issues,
where possible. 

Dori obviously has taken the time to study our code and carefully document
her issues. She also was instrumental in the
donation of a system to us. So let's discuss these issues.

I'll add some comments of my own at a later date.

mds
-------------- next part --------------
An embedded message was scrubbed...
From: "Eldar, Dori" <dori.eldar@intel.com>
Subject: Smbus transaction issues using the i2c-algo-bit implementation
Date: Wed, 26 Jun 2002 10:29:58 +0300
Size: 5584
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020626/656f3da1/attachment.mht
