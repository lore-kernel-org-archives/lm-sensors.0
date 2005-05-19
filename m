From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: Memory leak in I2C (ticket #1898)
Message-Id: <20050219185651.0c111672.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <jG6nFvCq.1108465575.6408970.khali@localhost>
In-Reply-To: <jG6nFvCq.1108465575.6408970.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi James,

> Here is the list in the order they are loaded:
> 
>     i2c-core i2c-dev i2c-proc i2c-i801 lm87b lm93 eeprom pcf8574
> 
> When I found the appearant memory leak I was only loading and
> unloading modules lm93, eeprom, pcf8574.

Tried with i2c-core, i2c-proc, i2c-viapro and w83781d, with only w83781d
cycling. I noticed that the "free" memory as reported by top would
decrease almost to 0. However it would NOT generate a memory shortage.
If I run Firefox at this point, it'll get all the memory it needs (and I
disabled swap for the test). So I don't think I am able to reproduce
what you described.

Can you possibly try with each of the three modules (lm93, eeprom,
pcf8574) individually and see if all cause the trouble, or only one of
them?

How much memory do you have on your system?

> Not a problem.  Thanks for looking into this.  One of these days I'll
> get my head around the I2C and lm_sensors architecture in the kernel,
> and maybe I can send you patches instead (-;

This would indeed be very welcome :)

-- 
Jean Delvare
