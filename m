From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: i2c-piix4 problem
Message-Id: <20040805080657.0eafacb6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200408041637.21472.lists@localguru.de>
In-Reply-To: <200408041637.21472.lists@localguru.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > > The following kernel modules are loaded:
> > >
> > > # lsmod:
> > > Module                  Size  Used by    Tainted: P
> > > i2c-proc                6272   0
> > > i2c-dev                 3680   0
> > > i2c-piix4               3908   0
> > > i2c-core               12160   0  [i2c-proc i2c-dev i2c-piix4]
> >
> > i2c-piix4 is a bus driver. You need an additional chip driver to get
> > temperature readings. Try "sensors-detect" to find out which one you
> > need.
> 
> That's what sensors-detect found out / loaded.

A.k.a. no sensors found, unless a problem occured. If you're certain
that there is a hardware monitoring chip on that board and
sensors-detect missed it, please give us:
1* The brand and name of the motherboard.
2* The full output of sensors-detect.
3* The brand and name of the monitoring chipset we are after.

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
