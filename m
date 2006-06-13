From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 13 Jun 2006 08:53:13 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <20060613105313.4a58676d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> > The name is not very well chosen, these registers can hold both a target
> > temperature or a target fan speed depending on the control mode (even
> > if we don't support the latter at the moment.) What about just
> > W83627EHF_REG_TARGET?
> 
> This is a good suggestion. In the near future, the registers will hold
> one or the other value, and the driver will support both modes. Rudolf
> and I talked about storing both values in the driver, with separate
> sysfs files so libsensors could read either value, the one on the chip
> or the one that will replace the value on the chip if the mode
> switched. Advantages to doing it this way: we can set a reasonable
> default for the value that's not on the chip, so when the mdoe
> switches, the value in the register is not left unchanged (and
> probably not reasonable); also, from userspace, it looks like there
> are two registers, even though in hardware there's only one.
> 
> Disadvantages: well, emulation is bad, isn't it? But here I would
> argue for emulating separate registers in the driver because the
> register sharing in the hardware is impossible to map directly to a
> sysfs file. If we're going to have two sysfs files with different
> meanings, then can we just emulate separate registers?

I'm fine with having two sets of internal variables, the reasons you
give in that sense are good ones. I don't think doing so qualifies as
"emulation". The hardware designers took an unfortunate shortcut by
using the same registers for different functions, we need to deal with
this. 

Thanks,
-- 
Jean Delvare

