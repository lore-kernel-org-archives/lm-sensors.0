From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: ticket 1775
Message-Id: <20040921201218.46e0c529.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1C9PtS-000754-00@mendel.bio.caltech.edu>
In-Reply-To: <E1C9PtS-000754-00@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Um, well, the alarm seems to come and go here:
> > 
> > VCore 1:   +1.73 V  (min =  +1.66 V, max =  +1.94 V)
> > sometimes it reads ALARM too, sometimes not. The Voltage
> > shown doesn't change though.
>
> No idea. You could try to periodically dump the chip contents (using
> i2cdump 0 0x28 or i2cdump 0 0x2c) and see if the alarms shows there
> too (bit 1 of register 0x41).

My mistake, it's actually bit 0, not 1.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
