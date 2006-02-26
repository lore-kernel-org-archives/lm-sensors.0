From: wipwap19@hotmail.com (Warren Wilder)
Date: Sun, 26 Feb 2006 11:12:57 +0000
Subject: [lm-sensors] Can't access procfs/sysfs file - 2.6.14.6
Message-Id: <BAY115-F3564B5DE03D3DA0134F7AFCFF10@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Allright, here is some more info:

first, the link between  libsensors and sysfs is there:

root:~# ldd /usr/local/bin/sensors
        libsensors.so.3 =3D> /usr/local/lib/libsensors.so.3 (0x010f1000)
        libc.so.6 =3D> /lib/libc.so.6 (0x0111c000)
        libm.so.6 =3D> /lib/libm.so.6 (0x01249000)
        libsysfs.so.2 =3D> /usr/lib/libsysfs.so.2 (0x0126e000)
        /lib/ld-linux.so.2 (0x010d9000)

/*************/

next, the entire sensors-detect output (which mentions module eeprom)

# sensors-detect revision 1.413 (2006/01/19 20:28:00)

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the default answers to all
questions, unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
You do not need any special privileges for this.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:11.0: VIA Technologies VT8237 South=20
BridgeProbe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-viapro' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

To continue, we need module `i2c-dev' to be loaded.
If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

We are now going to do the adapter probings. Some adapters may hang halfway
through; we can't really help that. Also, some chips will be double=20
detected;
we choose the one with the highest confidence value in that case.
If you found that the adapter hung after probing a certain address, you can
specify that address to remain unprobed. That often
includes address 0x69 (clock chip).

Next adapter: SMBus Via Pro adapter at 0500
Do you want to scan it? (YES/no/selectively):
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x69

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): no

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no): no

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 0500'
    Busdriver `i2c-viapro', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)


I will now generate the commands needed to load the I2C modules.

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-viapro
# I2C chip drivers
# Warning: the required module eeprom is not currently installed on your=20
system.# For status of 2.6 kernel ports see=20
http://secure.netroedge.com/~lm78/supported.html
# If driver is built-in to the kernel, or unavailable, comment out the=20
following line.
modprobe eeprom
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

/************************/

The modules that are loaded on my system (before the script is run).

Module                  Size  Used by
smbfs                  52305  2
via_rhine              15549  0
mii                     3352  1 via_rhine
snd_via82xx            16120  0
snd_ac97_codec         75880  1 snd_via82xx
snd_ac97_bus            1084  1 snd_ac97_codec
snd_mpu401_uart         3880  1 snd_via82xx
snd_rawmidi            14296  1 snd_mpu401_uart
snd_seq_device          4204  1 snd_rawmidi
i2c_viapro              4575  0
ehci_hcd               25345  0
uhci_hcd               25508  0
usbcore                83903  3 ehci_hcd,uhci_hcd
ohci1394               26836  0
ieee1394               63968  1 ohci1394
via_agp                 4674  1
i2c_dev                 5637  0
i2c_core               11632  2 i2c_viapro,i2c_dev
snd_pcm_oss            40422  0
snd_pcm                62008  3 snd_via82xx,snd_ac97_codec,snd_pcm_oss
snd_timer              16212  1 snd_pcm
snd_page_alloc          5660  2 snd_via82xx,snd_pcm
snd_mixer_oss          13620  1 snd_pcm_oss
snd                    33336  9=20
snd_via82xx,snd_ac97_codec,snd_mpu401_uart,snd_rawmidi,snd_seq_device,snd_p=
cm_oss,snd_pcm,snd_timer,snd_mixer_oss
soundcore               4459  1 snd

/*****************/

The modules compiled 'into' my kernel.

CONFIG_I2C=3Dm
CONFIG_I2C_CHARDEV=3Dm
CONFIG_I2C_ALGOBIT=3Dm
CONFIG_I2C_ALGOPCF=3Dm
CONFIG_I2C_ALGOPCA=3Dm
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_ELEKTOR is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
CONFIG_I2C_VIAPRO=3Dm
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

/****************/

Sysfs is compiled in, but also being used:

/dev/hda2 on / type ext3 (rw)
proc on /proc type proc (rw,noexec,nosuid,nodev)
sysfs on /sys type sysfs (rw,noexec,nosuid)
devpts on /dev/pts type devpts (rw,nosuid,gid=3D4,modeb0)
shm on /dev/shm type tmpfs (rw,nosuid,nodev)
usbfs on /proc/bus/usb type usbfs (rw)

/*********/

I think the VT1211 chip is not being detected, since the vt1211 is not bein=
g=20
suggested. At least, that is the module I need according to this line on=20
your website:

Manufacturer  	Chip  	    Detected  	Driver       Initial Support  	Status,=
=20
Comments
                                                                  =20
(lm-sensors)
VIA  	            VT1211  yes  	    vt1211  	2.6.4  	 	    (2005-05-18)=20
Integrated sensors.
                                                                           =
 =20
               Port to Linux 2.6 in progress by Lars Ekman.

I know I am not scanning the ISA bus and superio? channel in the above=20
sensors-detect output, but  my kernel does not allow that. I have turned th=
e=20
Grsec options off, but there wasn't anything else found. If needed, I can=20
turn the Grsec options off again to really check. (Will take a while)
If you need some more info to help me diagnose this, let me now.

Thanks, Warren

>From: "Mark M. Hoffman" <mhoffman at lightlink.com>
>To: Warren Wilder <wipwap19 at hotmail.com>
>CC: lm-sensors at lm-sensors.org
>Subject: Re: [lm-sensors] Can't access procfs/sysfs file  - 2.6.14.6
>Date: Sat, 25 Feb 2006 10:38:35 -0500
>
>Hi Warren:
>
>* Warren Wilder <wipwap19 at hotmail.com> [2006-02-24 19:51:45 +0000]:
> > I have noticed others had this problem, but it turned out to be some
> > configuration issue. Hopefully this is the case for me as well. I am
> > slightly worried that I have to wait for the 'eeprom' module, which my =

>Via
> > VT1211 chip seems to need.
>
>That doesn't make sense: no sensors/hwmon chip needs the eeprom module.
>
> > My system:  (Via SP13000)
> > HLFS (Hardened Linux From Scratch) with kernel 2.6.14.6
> > sysfs compiled and mounted
> >
> > running sensors-detect notifies me of these required modules:
> > i2c-viapro
> > i2c-dev
> > I can succesfully load both.
>
>So, sensors-detect doesn't find vt1211?  Can we see the full output?
>
> > When I run sensors I get this notice:
> > Can't access procfs/sysfs file
> > Unable to find i2c bus information;
> > For 2.6 kernels, make sure you have mounted sysfs and libsensors
> > was compiled with sysfs support!
> > For older kernels, make sure you have done 'modprobe i2c-proc'!
>
>What modules are loaded and/or builtin when you run sensors?
>
> > The thing is, I haven't build libsensors with sysfs support, since the
> > INSTALL and QUICKSTART files inform me of not having to do anything,
> > besides 'make user and make user_install' if I have a 2.6 kernel with=20
>i2c
> > modules compiled.
> > Since I also have udev on my system I am leaning towards missing some=20
>sort
> > of udev rule.
>
>If you were running a 2.6.x kernel when you built libsensors, then it=20
>almost
>certainly did the right thing.  You can run 'ldd `which sensors`' to be=20
>sure.
>
> > Please inform me of the next step.
>
>Reply-to-all with the requested info.  Thanks.
>
>Regards,
>
>--
>Mark M. Hoffman
>mhoffman at lightlink.com
>

_________________________________________________________________
Don=92t just search. Find. Check out the new MSN Search!=20
http://search.msn.click-url.com/go/onm00200636ave/direct/01/


