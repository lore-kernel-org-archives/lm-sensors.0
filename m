From: lepalom@wol.es (Leopold Palomo Avellaneda)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: Problems patchkernel 2.4.22
Message-Id: <200309171230.43524.lepalom@wol.es>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309171142.05680.lepalom@wol.es>
In-Reply-To: <200309171142.05680.lepalom@wol.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Bon jour,

first of all, merci!

A Dimecres 17 Setembre 2003 12:05, Jean Delvare va escriure:
> > Dear The Lm Sensors Group,
> >
> > I hope I write to the correct address.
>
> Yes, you are :)

ok, greats. 

> > I have read the http://delvare.free.fr/i2c/ page about the
> > installation of I2C and LM Sensors 2.8.0 in a kernel 2.4.22.
> >
> > I think that I'm doing something wrong but I'm a bit lost. I have
> > download a vanilla kernel (2.4.22) and I have patched with your patch as
> > you can see below, but I have found some errors and I don't know if they
> > are important or no.
>
> Answer below.
>
> > Also, I would like to ask if you know if I2C is compatible with OpenMosix
> > and RT-Linux.
>
> No idea. I don't think that any effort has been made in either direction,
> but that doesn't mean that it won't work ;) If you have any experience,
> success or failure, please let us know.

I will test it in a beowulf with openmosix. Our cluster have lmsensors to 
check the T? and the fan rpm. Now I want to test OpenMosix, and I want also 
to update the kernel, so I will see. Don't worry, if you want I will inform 
you about my experience.

About Rt-linux, well, I will test it in another moment, so I will inform.

>
> > e01:/usr/src/linux-vanilla/linux-2.4.22# cat
> > /usr/src/linux-2.4.22-i2c-2.8.0.patch | patch -Np1
> > patching file drivers/acorn/char/i2c.c
> > patching file drivers/acorn/char/pcf8583.c
> > patching file drivers/i2c/Config.in
> > patching file drivers/i2c/Makefile
> > patching file Documentation/i2c/dev-interface
> > patching file Documentation/i2c/i2c-pport
> > patch unexpectedly ends in middle of line
> > patch: **** unexpected end of file in patch
>
> I have been having difficulties updating the files on the free.fr server,
> and this one is obviously truncated. The FTP transfers are aborted after a
> few dozen kilobytes. I plan to move the files to another server, but until
> this is possible, we just have to do with what we have.
>
> You should be able to get the files from the primary server, here:
> http://www.ensicaen.ismra.fr/~delvare/devel/i2c/
>
> They are known to be OK, as long as the webserver itself is responsive.
>
> Let us know how it goes.

Ok, the patch work's Ok. 

Merci again,


Best regards,

Leo

