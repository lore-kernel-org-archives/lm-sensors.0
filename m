From: ramon.casha@linux.org.mt (Ramon Casha)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: undetected chips
Message-Id: <200408051154.18242.ramon.casha@linux.org.mt>
List-Id: <lm-sensors.vger.kernel.org>
References: <200408050908.47507.ramon.casha@linux.org.mt>
In-Reply-To: <200408050908.47507.ramon.casha@linux.org.mt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thursday 05 August 2004 10:08, Jean Delvare wrote:
> > Hi. I've got a PC which doesn't get its sensors detected properly
> > (assuming there are any). The PC is an HP deskpro d230m,P4 2.66
> > (...)
> > i2cdump for 0x2d
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX 00 00
> > 20: bd 7f c0 c0 be c1 20 1d XX XX XX ff ef ff ff bf
> > 30: ff ff ff ff ff ff ff 32 00 7d d8 XX XX XX 55 20
> > 40: 09 0f 0f XX XX XX XX 0d XX 80 00 32 00 00 XX 04
> > 50: c4 b9 1c XX ff ff ff ff 41 d8 XX XX XX XX XX XX
> > 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>
> This one looks like an anonymous ADM1025 to me. Manufacturer register is
> at 0x3E. 0x55 is nobody we know of (yet) but 0x20 at 0x3F matches the
> ADM1025/NE1619 ID, and the registers map matches almost exactly too.
>
> Try forcing the adm1025 driver (modprobe amd1025 force_adm1025=0,0x2d)
> and see how it goes.

seems like my kernel (2.6.3) doesnt have that - the closest is adm1021 which 
doesn't do much. 

>
> It would be great if you could ask HP for information, or, even better,
> open the box and try to find the monitoring chip. Look for a small chip
> (16 pins rectangular). The ADM1025 and NE1619 follow an Intel standard
> named "Heceta 4", if this is of any help.

will do. thanks.

-- 
Ramon Casha
Malta Linux User Group (http://linux.org.mt)
