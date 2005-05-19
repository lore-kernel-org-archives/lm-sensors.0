From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: Problem with eeprom module in 2.9.0
Message-Id: <20050106223520.GD5303@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <41DDAE4F.9030606@earthlink.net>
In-Reply-To: <41DDAE4F.9030606@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Jean Delvare <khali@linux-fr.org> [2005-01-06 23:12:16 +0100]:
> OK, the big change here is most probably the support (or attempt
> thereof) of I2C block read in i2c-i801. As far as I know you are the
> first tester of this feature. The eeprom driver does make use of this
> feature when possible, and it doesn't seem to work as intended for you.
> 
> What I find strange is that the lm93 driver does make use of the block
> transfers too, and they seem to work for you (until the eeprom driver
> trashes the whole bus). This suggests that the bug isn't in the i2c-i801
> driver but it the eeprom driver, or maybe the eeprom and lm93 driver do
> not use i2c block reads in the same way.

MDS just added the I2C variant of the block transfer.  But lm93 uses the
SMBus variant... so it is possible that it's a problem in i2c-i801.

Of course last time I said something like that, there was egg all over
my face... :)

> What's the PCI ID of this one? Maybe block transfers work OK for the
> E7501 but not for the E7520.
> 
> Can you please try the attached patch? It disables block reads in the
> eeprom driver. If it solves the problem for you then we at least know
> what is triggering the bug (although I still can't get why lm93 doesn't
> trigger it).

See above.  But the eeprom patch you gave is still a useful test.

I really should get a 2.4 kernel / distro back on my ICH5 machine so I
can see what's going on there.  I'm short on time this week and will
be traveling next week... so it may have to wait a while.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
