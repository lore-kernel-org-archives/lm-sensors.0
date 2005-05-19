From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: ticket 1775
Message-Id: <20040920154144.M506@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1C9PtS-000754-00@mendel.bio.caltech.edu>
In-Reply-To: <E1C9PtS-000754-00@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 20 Sep 2004 08:15:54 -0700, David Mathog wrote
> (Sorry, couldn't figure out how to amend a ticket through
> the web interface.)

Maybe that's because there is no way? Our ticket system sucks.

> In reply to ticket 1775 the response was:
> 
> > try changing sensor type to 3435 in sensors.conf
> 
> The sensors.conf from Tyan (and every other one I've
> found on the web for this mobo) says to do this:
> 
>  # thermal sensor types (do not adjust)
>    set sensor1 2
>    set sensor2 2
>    set sensor3 2
> 
> Moreover, those settings worked on the same machine when
> it ran RH 7.3 and an older version of lm_sensors.  However,
> now they do not work (kernel 2.8.6.1 and sensors 2.8.7).
> Since the hardware type of the sensor on the mobo clearly has
> not changed (only the OS) why would the sensor type change now
> from 2 to 3435 with a different version of the kernel or
> lm_sensors???

Completely agreed.

One interesting thing I found in Tyan's proposed configuration file is that
there should be two monitoring chips, not just one. What's more, addresses for
these chips should be 0x2c and 0x2d, while yours shows at 0x28.

Another thing worth noting IMHO is that Tyan's config file, and your old RH
7.3, date from before the ISA-only w83627hf chip driver was written. Thus I
would suggest that you do *not* load the i2c-isa nor w83627hf drivers, so as
to be as near as possible from your original setup. We may try using the
(possibly better) w83627hf driver at a later time. One thing at a time.

Tyan suggests to use the following line in /etc/modules.conf:
options w83781d force_w83782d=0,0x2d force_subclients=0,0x2d,0x48,0x49
force_w83627hf=0,0x2c force_subclients=0,0x2c,0x4a,0x4b init=0
Did you try doing this? Note that for Linux 2.6, the correct file is
/etc/modprobe.conf, not modules.conf.

If it doesn't help, you may provide a scan of your I2C bus (i2cdetect 0) for a
starter.

-- 
Jean Delvare
http://khali.linux-fr.org/
