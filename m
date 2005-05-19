From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: i2c for 2.6.0-test11
Message-Id: <20031201222104.1c36d298.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1070258710.3218.9.camel@phoebus>
In-Reply-To: <1070258710.3218.9.camel@phoebus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Well, the lm80 driver hasn't been ported to Linux 2.6 yet, so you'll
> > have to wait. If you are brave, you can port it yourself. I wrote a
> > guide on how to do this, which should be part of Linux 2.6
> > Documentation/i2c directory someday (but isn't yet either). I can
> > send it to you if you want.
> 
> thanks i ll consider about doing it

You can get the documentation there:
http://www.ensicaen.ismra.fr/~delvare/devel/i2c/linux-2.6/linux-2.6.0-test9-i2c-doc-porting-clients.diff
Additionally, you should get these two patches:
http://www.ensicaen.ismra.fr/~delvare/devel/i2c/linux-2.6/linux-2.6.0-test9-i2c-doc-sysfs-interface.diff
http://www.ensicaen.ismra.fr/~delvare/devel/i2c/linux-2.6/linux-2.6.0-test9-i2c-doc-writing-clients.diff

These are patches for the latest 2.6.0-test kernels. Apply them and
you'll have up-to-date docs to work with.

Porting drivers isn't really hard, although it helps a lot if you have
already written such a driver. Feel free to ask questions here.

> > As for the via686a, it has been reported that it has to be loaded
> > before other i2c drivers, or it fails detecting devices. I've
> > experienced this myself. I've not yet investigated why it behaves
> > that way (mainly because the via686a chipset I have isn't wired for
> > proper input measurements). Again, feel free to help if you can, or
> > you'll have to wait until we find a solution.
> 
> Do i understand correctly that i need to compile all that i2c stuff in
> modules and load via686a module first - that will help?

Yes, this is what I suggested.

> And is that true that i need either lm80 working either via686a? I
> need either ISA either SMbus sensors, or there will be some
> difference.

You probably need only one of them, but having both drivers installed at
the same time won't hurt at all. If I were you, I'd first try to have
the via686a driver to work. If it doesn't provide useful values, this
means that it isn't used, and you'll need the lm80 driver.

Final note, the LM80 chipset is rather hard to detect, so it is possible
that your second chipset isn't a LM80 after all. If you can try Linux
2.4 + i2c patch 2.8.1 + lm_sensors CVS on the same machine, you'd at
least know which driver you really need.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
