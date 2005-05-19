From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: SMSC LPC47M192 SMBus question
Message-Id: <BFvgtSXf.1113308441.3577050.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <87vf6ua498.wl@wore.ma.cx>
In-Reply-To: <87vf6ua498.wl@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi,

> # check i2cdetect
>
> According to PDF page 130,
> > The default power on SMBus address is 010110x binary,
> > where x reflects the state defined by the A0 pin.
>
> 0x2d is 0101101, so it seems it is the chip.
> (...)
> According to PDF page 184,
> reg 0x3e is Company ID and default value is 0x55,
> reg 0x3f is Stepping and default value is 0x20,
>
> dump seems correct.
> (...)
> Then, I began to SMBus only driver on 2.4.29 kernel.
> Currently, no function is implemented.
> Just check chip corp and exit.
>
> I will complete it by the weekend.

You might want to get in touch with Tomas Holmqvist, who contacted us
some times ago for a similar problem:

http://archives.andrew.net.au/lm-sensors/msg29831.html

I think I remember that the LPC47M15x and LPC47M192 are mostly compatible
(would need to verify with the datasheets whether this applied to the
HWM block as well). If this is the case, it would probably make sense to
join your forces and write a single driver for both chips.

Thanks,
--
Jean Delvare
