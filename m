From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: [PATCH 2.6] I2C: Fix incorrect sysfs file permissions in it87 and
Message-Id: <20050406190049.GB30839@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050402212631.41916710.khali@linux-fr.org>
In-Reply-To: <20050402212631.41916710.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Apr 02, 2005 at 09:26:31PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> The it87 and via686a hardware monitoring drivers each create a sysfs
> file named "alarms" in R/W mode, while they should really create it in
> read-only mode. Since we don't provide a store function for these files,
> write attempts to these files will do something undefined (I guess) and
> bad (I am sure). My own try resulted in a locked terminal (where I
> attempted the write) and a 100% CPU load until next reboot.
> 
> As a side note, wouldn't it make sense to check, when creating sysfs
> files, that readable files have a non-NULL show method, and writable
> files have a non-NULL store method? I know drivers are not supposed to
> do stupid things, but there is already a BUG_ON for several conditions
> in sysfs_create_file, so maybe we could add two more?
> 
> Please apply,

Applied, thanks.

greg k-h
