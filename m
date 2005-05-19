From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:28 +0000
Subject: application for LM75 sensor
Message-Id: <3C3E0060.10D0654C@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <E7FEE1294B1AD51192490002A50EF31F0134D3@EXCHSERV>
In-Reply-To: <E7FEE1294B1AD51192490002A50EF31F0134D3@EXCHSERV>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

You can use:
	1) character device access to the i2c bus driver
	2) /proc file access
	3) libsensors library API
There are examples of all three and extensive documentation in our package.
mds

> TJ Fang wrote:
> 
> Hi...
> 
> I want to write a linux application to use LM75 sensor driver. Could you please tell me how I interface to the driver. Can I consider it as a character device driver, which using OPEN, READ, WRITE,
> CLOSE. If there is any example to deal with the LM75 driver will be much helpful, thanks.
> 
> 
> Regards
> T.J.Fang
> Software Engineer
> Xyterra Computing Inc.
> (480)609-5118
> tjfang@xyterra.com
