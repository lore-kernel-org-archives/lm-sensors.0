From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 21 Oct 2007 19:14:50 +0000
Subject: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!
Message-Id: <20071021211450.784d691a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1642847378@web.de>
In-Reply-To: <1642847378@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juergen,

On Sat, 20 Oct 2007 21:28:02 +0200, Juergen Bausa wrote:
> 
> > Von: Jean Delvare <khali@linux-fr.org>
> > Gesendet: 17.10.07 23:32:28
> >
> > On Wed, 17 Oct 2007 12:43:16 -0700, Juerg Haefliger wrote:
> > > On 10/17/07, Juergen Bausa <Juergen.Bausa@web.de> wrote:
> > > > Here is what I found in /var/log:
> > > >
> > > > /var/log/messages:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
> > > > /var/log/messages:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
> > > > /var/log/messages:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-0: Found a DME1737 chip at 0x2e (rev 0x8a)
> > > >
> > > > /var/log/debug:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-0: SMBus Timeout! (0x10)
> > > > /var/log/debug:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-0: SMBus Timeout! (0x10)
> > > > /var/log/debug:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-1: SMBus Timeout! (0x10)
> > > 
> > > These are all errors that occur when the drivers (i2c and dme1737) get
> > > loaded. The dme1737 is not printing any errors so they are not
> > > transactions initiated by the dme1737. The 0x10 means "SMBus Device
> > > Address Not Acknowledged" according to the ACPI spec. Not sure how
> > > this can happen... Signal integrity problems on the board level? In
> > > any case, these errors should probably be retried. Not sure at what
> > > level though. Jean?
> > 
> > These are not errors at all, it's only i2c-core probing at work. The
> > dme1737 driver specifies three possible addresses (0x2c, 0x2d, 0x2e),
> > the probes at 0x2c and 0x2d on bus 0 fail, these are the first two
> > "SMBus Timeout!" messages above. Then the probe at 0x2e succeeds. Then
> > i2c-core goes on with bus 1. There should have been 3 failing probes
> > there, but surprisingly, there's only one "SMBus Timeout!" for bus 1. I
> > can't explain it.
> 
> I greped the mesages. Maybe, there was a 'message repeated xx times' in
> the log, that wasnt displayed.

Ah, OK, that explains it.

> lisa:/home/jba# i2cdetect -y 0
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- 08 -- -- -- -- 0d -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- UU --
> 30: 30 31 -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 50: 50 51 -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --

Aha. The "0d" is suspicious, I've never seen any chip using this
address. I really wonder what it is. The rest is standard.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
