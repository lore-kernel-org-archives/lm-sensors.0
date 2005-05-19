From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: I2C synced up with 2.6
Message-Id: <20040622223223.GA3533@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Oops, forgot to cc: the sensors mailing list...  Today I synced up with
Linus the I2C patches that had been sent to me in the past few weeks.
They are all now in Linus's tree, I didn't CC: this list as I had to
merge my i2c and driver tree due to some driver core changes that
required changes to the i2c drivers.

Anyway, you can check out the individual patches on the linux-kernel
mailing list, or just wait till the next release from Linus to verify I
got everyone's patches.

thanks,

greg k-h
