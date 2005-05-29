From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 29 May 2005 22:49:23 +0000
Subject: [lm-sensors] sensors-detect failed to see my SMbus
Message-Id: <429A2ABC.1040809@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> G'day gentlemen/women,

Hi John :)

> 
> please excuse any fumbling questions as I am new to Linux

It is OK to ask, but nexttime dont forget to include proper subject please :)

> sensors-detect failed to see my SMbus, I have a Dell Inspiron 8500
> laptop with an Intel 82801 DBM SMbus controller (ICH4-M)
> my question is do I use/will the i801 driver work? and what is the best
> way to get it to work?

Yes there are ways to do it but on notebooks the chips for temp monitoring are different.
So even if we forcibly enable it (this is somewhat bit dangerous) there will be no chip detected.

> would Ilja Rauhut's p4b hack do the trick?
For kernel 2.4.x perhaps yes.
For kernel 2.6.x you need to take a look to pci/quirks.c

If you want to know your CPU temo you can try to get it from ACPI.
Just issue command acpi -V and you should see something.

If you really want to enable the bus I would need to know what kernel version you have:
uname -a
and  output of:
lspci -n

But I can nearly guarantee there will be no sensor found.

Regards

Rudolf
