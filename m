From: dtor_core@ameritech.net (Dmitry Torokhov)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [03/07] I2C: Fix incorrect sysfs file permissions in it87 and
Message-Id: <200504280047.43130.dtor_core@ameritech.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050427171446.GA3195@kroah.com> <20050427171617.GD3195@kroah.com>
In-Reply-To: <20050427171617.GD3195@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Greg KH <gregkh@suse.de>, khali@linux-fr.org, sensors@stimpy.netroedge.com, stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>, Theodore Ts'o <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>, Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk

On Wednesday 27 April 2005 12:16, Greg KH wrote:
> As a side note, wouldn't it make sense to check, when creating sysfs
> files, that readable files have a non-NULL show method, and writable
> files have a non-NULL store method? I know drivers are not supposed to
> do stupid things, but there is already a BUG_ON for several conditions
> in sysfs_create_file, so maybe we could add two more?

Checking at creation time is not enough. Even with such check one could
change permissions on a sysfs file and set write bit.

-- 
Dmitry
