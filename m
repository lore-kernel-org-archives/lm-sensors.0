From: "Juerg Haefliger" <juergh@gmail.com>
Date: Fri, 24 Aug 2007 16:12:23 +0000
Subject: Re: [lm-sensors] AMD Geode LX(CS5536) - SMSC SCH3114 Temperature
Message-Id: <191fb4ca0708240912i17c8293dj2109e23729bf7d26@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY107-W421FB9A83ADA7ED4C6D32BAD60@phx.gbl>
In-Reply-To: <BAY107-W421FB9A83ADA7ED4C6D32BAD60@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Kushal,


>
>  > > Err no, you need 2.6.23. The dme1737 is not in 2.6.22.
>
> Thanks. I tried applying those patches to 2.6.23-rc3 but got errors.
>
> Ok, here is what I did. I first downloaded the stable kernel source 2.6.22
> and then I applied the patch         2.6.23-rc3 to get the kernel up to
> 2.6.23. After that I downloaded the 3 patches, which were in bin format and
> open it in a text editor and saved them text file with extension ".patch".
>
> I started applying patches and I got errors. Following is the output of what
> I did:
>
> *************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************
> debian:/usr/src/patches/geode_lx_hwmon# ls
> hwmon-dme1737-add-sch311x-support.patch
> hwmon-dme1737-cleanups.patch
> hwmon-dme1737-group-functions-logically.patch
>
> debian:/usr/src/linux-2.6.22# patch -p1 <../patches/patch-2.6.23-rc3
> ..................................................
> ..................................................
> patching file sound/usb/usbquirks.h
> patching file sound/usb/usx2y/usbusx2yaudio.c
> patching file usr/.gitignore
> patching file usr/gen_init_cpio.c
> debian:/usr/src/linux-2.6.22# cd ..
>
> debian:/usr/src# mv linux-2.6.22 linux-2.6.23
> debian:/usr/src# cd linux-2.6.23
>
> debian:/usr/src/linux-2.6.23# patch -p1
> <../patches/geode_lx_hwmon/hwmon-dme1737-cleanups.patch
> patching file drivers/hwmon/dme1737.c
> Hunk #17 FAILED at 1257.
> Hunk #33 FAILED at 1748.
> 2 out of 43 hunks FAILED -- saving rejects to file
> drivers/hwmon/dme1737.c.rej
>
> debian:/usr/src/linux-2.6.23# patch -p1
> <../patches/geode_lx_hwmon/hwmon-dme1737-group-functions-logically.patch
> patching file drivers/hwmon/dme1737.c
> Hunk #1 FAILED at 1697.
> Hunk #2 succeeded at 1831 (offset -89 lines).
> Hunk #3 succeeded at 2007 (offset -89 lines).
> 1 out of 3 hunks FAILED -- saving rejects to file
> drivers/hwmon/dme1737.c.rej
>
> debian:/usr/src/linux-2.6.23# patch -p1
> <../patches/geode_lx_hwmon/hwmon-dme1737-add-sch311x-support.patch
> patching file drivers/hwmon/dme1737.c
> Hunk #8 succeeded at 1790 with fuzz 1 (offset 49 lines).
> Hunk #9 succeeded at 1841 (offset -42 lines).
> Hunk #10 succeeded at 1889 (offset -42 lines).
> Hunk #11 succeeded at 2113 (offset -42 lines).
> patching file Documentation/hwmon/dme1737
> patching file drivers/hwmon/Kconfig
> Hunk #1 succeeded at 466 (offset 23 lines).
> debian:/usr/src/linux-2.6.23#
> ********************************************************************************************
>
> Can you please tell me the exact version of the kernel from kernel.org that
> I should use to apply those patches successfully?

The patches were generated against Linus' git tree but the dme1737 was
modified/cleaned up before it got merged. I need to regenerate the
patches.

In the meantime you could use the driver from
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020498.html

...juerg


> Thanks a lot once again.
>
> Kushal
>
>
>
>
> ________________________________
> Explore the seven wonders of the world Learn more!

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
