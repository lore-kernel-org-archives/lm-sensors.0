From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 21 Feb 2006 08:50:20 +0000
Subject: [lm-sensors] Ticket
Message-Id: <sEqILkw0.1140511820.6712780.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <2dedd0680602192048m4639ac6awb9a720207a9d3de1@mail.gmail.com>
In-Reply-To: <2dedd0680602192048m4639ac6awb9a720207a9d3de1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Istvan,

Please answer to the list rather than to me only.

On 2006-02-21, Kis Istvan Csaba wrote:
> [root at cl-86-125-141-8 ~]# sensors -v
> sensors version 2.10.0 with libsensors version 2.10.0

OK so "sensors" links with the right library.

> Boot log:
>
> Feb 21 08:23:26 cl-86-125-141-8 lm_sensors: Starting lm_sensors: loading
> module
> Feb 21 08:23:26 cl-86-125-141-8 lm_sensors: i2c-viapro
> Feb 21 08:23:26 cl-86-125-141-8 lm_sensors: i2c-isa
> Feb 21 08:23:26 cl-86-125-141-8 lm_sensors: eeprom
> Feb 21 08:23:26 cl-86-125-141-8 lm_sensors: it87
> Feb 21 08:23:27 cl-86-125-141-8 lm_sensors: Can't access procfs/sysfs file
> Feb 21 08:23:27 cl-86-125-141-8 lm_sensors:
> Feb 21 08:23:27 cl-86-125-141-8 lm_sensors: Unable to find i2c bus
> information;
> Feb 21 08:23:27 cl-86-125-141-8 lm_sensors: For 2.6 kernels, make sure you
> have mounted sysfs and libsensors
> Feb 21 08:23:27 cl-86-125-141-8 lm_sensors: was compiled with sysfs
> support!
> Feb 21 08:23:27 cl-86-125-141-8 lm_sensors: For older kernels, make sure
> you
> have done 'modprobe i2c-proc'!
> Feb 21 08:23:27 cl-86-125-141-8 rc: Starting lm_sensors:  failed

This is a user-space log. What I was interested was the kernel log (as
displayed by dmesg and often available as /var/log/syslog too). But the
other tests below should be sufficient for now.

> [root at cl-86-125-141-8 ~]# ls -l /sys/bus/i2c/*
> /sys/bus/i2c/devices:
> total 0
> lrwxrwxrwx  1 root root 0 Feb 21 08:32 0-0050 ->
> ../../../devices/pci0000:00/0000:00:11.0/i2c-0/0-0050
> lrwxrwxrwx  1 root root 0 Feb 21 08:32 1-0290 ->
> ../../../devices/platform/i2c-1/1-0290

Two devices found, one EEPROM and one IT87xxF chip. So the drivers are
working properly.

> [root at cl-86-125-141-8 ~]# ls -l /sys/class/
> total 0
> drwxr-xr-x    2 root root 0 Feb 21 08:33 firmware
> drwxr-xr-x    2 root root 0 Feb 21  2006 graphics
> drwxr-xr-x    4 root root 0 Feb 21 08:23 i2c-adapter
> drwxr-xr-x    8 root root 0 Feb 21  2006 input
> drwxr-xr-x   10 root root 0 Feb 21  2006 mem
> drwxr-xr-x    6 root root 0 Feb 21 08:23 misc
> drwxr-xr-x    5 root root 0 Feb 21  2006 net
> drwxr-xr-x    4 root root 0 Feb 21  2006 pci_bus
> drwxr-xr-x    3 root root 0 Feb 21 08:23 printer
> drwxr-xr-x    2 root root 0 Feb 21  2006 scsi_device
> drwxr-xr-x    4 root root 0 Feb 21  2006 scsi_host
> drwxr-xr-x   12 root root 0 Feb 21  2006 sound
> drwxr-xr-x  145 root root 0 Feb 21  2006 tty
> drwxr-xr-x    2 root root 0 Feb 21  2006 usb
> drwxr-xr-x    7 root root 0 Feb 21  2006 usb_host
> drwxr-xr-x   18 root root 0 Feb 21 08:23 vc

No hwmon class, but on second thought this is expected: this class was
not yet introduced in kernel 2.6.12.

> [root at cl-86-125-141-8 eeprom]# ./decode-dimms.pl
>
> PC DIMM Serial Presence Detect Tester/Decoder
> By Philip Edelbrock, Christian Zuckschwerdt, Burkart Lingner,
> Jean Delvare and others
> Version 2.10.0
>
>
> Decoding EEPROM: /sys/bus/i2c/drivers/eeprom/0-0050
> Guessing DIMM is in                             bank 1
> (...)

This successful run proves that the i2c-viapro and eeprom drivers work
properly.

So everything seems to be working properly on the kernel side. This has
to be a user-space issue. How did you build lm_sensors? Manually or
kernel package? The error suggests that libsensors was built without
Linux 2.6 (sysfs) support. This would happen if it was built under a 2.4
kernel, or if you manually disabled sysfs support at built time. Do you
have libsysfs installed on your system? You need it.

Assuming that libsensors was installed under /usr/local/lib, please
provide the output of "ldd /usr/local/lib/libsensors.so". This will
tell us for sure if it was built with sysfs support or not.

--
Jean Delvare

