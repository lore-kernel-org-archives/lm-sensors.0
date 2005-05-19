From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: Adm1030 driver
Message-Id: <20040327142947.44450c1b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
In-Reply-To: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Sure. The current version, which is quite limited, can be found at 
> http://cedric.pradalier.free.fr/ibook2/index.html
> I have the docs, so I'll be able to add functionalities if needed.

Mmm, as I read it, it doesn't belong to our i2c subsystem (well, it
makes use of it but is really different from the hardware monitoring
drivers we have). Usually our drivers are passive and simply export
their registers, with some conversions, to sysfs. Any active behavior
either belongs to the hardware, or to the userspace, but not to the
driver, as you have done if I'm not mistaking.

So to make it short, I don't think I'm qualified to review your code.

> > Make sure
> > you follow the sysfs naming conventions as found in
> > Documentation/i2c/sysfs-interface of the same Linux tree.
> 
> I'm sure I don't ! But since someone is interested, I'll try to adapt.

Oh well, this doesn't apply then. The sysfs interface is meant for our
driver design, and obviously doesn't apply to yours at the moment.
Unless you want to rewrite a driver that fits into our architecture.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
