From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: sensors-detect and 2.6.0-test3
Message-Id: <20030819194952.GA5796@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.GSO.4.21.0308172027560.12924-100000@vervain.sonytel.be>
In-Reply-To: <Pine.GSO.4.21.0308172027560.12924-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Aug 17, 2003 at 08:32:44PM +0200, Geert Uytterhoeven wrote:
> 	Hi,
> 
> I'm porting i2c-hydra (which I wrote many years ago) to 2.6.0-test3 and am
> trying to test it. I want to probe for all i2c devices on my i2c bus, but
> sensors-detect doesn't work because /proc/bus/i2c is not there.

sensors-detect does not work on 2.6, sorry.  You have to poke around in
the sysfs tree by hand right now after loading the drivers by hand :)

> According to the FAQ I have to `modprobe i2c-proc', but I cannot find the code
> for that module in the kernel tree.

That module does not exist in the 2.6 tree.

> How do I probe for all i2c devices in 2.6.0-test3? Thanks!

I just load all of the drivers and see what happens :)

Good luck,

greg k-h
