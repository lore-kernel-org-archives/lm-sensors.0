From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 17 Aug 2006 20:50:24 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND 2] hwmon: new vt1211 driver
Message-Id: <20060817225024.f02bad76.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0605311844n3d24f429k8942ffaa15e864a8@mail.gmail.com>
In-Reply-To: <191fb4ca0605311844n3d24f429k8942ffaa15e864a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

> > Really, I don't think so. That's what we have in the 2.4 driver:
> >
> > http://www.lm-sensors.org/browser/lm-sensors/trunk/kernel/chips/vt1211.c
> >
> > 122     static const u8 regtemp[] = { 0x20, 0x21, 0x1f, 0x22, 0x23, 0x24, 0x25 };
> > 123     static const u8 regover[] = { 0x39, 0x3d, 0x1d, 0x2b, 0x2d, 0x2f, 0x31 };
> > 124     static const u8 reghyst[] = { 0x3a, 0x3e, 0x1e, 0x2c, 0x2e, 0x30, 0x32 };
> >
> > regtemp is similar, but regover and reghyst have their 1st and 3rd
> > elements swapped. The datasheet matches your version, so this has to be
> > a bug in the 2.4 driver. In doubt, you could check if the alarm flags
> > for temp1 and temp3 trigger as expected.
> 
> OK, yes. Now I remember. Regover and reghyst in 2.4 are correct but
> regtemp has elements 1 and 3 swapped (compared to the datasheet). I
> kept the swapping but fixed regover and reghyst to stay compatible
> with sensors.conf. If we want to follow the datasheet (rev 1.42) it
> would have to be as follows:
> 
> static const u8 regtemp[] = { 0x1f, 0x21, 0x20, 0x22, 0x23, 0x24, 0x25 };
> static const u8 regover[] = { 0x39, 0x3d, 0x1d, 0x2b, 0x2d, 0x2f, 0x31 };
> static const u8 reghyst[] = { 0x3a, 0x3e, 0x1e, 0x2c, 0x2e, 0x30, 0x32 };
> 
> i.e.:
> temp1 = Reading 1
> temp2 = Reading 2
> temp3 = Reading 3
> temp4 = UCH2
> temp5 = UCH3
> temp6 = UCH4
> temp7 = UCH5

I don't know what others think, but I don't really care. If you want to
put temp1 and temp3 back in sync with the datasheet, feel free to do
so. If you prefer to keep them swapped, that's fine as well. We'll have
to adjust the 2.4 driver and sensors.conf.eg in both cases anyway.

-- 
Jean Delvare

