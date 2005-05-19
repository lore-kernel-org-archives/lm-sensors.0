From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <8YhHcdU0.1111484605.1708350.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Andrew,

> > >>EIP; c02f094f <i2c_detect+f/500>   <==> >
> > >>ebx; f7c076fc <pg0+376a46fc/3fa9b400>
> > >>edx; f7c07558 <pg0+376a4558/3fa9b400>
> > >>esi; c047c8e0 <eeprom_driver+0/e0>
> >
> > Trace; c0104d7f <show_stack+7f/a0>
> > Trace; c0104f1a <show_registers+15a/1c0>
> > Trace; c0105184 <die+164/2e0>
> > Trace; c0119936 <do_page_fault+356/68d>
> > Trace; c0104853 <error_code+4f/54>
> > Trace; c02f1aa1 <eeprom_attach_adapter+21/30>
> > Trace; c02ee704 <i2c_add_driver+b4/e0>
> > Trace; c050a652 <eeprom_init+12/40>
> > Trace; c04ee8ab <do_initcalls+2b/c0>
> > Trace; c0100302 <init+32/130>
> > Trace; c0101351 <kernel_thread_helper+5/14>
>
> Ah.  adapter->algo is NULL in i2c_detect().

Forgive a possibly stupid question, but how did you manage to come to
this conclusion from the stack above alone? Is there any magic I am not
aware of?

My first impression was that the adapter itself was missing, like it had
been deleted without being removed from the main i2c adapters list.

Anyway, this test at leasted proved one thing: the i2c-dev driver isn't
involved in the oops per se. Using a different i2c chip driver (eeprom
here) triggers it as well. This tends to confirm that the problem is
related to a specific i2c adapter driver.

> I don't think i2c_adapters are allowed to do that.

Correct, they are not.

> It could have been any old adapter, registered at some earlier time.

Except that we have a strong suspicion that it is nvidiafb, instead of
just any old adapter.

> If I'm right, this debug patch should point us at the culprit.

I doubt it will help (but let's still try). The nvidiafb i2c adapters
are added by i2c-algo-bit:i2c_bit_add_bus(), which does set
adapter->algo to &i2c_bit_algo right before it calls i2c_add_adapter. I
don't think that algo is NULL when the adapter is added. Rather, it
becomes NULL later, most possibly because adapter itself point to a now
gone structure. Just my theory though.

Maybe it would help if Miles could give a try to Tony's patch here and
report?
http://archives.andrew.net.au/lm-sensors/msg30044.html

Thanks,
--
Jean Delvare
