From: Kushal Koolwal <kushalkoolwal@hotmail.com>
Date: Thu, 23 Aug 2007 19:20:45 +0000
Subject: [lm-sensors] AMD Geode LX(CS5536) - SMSC SCH3114 Temperature mon.
Message-Id: <BAY107-W421FB9A83ADA7ED4C6D32BAD60@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="_31060bd9-904b-4322-84bf-a6c85068888f_"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--_31060bd9-904b-4322-84bf-a6c85068888f_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello,
I have a AMD Geode LX processor board (CS5536 companion chipset) with SMSC =
SCH3114 Super I/O Chip. I was looking to enable lm-sensors on it but did'nt=
 know where to start. I looked at the web page: http://www.lm-sensors.org/w=
iki/Devices and found two matching things:
***************************************************************************=
****************
AMD      Geode CS5535, CS5536    yes     scx200_acb      -       2.6.17    =
      Companion chips.
and
SMSC     SCH3112, SCH3114, SCH3116       yes  (2007-07-24) Updated dme1737 =
driver available: patch 1/3, patch 2/3, and patch 3/3.
***************************************************************************=
****************

Now I am not sure which device I should look for. I tried sensors-detect bu=
t it just ended loading eeprom module and said that it is not really a hard=
ware monitoring ship.

Here are my system specs:
Debian etch (stable), 2.6.18 Kernel
javascript:onSubmitToolbarItemClicked('SendMessage','SendMessageLight.aspx?=
_ec=3D1&n=3D1566811031');
Send=20
I am attaching my sensors-detect output with this mail. Please let me know =
if you need more details.

Also I just verified that the temperature monitoring sensors are on SMSC SC=
H3114 Super I/O Chip. Which drivers should I use?

Thanks

KK

_________________________________________________________________
Invite your mail contacts to join your friends list with Windows Live Space=
s. It's easy!
http://spaces.live.com/spacesapi.aspx?wx_action=3Dcreate&wx_url=3D/friends.=
aspx&mkt=3Den-us=

--_31060bd9-904b-4322-84bf-a6c85068888f_
Content-Type: message/rfc822

debian: ~# sensors-detect 


This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no): YES
Probing for PCI bus adapters...
Use driver `scx200_acb' for device 0000:00:0f.0: CS5536 [Geode companion] ISA

We will now try to load each adapter module in turn.
Load `scx200_acb' (say NO if built into your kernel)? (YES/no): YES
Module loaded successfully.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

To continue, we need module `i2c-dev' to be loaded.
Do you want to load `i2c-dev' now? (YES/no): YES      
Module loaded successfully.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: CS5536 ACB0
Do you want to scan it? (YES/no/selectively): YES
Client found at address 0x30
Client found at address 0x50
Handled by driver `eeprom' (already loaded), chip type `eeprom'

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no): YES
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `Winbond W83627HF' at 0x290...                  No
Probing for `Silicon Integrated Systems SIS5595'...         No
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `AMD K8 thermal sensors'...                     No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): YES
Probing for Super-I/O at 0x2e/0x2f
Trying family `ITE'...                                      Yes
Found unknown chip with ID 0x7d02
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found unknown chip with ID 0x7d02
Trying family `VIA/Winbond/Fintek'...                       No
Probing for Super-I/O at 0x4e/0x4f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No

Now follows a summary of the probes I have just done.
Just press ENTER to continue: 

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `CS5536 ACB0'
    Busdriver `UNKNOWN', I2C address 0x50
    Chip `eeprom' (confidence: 6)

  EEPROMs are *NOT* sensors! They are data storage chips commonly
  found on memory modules (SPD), in monitors (EDID), or in some
  laptops, for example.

I will now generate the commands needed to load the required modules.
Just press ENTER to continue: 

To make the sensors modules behave correctly, add these lines to
/etc/modules:

#----cut here----
# I2C adapter drivers
# modprobe unknown adapter CS5536 ACB0
# Chip drivers
eeprom
#----cut here----


Do you want to add these lines to /etc/modules automatically? (yes/NO)no
debian:~# sensors
No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.
debian:~# 

--_31060bd9-904b-4322-84bf-a6c85068888f_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--_31060bd9-904b-4322-84bf-a6c85068888f_--
