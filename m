From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 24 Nov 2008 20:18:07 +0000
Subject: Re: [lm-sensors] DDR2 SODIMM temperature sensor driver
Message-Id: <20081124201807.GA6651@plum>
List-Id: <lm-sensors.vger.kernel.org>
References: <4918113B.7060409@embedded-sol.com>
In-Reply-To: <4918113B.7060409@embedded-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Nov 24, 2008 at 09:30:21AM +0100, Jean Delvare wrote:
> Hi Felix,
> 
> On Mon, 10 Nov 2008 12:47:23 +0200, Felix Radensky wrote:
> > I'm looking for a driver for DDR2 SODIMM temperature sensor.
> > Is it available for Linux, or maybe somebody is working on it ?
> 
> The only temperature sensor driver we have for memory modules is
> i5k_amb, which handles the Intel 5000 series chipsets:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/hwmon/i5k_amb.c
> These chips are only found in high-end servers as far as I know. I
> don't know exactly where the sensors are located, maybe Darrick (Cc'd)
> knows more.

The FB-DIMM temperature sensors are inside the AMB buffer chip on the
memory module.  Not sure how many non-FB DDR2 DIMMs have temperature
sensors that you can read; none of my machines (even the laptops) have
any.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
