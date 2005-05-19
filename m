From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: I have information on Winbond W83627EHF Chip
Message-Id: <20050208231821.64c1364a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
In-Reply-To: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> I downloaded and installed the new script, but it looks like it still
> did not detect the chip. Here is the output:

Damn. All three detection methods failed. Let's see why.

>  We can start with probing for (PCI) I2C or SMBus adapters.
>  You do not need any special privileges for this.
>  Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Sorry, no PCI bus adapters found.

Strange. Can you share the output of "lspci" and "lspci -n" with us?

> Probing for `Winbond W83627EHF'
>   Trying address 0x0290... Failed!

Maybe the chip is actually at a different ISA address, can't confirm as
long as the Super-I/O chip isn't properly detected.

> Probing for `Winbond W83627EHF Super IO Sensors'
>   Failed! (0x8853)

Ah, this one is not my fault! The datasheet mentioned 0x886x as the chip
ID. I've now modified the code to accept anything from 0x8840 to 0x887f.
Please get the updated version and try again.
http://www2.lm-sensors.nu/%7Elm78/cvs/lm_sensors2/prog/detect/sensors-detect

Thanks,
-- 
Jean Delvare
