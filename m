From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 24 Nov 2008 08:30:21 +0000
Subject: Re: [lm-sensors] DDR2 SODIMM temperature sensor driver
Message-Id: <20081124093021.766a201c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4918113B.7060409@embedded-sol.com>
In-Reply-To: <4918113B.7060409@embedded-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Felix,

On Mon, 10 Nov 2008 12:47:23 +0200, Felix Radensky wrote:
> I'm looking for a driver for DDR2 SODIMM temperature sensor.
> Is it available for Linux, or maybe somebody is working on it ?

The only temperature sensor driver we have for memory modules is
i5k_amb, which handles the Intel 5000 series chipsets:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/hwmon/i5k_amb.c
These chips are only found in high-end servers as far as I know. I
don't know exactly where the sensors are located, maybe Darrick (Cc'd)
knows more.

What is your hardware exactly, and what makes you think it has
temperature sensors integrated in the memory modules?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
