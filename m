From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 18 Feb 2006 17:43:10 +0000
Subject: [lm-sensors] vt8231 - epia800
Message-Id: <20060218184310.86c90567.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <d5dcbca20602171241s2380ccc6x@mail.gmail.com>
In-Reply-To: <d5dcbca20602171241s2380ccc6x@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > > ERROR: Can't get TEMP2 data!
> > > ERROR: Can't get TEMP3 data!
> > > ERROR: Can't get TEMP4 data!
> > > ERROR: Can't get TEMP5 data!
> > > ERROR: Can't get TEMP6 data!
> > > ERROR: Can't get TEMP7 data!
> >
> > Kernel version (uname -r)?
> 
> 2.6.16-rc3
> with the last vt8231 patch (given in this mailing list)

Which patch? The vt8231 driver is already included in 2.6.16-rc3.

> Sensors version (sensors -v)?
> 
> sensors version 2.9.2 with libsensors version 2.9.2

Not sufficient, you'll need version 2.10.0 (just released) for vt8231
support for Linux 2.6.

-- 
Jean Delvare

