From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 23 Jan 2007 15:36:18 +0000
Subject: [lm-sensors] DME1737 / A8000 support
Message-Id: <20070123163618.0b56133d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0701230637t433847f3yb3044ebd77af13df@mail.gmail.com>
In-Reply-To: <191fb4ca0701230637t433847f3yb3044ebd77af13df@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Tue, 23 Jan 2007 06:37:20 -0800, Juerg Haefliger wrote:
> Jean,
> 
> I managed to pick up the datasheet for the SMSC DME1737 (also known as Asus
> A8000) :-) I took a quick glance and the HW monitoring logic is definitely
> an LM85 clone. Even the register descriptions are sometimes copied
> word-to-word. There are a few differences though:
> - additional voltage and fan inputs
> - additional pwm outputs
> - 12bit temp and voltage resolution
> - advanced configuration settings
> 
> I was wondering if it makes more sense to create a new driver than adding
> support to the current LM85 driver. I fear that support for the DME1737
> would clobber up the LM85 driver even more than it is already. But a
> separate driver would have some significant code redundancy with the LM85.
> 
> I'd prefer to write a new driver, then I could also 'fix' some coding style
> issues...

I definitely vote for a new driver, the lm85 driver is fat enough as
is. And my experience with not publicly documented, supposedly
compatible chips is that they end up bloating the drivers we add them
to (see the AS99127F support in driver w83781d for example.)

Thanks,
-- 
Jean Delvare

