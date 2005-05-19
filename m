From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: S3Graphics Savage4 i2c driver
Message-Id: <3BE005D8.F0E99A2F@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3BDFD65B.B8327B91@bigfoot.com>
In-Reply-To: <3BDFD65B.B8327B91@bigfoot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

sure, we'll take it.
You should get i2cdump working first.

If you are using i2c-algo-bit, you can use
modprobe i2c-algo-bit bit_test=1 debug=2 (IIRC - check the source)
 to help debug things

mds



Alexander Wold wrote:
> 
> Hello,
> 
> I have recently created an i2c driver for the Savage4. It is based upon
> the i2c-voodoo3 driver. The main motivation was to get access to the
> bt868 connected to S3Savge4`s i2c bus. If this driver is of general
> interest, I will be happy to submit it to the project. The driver is
> complete, and working. There are some issues thow, i2cdump hangs the
> bus, and after starting X, writes to the i2c bus don`t work. When
> reloading/loading the module in X (or while x is running) it works fine.
> 
> Regards,
>     Alexander Wold
