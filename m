From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 28 Apr 2010 07:36:11 +0000
Subject: Re: [lm-sensors] x86- smbus interfaced eeprom disappears
Message-Id: <20100428093611.7d82b779@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <h2j2249bc5f1004271720s33a6c07byf0db65508c6fe174@mail.gmail.com>
In-Reply-To: <h2j2249bc5f1004271720s33a6c07byf0db65508c6fe174@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi James,

On Tue, 27 Apr 2010 17:20:02 -0700, mukund jampala wrote:
> Hi Guys,
> 
> I have a this wierd problem.
> I have a smbus interfaced eeprom device which I can read/write normally
> untill I plug-in the Fiber PCI express card I have.
> 
> If I insert an optical Fiber PCI express card into this x86 board, the smbus
> interfaces eeprom which I want to access is no more accessble. I can read
> but what is get is Junk.
> This happens when I insert only this Card. Not anyother Card.
> It does not report an error or so when reading/writing.
> 
> I can still see it in /sys/class/i2c-dev/i2c-0/.
> If I probe the bus, the sensors-detect detects the some device at 0x50 but
> it happens to be the case where the values I read from the device are not
> valid.
> However, lm-sensors does not detect the eeprom device irrecpective of where
> the PCI card is inserted or not.
> (...)

Your issue has nothing to do with hardware monitoring, so you're asking
on the wrong mailing list. Please try the linux-i2c mailing list
instead (see MAINTAINERS).

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
