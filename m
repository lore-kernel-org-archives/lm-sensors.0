From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: possible bug - lm_sensors
Message-Id: <1081329025.4073c58198e04@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040407083656.GE9551@neu.nirvana>
In-Reply-To: <20040407083656.GE9551@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > /etc/sensors.conf
> > >@@ -1630,12 +1630,28 @@
> > > # Analog inputs
> > >
> > >    ignore ain_conf
> > >-   set    ain_conf    0
> > >+# Since Linux 2.6, input configuration is set as module
parameter,
> > >+# so the line below is for older kernels only.
> > >+#  set    ain_conf    0
> > >+
> > >+# You may discard ch2 and ch3 if you don't use them (depends on
> > >+# the input configuration)
> > >+#  ignore ch2
> > >+#  ignore ch3
> > >+
> > >    label  ch0         "Chan. 0"
> > >    label  ch1         "Chan. 1"
> > >    label  ch2         "Chan. 2"
> > >    label  ch3         "Chan. 3"
> > 
> > The recent change seems to have removed some behaviour that seems -
> > by comments - to be required for kernel 2.4.

Not really required. The driver initialize the value to 0 by default, so
the commented out line (set ain_conf 0) mostly has no effect unless you
also change the value.

> > Should the package have a conflicts: so it doesn't install with 2.4
> > kernels?  Should another package be built for 2.4 with that option
> > uncommented?  It all depends on whether it's really an important
> > bit, I guess.

It's actually not important, for two reasons. First, as said right
above, this is the default value anyway, so it doesn't change anything.
Second, the pcf8591 driver is almost not used. PCF8591 devices are not
present on motherboards as far as I know, and the driver was only
written and ported to Linux 2.6 to support home-maid electronic
devices.

> I think this is there by mistake, the built packages are meant for
> 2.4 (or from the source code's POV for both 2.6 and 2.4). I suggest
> that either the comment is wrong (works also with 2.4),

No, the comment is correct, it really doesn't work with 2.6 kernels,
because the driver design was slightly changed.

What is the problem exactly? Considering that 1* you most likely don't
have a PCF8591 and 2* the "missing" line has no effect by default, I
just don't get what you are worrying about.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
