From: king.br@gmail.com (Brett King)
Date: Wed, 07 Feb 2007 08:05:23 +0000
Subject: [lm-sensors] Difficulty with ASUS P5B W83627DHG - Error
Message-Id: <8cf253380702070005w3cd4136bo6944ce711973612d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <8cf253380702050304p6b41c9ccs2427b58830a2f613@mail.gmail.com>
In-Reply-To: <8cf253380702050304p6b41c9ccs2427b58830a2f613@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for the tip, makes sense.
The diff output is a bit intimidating however, could someone do me a
huge favour & email / attach the patched driver (w83627ehf.c.txt)
mentioned in the archive URL ? I can't seem to find it .. cheers.

On 2/6/07, David Holl <david at ad5ey.net> wrote:
> Did you patch your kernel?  (2.6.18 does not support W83627DHG by default.)
>
> Try the patch here:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-December/018519.html
>
> - David
>
>
> On 2/5/07, Brett King <king.br at gmail.com> wrote:
> >
> > Hi,
> > I've read all documentation, FAQ, wiki & archived mailing list posts
> > since Dec 2006 plus google'd extensively but still I cannot find any
> > way to get lm-sensors to work on this board, so I'm coming to the
> > mailing list or help.
> >
> > I'm running openSUSE 10.2, kernel 2.6.18.2-34-default, x86_64.
> >
> > I have sysfs as recommended for 2.10.2:
> >
> > # rpm -qav *sysfs*
> > sysfsutils-2.1.0-19
> > #
> >
> > # sensors --v
> > sensors version 2.10.2 with libsensors version 2.10.2
> > #
> >
> > After a make user, su, make user_install then sensors-detect I get the
> > following:
> >
> > ...
> > Driver `w83627ehf' (should be inserted):
> >   Detects correctly:
> >   * ISA bus address 0x0290 (Busdriver `i2c-isa')
> >     Chip `Winbond W83627DHG Super IO Sensors' (confidence: 9)
> > ...
> >
> > But when I attempt to modprobe w83627ehf:
> >
> > # modprobe w83627ehf
> > FATAL: Error inserting w83627ehf
> >
> (/lib/modules/2.6.18.2-34-default/kernel/drivers/hwmon/w83627ehf.ko):
> > No such device
> > #
> >
> > Does this driver really support the DHG chip ? I would have thought a
> > file named 'w83627dhg.ko' would have perhaps come with lm_sensors
> > 2.10.2 to copy into the kernel source tree ?
> >
> > Any ideas ? Again apologies if I'm asking a simple question however I
> > just can't seem to get it working or find an answer to this problem ..
> > thanks.
> >
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors at lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> >
>
>

