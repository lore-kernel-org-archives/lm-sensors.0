From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: Fw: LM sensors and 2.6 kernel...
Message-Id: <3FBFDEC4.D1426D19@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <hon77s.9lxgxu@webmail.batcom-it.net>
In-Reply-To: <hon77s.9lxgxu@webmail.batcom-it.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks for testing.
You are correct, sensors-detect hasn't been ported yet.
In the meantime you may wish to try modprobing every driver
in drivers/i2c/chips, maybe you'll get lucky.


"R. Reucher" wrote:
> 
> Hi Mark!
> 
> Hmm, my answer to the sensors-list (sensors@stimpy.netroedge.com) was rejected
> (but worked before)... so I'll forward the message directly to you. Hope this
> is okay.
> 
> "R. Reucher" <rene.reucher@batcom-it.net> wrote:
> 
> > Mark Studebaker <mds@paradyne.com> wrote:
> >
> > > I've checked in a Makefile fix.
> > > you may also be able to build by using 'make -k user' to skip the
> > > dependency build errors.
> > Thanks! This one works great, at least I can compile and install the
> userland
> > tools now... and after mounting the sysfs (which I "forgot" before :) I was
> > even able to basically use lm_sensors2 (/usr/local/bin/sensors).
> >
> > But it can't find sensor devices yet... and so I tried
> > /usr/local/sbin/sensors-detect, but it fails at some point, because it
> > apparently still expects /proc/bus/i2c:
> >
> > votan:~ # /usr/local/sbin/sensors-detect
> >
> > This program will help you determine which I2C/SMBus modules you need to
> > load to use lm_sensors most effectively. You need to have i2c and
> > lm_sensors installed before running this program.
> > Also, you need to be `root', or at least have access to the /dev/i2c-*
> > files, for most things.
> > If you have patched your kernel and have some drivers built in, you can
> > safely answer NO if asked to load some modules. In this case, things may
> > seem a bit confusing, but they will still work.
> >
> >  BIOS vendor (ACPI): PTLTD
> >  System vendor (DMI): TYAN
> >  We can start with probing for (PCI) I2C or SMBus adapters.
> >  You do not need any special privileges for this.
> >  Do you want to probe now? (YES/no):
> > Probing for PCI bus adapters...
> > Use driver `i2c-amd756' for device 00:07.3: AMD-768 System Management
> > Probe succesfully concluded.
> >
> >  We will now try to load each adapter module in turn.
> > Load `i2c-amd756' (say NO if built into your kernel)? (YES/no):
> > Module loaded succesfully.
> >  Do you now want to be prompted for non-detectable adapters? (yes/NO):
> >  To continue, we need module `i2c-dev' to be loaded.
> >  If it is built-in into your kernel, you can safely skip this.
> >  i2c-dev is not loaded. Do you want to load it now? (YES/no):
> >  Module loaded succesfully.
> >
> >  We are now going to do the adapter probings. Some adapters may hang halfway
> >  through; we can't really help that. Also, some chips will be double
> detected;
> >  we choose the one with the highest confidence value in that case.
> >  If you found that the adapter hung after probing a certain address, you can
> >  specify that address to remain unprobed. That often
> >  includes address 0x69 (clock chip).
> > Couldn't open /proc/bus/i2c?!? at /usr/local/sbin/sensors-detect line 4184,
> > <STDIN> line 4.
> >
> > Well, seem's that some more porting effort to sysfs has to be done next :)!
> >
> > Loaded i2c modules up to this point and other information of possible
> > interest:
> >
> > votan:~ # lsmod | grep i2c
> > i2c_dev                10304  0
> > i2c_amd756              6852  0
> > i2c_core               23176  2 i2c_dev,i2c_amd756
> >
> > votan:~ # mount | grep sysfs
> > none on /sys type sysfs (rw)
> >
> > votan:~ # ls -alR /sys/class/i2c-*
> > /sys/class/i2c-adapter:
> > total 0
> > drwxr-xr-x    3 root     root            0 Nov 22 13:16 ./
> > drwxr-xr-x   11 root     root            0 Nov 22  2003 ../
> > drwxr-xr-x    2 root     root            0 Nov 22 13:16 i2c-0/
> >
> > /sys/class/i2c-adapter/i2c-0:
> > total 0
> > drwxr-xr-x    2 root     root            0 Nov 22 13:16 ./
> > drwxr-xr-x    3 root     root            0 Nov 22 13:16 ../
> > lrwxrwxrwx    1 root     root           46 Nov 22 13:16 device ->
> > ../../../devices/pci0000:00/0000:00:07.3/i2c-0/
> > lrwxrwxrwx    1 root     root           36 Nov 22 13:16 driver ->
> > ../../../bus/i2c/drivers/i2c_adapter/
> >
> > /sys/class/i2c-dev:
> > total 0
> > drwxr-xr-x    3 root     root            0 Nov 22 13:16 ./
> > drwxr-xr-x   11 root     root            0 Nov 22  2003 ../
> > drwxr-xr-x    2 root     root            0 Nov 22 13:16 i2c-0/
> >
> > /sys/class/i2c-dev/i2c-0:
> > total 0
> > drwxr-xr-x    2 root     root            0 Nov 22 13:16 ./
> > drwxr-xr-x    3 root     root            0 Nov 22 13:16 ../
> > -r--r--r--    1 root     root         4096 Nov 22 13:16 dev
> > lrwxrwxrwx    1 root     root           40 Nov 22 13:16 device ->
> > ../../../devices/pci0000:00/0000:00:07.3/
> > lrwxrwxrwx    1 root     root           37 Nov 22 13:16 driver ->
> > ../../../bus/pci/drivers/amd75x smbus/
> >
> > Let me know if you need more info!
> >
> > Regards and thanks for efforts,
> >
> > Rene
> > --
> > Ren? Reucher
> > BATCOM IT Services
> >
> > Tel: +49 160 94957806
> > FAX: +49 6359 205423
> > rene.reucher@batcom-it.net
> > http://www.batcom-it.net/
> > _____________________________________
> > V-webmail - http://www.v-webmail.org/
> >
> >
> 
> --
> Ren? Reucher
> BATCOM IT Services
> 
> Tel: +49 160 94957806
> FAX: +49 6359 205423
> rene.reucher@batcom-it.net
> http://www.batcom-it.net/
> _____________________________________
> V-webmail - http://www.v-webmail.org/
