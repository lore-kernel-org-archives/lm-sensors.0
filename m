From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:26 +0000
Subject: sensor LM76 and real time clock DS1307
Message-Id: <3C17D5A8.EBF47103@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <E7FEE1294B1AD51192490002A50EF31F0134BC@EXCHSERV>
In-Reply-To: <E7FEE1294B1AD51192490002A50EF31F0134BC@EXCHSERV>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

As shown on our 'new drivers' page, we do not support the LM76.
You may have some luck with the lm75 driver.

We also don't support the ds1307.

have you found these on a standard motherboard or is this
for a different application?



> TJ Fang wrote:
> 
> Hi..
> 
> Could you please tell me do you support temperature sensor LM76 on the
> Linux? If you do, could you please point to me where I can find it and
> plus, do you support the real time clock DS1307 chip on the Linux.
> Both chips use I2C interface.
> 
> Regards
> T.J.Fang
> Software Engineer
> Xyterra Computing Inc.
> (480)609-5118
> tjfang@xyterra.com
