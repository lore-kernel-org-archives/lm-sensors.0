From: warp-9.9@usa.net (Leif W)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Support DB Entry 1770
Message-Id: <001501c49836$b56186a0$0a01a8c0@enterprise>
List-Id: <lm-sensors.vger.kernel.org>
References: <007201c49733$ef934970$0a01a8c0@enterprise>
In-Reply-To: <007201c49733$ef934970$0a01a8c0@enterprise>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> ----- Original Message -----=20
> From: "Leif W" <warp-9.9@usa.net>
> To: "LM Sensors" <sensors@stimpy.netroedge.com>
> Sent: Saturday, September 11, 2004 14:05
> Subject: Re: Support DB Entry 1770
>
> > ----- Original Message -----=20
> > From: "Jean Delvare" <khali@linux-fr.org>
> > To: "Leif W" <warp-9.9@usa.net>
> > Cc: <sensors@Stimpy.netroedge.com>
> > Sent: Saturday, September 11, 2004 03:18
> > Subject: Re: Support DB Entry 1770
> >
> > Alternatively, you can try to load the w83781d module with the
> > "force=9191,0x290" parameter and see how it goes. This should skip
all
> > the detection steps.
>
> Tried  this, "sensors" still says "No sensors found!"  First two
syslog
> lines are same as above, minus the third "failed" line.
> "sensors-detect" still detects the chip.  Have been applying these two
> patches to a kernel configured with no PM whatsoever, no ACPI, ISA PnP
> disabled in the kernel.
>
> Leif

Got it working with "modprobe w83781d force_w83781d=9191,0x290".  I
guess the "force" alone tried something different.  Not sure if this
problem is solvable.  If it is, great.  If not, the workaround as
explained in the docs could be further elaborated.

It's mentioned in the docs (
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/chips/w83781d ) that
the chip gets misidentified.  However my chip was detected, is that the
same as identified?  Also, the docs says:

    (modprobe w83781d force_CHIP=3DBUS,0x2d where CHIP is the chip name
    and BUS is your i2c bus number -
    cat /proc/bus/i2c to see a list of bus numbers)

But I have no /proc/bus/i2c (file or directory).  I can't find the
corresponding data in /sys , either because I don't know where to look,
or it's just not there.  I suggest an update to add a note explaining
how to get the right bus number in kernel 2.4 and 2.6.  Additionally
make a clearer distinction between ISA bus/address and I2C bus/address
and list typical numbers for this device: ISA bus 9191 / address 0x290
and I2C bus 0 or 1 / address 0x2d.  Also helpful would be both the
modprobe syntax (as shown) and the modules.conf syntax.

# Mail client won't let me enter tabs.

<DOC_begin>

W8378* PROBLEMS
-----------------
Known problems:
        - Some chips are misidentified even if successfully detected.
          This is caused by the chip having the wrong WCHIPID register
          value, so there is no fix. The workaround is to use the
          force_CHIP parameter.

    modprobe format:

        modprobe w83781d force_CHIP=3DBUS,ADDR

    modules.conf format:

        options w83781d force_CHIP=3DBUS,ADDR

    Example values, comma separated, use only one, use only ISA or I2C:

        CHIP    : w83781d
        I2C BUS : 0, 1
        I2C ADDR: 0x2d
        ISA BUS : 9191
        ISA ADDR: 0x290

    Find your specific bus:

        kernel 2.4 I2C: cat /proc/bus/i2c
        kernel 2.4 ISA: ???
        kernel 2.6 I2C: ???
        kernel 2.6 ISA: ???

    Find your specific address:

        kernel 2.4 I2C: ???
        kernel 2.4 ISA: ???
        kernel 2.6 I2C: ???
        kernel 2.6 ISA: ???

    See "Addresses scanned" sections under "Supported chips" above.

</DOC_end>


