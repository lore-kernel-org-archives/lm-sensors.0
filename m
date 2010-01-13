From: Andre Prendel <andre.prendel@gmx.de>
Date: Wed, 13 Jan 2010 20:56:30 +0000
Subject: [lm-sensors] [RFC PATCH 0/1] Add the sensors-config tool
Message-Id: <20100113205443.GA1856@andre-laptop>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean, Hans,

a long time ago we've spoken about "DMI-based
configuration". Unfortunately the last half year I only had a very
reduced amount of time. But today I send my first proposal (patch) for
this issue :)

A few words...

The tool is written in Python. I hope you can live with
this although this is another language in the lm-sensors project. I like
the object oriented modules of Python and IMHO Python should be
installed on every machine in a default installation.

What can you do with this tool?

1. Download config files from lm-sensors.org and build an archive
2. Install this archive into the file system (the path is hard-coded
so far)
3. List the vendors off the available configs
4. List the board configs of a vendor
5. Install a config by vendor and board name
6. Show your systems' DMI data
7. Search a config based on the DMI data and install them
8. Remove the configs from the file system

NOTE: This is an early version. There are plenty of ToDos and probably
some bugs. This is a request for comments what do you thing about the
tool.

And now a short introduction.

To see a short help type

  ./sensors-config.py -h

Download and build archive
==============
1. First you have to create an directory for downloading.

  andre@andre-laptop:~/src/sensors/prog/detect$ mkdir configs

2. Change to this directory

  andre@andre-laptop:~/src/sensors/prog/detect$ cd configs/

3. Download the configs and build archive

  andre@andre-laptop:~/src/sensors/prog/detect/configs$ ../sensors-config.py -t
  Fetch config for Evga/x58-SLI
  Fetch config for ASRock/AM2NF3-VSTA
  Fetch config for Epox/M1697
  Fetch config for Epox/MF4-Ultra3
  Fetch config for Abit/AA8-DuraMAX
  Fetch config for Abit/AA8XE-Fatal1ty
  Fetch config for Abit/AI7
  Fetch config for Abit/AN7
  Fetch config for Abit/AN8-SLI
  Fetch config for Abit/AV8
  Fetch config for Abit/AX8
  Fetch config for Abit/Aa7-Max
  Fetch config for Abit/Ag7
  Fetch config for Abit/KN9-Ultra
  Fetch config for Abit/KV8-MAX3
  Fetch config for Abit/Kv8Pro
  Fetch config for Abit/VA-20
  Fetch config for DFI/CFX3200-M2-G-infinity
  Fetch config for DFI/Lanparty NF4 Expert
  Fetch config for DFI/Lanparty UT 790FX
  Fetch config for Asus/KFN4-DRE
  Fetch config for Asus/M2N-SLI Deluxe

The files are downloaded, some of unneeded "data" is stripped and an
tarball is build in the same directory.

  andre@andre-laptop:~/src/sensors/prog/detect/configs$ ls -l
  insgesamt 32
  drwxr-xr-x 2 andre andre 4096 2010-01-13 21:11 Abit
  drwxr-xr-x 2 andre andre 4096 2010-01-13 21:11 ASRock
  drwxr-xr-x 2 andre andre 4096 2010-01-13 21:11 Asus
  -rw-r--r-- 1 andre andre 5569 2010-01-13 21:11 configuration.tar.gz
  drwxr-xr-x 2 andre andre 4096 2010-01-13 21:11 DFI
  drwxr-xr-x 2 andre andre 4096 2010-01-13 21:11 Epox
  drwxr-xr-x 2 andre andre 4096 2010-01-13 21:11 Evga

This behaviour should be optimized. The directory should be created
automatically and the configs should be removed. At the moment only a
few configs are fetch from lm-sensors.org. Look at the configs hash in
the source code.


Install the configuration from the archive
=====================

  andre@andre-laptop:~/src/sensors/prog/detect/configs$ sudo \
  ../sensors-config.py -a configuration.tar.gz

This installs the configs to /usr/local/share/sensors/conf. So far the
path is hard-coded. This should be changed.

  andre@andre-laptop:~/src/sensors/prog/detect/configs$ ls -l \
  /usr/local/share/sensors/conf/
  insgesamt 24
  drwxr-xr-x 2 andre andre 4096 2010-01-13 21:11 Abit
  drwxr-xr-x 2 andre andre 4096 2010-01-13 21:11 ASRock
  drwxr-xr-x 2 andre andre 4096 2010-01-13 21:11 Asus
  drwxr-xr-x 2 andre andre 4096 2010-01-13 21:11 DFI
  drwxr-xr-x 2 andre andre 4096 2010-01-13 21:11 Epox
  drwxr-xr-x 2 andre andre 4096 2010-01-13 21:11 Evga


List the available configurations
================
To list all the vendors use -l option.

  andre@andre-laptop:~/src/sensors/prog/detect/configs$ \
  ../sensors-config.py -l
  ASRock
  Abit
  Asus
  DFI
  Epox
  Evga

To list the boards of a given vendor use -b option.

  andre@andre-laptop:~/src/sensors/prog/detect/configs$ \
  ../sensors-config.py -b Abit
  AA8-DuraMAX
  AA8XE-Fatal1ty
  AI7
  AN7
  AN8-SLI
  AV8
  AX8
  Aa7-Max
  Ag7
  KN9-Ultra
  KV8-MAX3
  Kv8Pro
  VA-20


Install a configuration
===========
You can manually install a configuration use -i option and an argument
in the format VENDOR/BOARD.

  andre@andre-laptop:~/src/sensors/prog/detect/configs$ sudo \
  ../sensors-config.py -i Abit/VA-20

This install the VA-20 config from Abit into /etc/sensors.d.

ATTENTION: This will overwrite all the existing configs in
/etc/sensors.d.

You can also install a config based on DMI data. To show your
systems' DMI data use -d.

  andre@andre-laptop:~/src/sensors/prog/detect/configs$
  ../sensors-config.py -d
  board_name: 8918DFG
  board_vendor: LENOVO
  board_version: Not Available
  chassis_type: 10
  product_name: 8918DFG
  product_version: ThinkPad R61
  sys_vendor: LENOVO

To search for a suitable config use -f. There are two options to find
a config although there is no one suitable for your DMI data. Use
option -V VENDOR and -B BOARD to overwrite the systems' DMI data. So
you can simulate another machine.

  andre@andre-laptop:~/src/sensors/prog/detect/configs$ sudo \
  ../sensors-config.py -f -V Abit -B VA-20
  Found a suitable configuration: Abit/VA-20
  Do you want to install this configuration? [y/N]: y
  This will delete older configurations. Do you want to proceed? [y/N]: y

Now the VA-20 config file should be installed in /etc/sensors.d.

Ok, that's for the moment. There are much work left. Have fun and I'de
be happy to hear from you.

Thanks,
Andre

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
