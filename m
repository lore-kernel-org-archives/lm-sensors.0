From: Markus Fischer <markus@fischer.name>
Date: Tue, 15 Jun 2010 13:55:13 +0000
Subject: [lm-sensors] Getting sensor information from HP ProLiant DL360
Message-Id: <4C178641.2050903@fischer.name>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010107030208060406000000"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------010107030208060406000000
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hi,

our new machine arrived today and I'd like to get as much information=20
out of it as possible. I'm using Debian Lenny with a=20
2.6.26-2-vserver-amd64 kernel, arch is x86_64 .

I've installed lm-sensors (sensors --version reports sensors version=20
3.0.2 with libsensors version 3.0.2 , package is 1:3.0.2-1+b2 ) and ran=20
"sensors-detect"; attached is the output.

"sensors" only reports one information for me:

$ sudo sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:        +8.3=B0C  (crit =3D +31.3=B0C)

I'm missing other temps, fans, CPU, etc. and I'm wondering how I could=20
improve the situtation; I couldn't find out much what the current status=20
of lm-sensors support for my machine is. I looked at=20
http://lm-sensors.org/wiki/Devices and only found one reference to HP=20
stating:

"
   SMSC 	 SCH4307 	 yes 	 	 	 	 (2010-02-11) Super I/O with hardware=20
monitoring capabilities. Used in HP servers. Datasheets only available=20
under NDA, no driver yet."

I guess it applies to me, but I'm not sure?

"sensors" suggests to load the module "ipmisensors", I search turned up=20
http://bmcsensors-26.sourceforge.net/ for the 2.6 kernels. However, the=20
patch available from=20
https://sourceforge.net/project/showfiles.php?group_id=3D114509&package_id=
=3D199597=20
(link for ">=3D2.6.17" kernels) does not apply, and the other link=20
"impisensors-experimental" to=20
http://bmcsensors-26.sourceforge.net/ipmisensors/ doesn't work.

Are there any other options?

thanks,
- Markus

--------------010107030208060406000000
Content-Type: text/plain;
 name="sensors-detect.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sensors-detect.txt"

mate-vServer01:~# sensors-detect
# sensors-detect revision 5249 (2008-05-11 22:56:25 +0200)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Sorry, no supported PCI bus adapters found.

If you have undetectable or unsupported I2C/SMBus adapters, you can have
them scanned by manually loading the modules before running this script.

To continue, we need module `i2c-dev' to be loaded.
Do you want to load `i2c-dev' now? (YES/no):
Module loaded successfully.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `IPMI BMC KCS' at 0xca0...                      Success!
    (confidence 4, driver `ipmisensors')
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found `SMSC SCH4307 Super IO Fan Sensors'                   Success!
    (address 0x300, driver `to-be-written')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some south bridges, CPUs or memory controllers may also contain
embedded sensors. Do you want to scan for them? (YES/no):
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `ipmisensors' (should be inserted):
  Detects correctly:
  * ISA bus, address 0xca0
    Chip `IPMI BMC KCS' (confidence: 4)

Driver `to-be-written' (should be inserted):
  Detects correctly:
  * ISA bus, address 0x300
    Chip `SMSC SCH4307 Super IO Fan Sensors' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:

To load everything that is needed, add this to /etc/modules:

#----cut here----
# You must also install and load the IPMI modules
ipmi-si
# Chip drivers
# Warning: the required module ipmisensors is not currently installed
# on your system. For status of 2.6 kernel ports check
# http://www.lm-sensors.org/wiki/Devices. If driver is built
# into the kernel, or unavailable, comment out the following line.
ipmisensors
# no driver for SMSC SCH4307 Super IO Fan Sensors yet
#----cut here----

Do you want to add these lines automatically? (yes/NO)


--------------010107030208060406000000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------010107030208060406000000--

