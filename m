From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: driver for MAX1668?
Message-Id: <3F5B654B.7E8E8F4B@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <212D7E61C1F7D511B9270002A507DE7D24B77E@us-bv-m10.bv.tek.com>
In-Reply-To: <212D7E61C1F7D511B9270002A507DE7D24B77E@us-bv-m10.bv.tek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

that sounds good.
We'll add you to our New Drivers page.
From the datasheet it looks like the 1989 and 1805 are similar,
you should to consider adding them to the same driver.
They have three different Device ID's so detection will be easy.
adm1021 is probably as good a place to start as any.
See doc/developers/new_drivers for more info.
mds

carolyn.j.smith@exgate.tek.com wrote:
> 
> Hello,
> 
> I recently found your page and think it may be really useful. We will be
> using the MAX1668 temperature sensor which I didn't see supported though it
> looks like you support the MAX1617A which is fairly similar. I am thinking
> of starting from adm1021.c and writing my own driver for the MAX1668 unless
> anyone else is already working on it? Is that the best way for me to start?
> 
> Thanks,
> Carolyn Smith
> Tektronix, Inc.
