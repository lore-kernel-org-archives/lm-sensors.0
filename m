From: Scott Czepiel <sczepiel@gmail.com>
Date: Sun, 04 Sep 2011 23:25:49 +0000
Subject: Re: [lm-sensors] No sensors found on Asus P8H67-I Deluxe
Message-Id: <CA+bcNfKEJo9qK9-3p3m6e3yxj=2rZ58NJpcQtQqKDyfX0geEOg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Update:  issue resolved.

Thanks to the fine folks at the ElRepo project who backported coretemp
for use with CentOS 6, I am now able to successfully read the temp
sensor on my i3-2100.  Here is the request for enhancement:

http://elrepo.org/bugs/view.php?id=181

Also more detail on this thread at the CentOS forums:
https://www.centos.org/modules/newbb/viewtopic.php?topic_id3061&forumU

I also installed the backported w83627ehf driver from ElRepo which
worked with the Nuvoton chip on my Asus board after adding
"acpi_enforce_resources=3Dlax" to the kernel boot options in grub.conf.
I can now read the board's sensors on voltages, fan speeds, and temp
readings.

Long live ElRepo!

czep


On Sun, Aug 21, 2011 at 11:46 PM, Scott Czepiel <sczepiel@gmail.com> wrote:
> This is a newer mini-ITX LGA 1155 motherboard with an i3-2100 cpu
> attached, running CentOS 6 (kernel is based on 2.6.32). =A0I upgraded
> lm_sensors to the latest and greatest:
>
> # sensors -v
> sensors version 3.3.1 with libsensors version 3.3.1
>
> Abbreviated output of sensors-detect:
> -----
> # sensors-detect revision 5984 (2011-07-10 21:22:53 +0200)
> # System: System manufacturer System Product Name
> # Board: ASUSTeK Computer INC. P8H67-I DELUXE
> ...
> Driver `w83627ehf':
> =A0* ISA bus, address 0x290
> =A0 =A0Chip `Nuvoton NCT6776F Super IO Sensors' (confidence: 9)
>
> Driver `coretemp':
> =A0* Chip `Intel digital thermal sensor' (confidence: 9)
>
> Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):
> Starting lm_sensors: loading module coretemp w83627ehf No sensors found!
> Make sure you loaded all the kernel drivers you need.
> Try sensors-detect to find out which these are.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [FAILED]
> Unloading i2c-dev... OK
> -----
>
> Neither of the two suggested drivers will load:
>
> # modprobe coretemp
> FATAL: Error inserting coretemp
> (/lib/modules/2.6.32-71.29.1.el6.x86_64/kernel/drivers/hwmon/coretemp.ko):
> No such device
>
> # modprobe w83627ehf
> FATAL: Error inserting w83627ehf
> (/lib/modules/2.6.32-71.29.1.el6.x86_64/weak-updates/w83627ehf/w83627ehf.=
ko):
> Device or resource busy
>
> # tail /var/log/messages
> kernel: coretemp: Unknown CPU model 0x2a
> kernel: w83627ehf: Found NCT6776F chip at 0x290
> kernel: ACPI: I/O resource w83627ehf [0x295-0x296] conflicts with ACPI
> region HWRE [0x290-0x299]
> kernel: ACPI: If an ACPI driver is available for this device, you
> should use it instead of the native driver
>
> The version of coretemp for this kernel predates the Sandy Bridge
> procs so I tried compiling a recent revision (from the 3.0 kernel),
> but quickly left my comfort zone: =A0there were \ too many source
> changes, not just to coretemp.c but to other included header files,
> and I couldn't get the module with the newer coretemp.c to build on my
> older kernel source tree. =A0I could try compiling and running a more
> recent kernel, but this would defeat the purpose of using CentOS (and
> yes I realize I shouldn't always expect stable software to work with
> brand new hardware). =A0Is there anything else I can try besides waiting
> for CentOS to backport a more recent coretemp?
>
> Fortunately (or so I thought), I could skip coretemp and rely on the
> Nuvoton chip to work. =A0But I see it conflicts with ACPI and my kernel
> is just new enough that it will not allow the
> "acpi_enforce_resources=3Dlax" hack. =A0This led me to try:
>
> # modprobe asus_atk0110
>
> which apparently works:
>
> # lsmod|grep asus
> asus_atk0110 =A0 =A0 =A0 =A0 =A0 14470 =A00
> hwmon =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2464 =A01 asus_atk0110
>
> but has little effect since sensors won't pick it up:
>
> # sensors -s
> No sensors found!
> Make sure you loaded all the kernel drivers you need.
> Try sensors-detect to find out which these are.
>
> And there's nothing happening here where acpi drivers are supposed to
> do their thang:
>
> # ls -al /sys/class/hwmon/
> total 0
> drwxr-xr-x. =A02 root root 0 Aug 21 21:22 .
> drwxr-xr-x. 41 root root 0 Aug 21 23:02 ..
>
> I'm out of ideas for what to try next, any suggestions would be
> greatly appreciated!
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
