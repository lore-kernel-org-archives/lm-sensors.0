From: Ymu@Winbond.com.tw (Ymu@Winbond.com.tw)
Date: Fri, 03 Mar 2006 03:19:04 +0000
Subject: [lm-sensors] Need help, all temps are displaying -48.0C
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECEE5282D@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060302041617.7762.qmail@web32514.mail.mud.yahoo.com>
In-Reply-To: <20060302041617.7762.qmail@web32514.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Pat,

 

Please reply to lm-sensors list, and I will receive your mail too.

First try to remove w83781d driver, I think you can find it still in /etc/rc.d/init.d/lm_sensors or /etc/rc.local.

Or just do "modprobe -r w83781d".

Then use the attached driver this time, I think there would not be so many ERRORs now.

 

 

Best Regards

Yuan Mu

________________________________

From: Pat [mailto:patchu1 at yahoo.com] 
Sent: Friday, March 03, 2006 6:13 AM
To: PI14 YMU
Subject: Re: [lm-sensors] Need help, all temps are displaying -48.0C

 

Hi Yuan,
Thank you for replying. I installed the w83781d driver you attached. I do get the correct temperatures reported now, however 3 different sensors appear, only 1 has the correct temperatures but incorrect fan speeds. I have redid the sensors-detect and sensors command, the log is below. Please let me know what you think the problem is.

Thanks,
Pat

Log:

sensors-detect
Hexadecimal number > 0xffffffff non-portable at /usr/local/sbin/sensors-detect line 2108, <INPUTFILE> line 15.
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
Use driver `i2c-i801' for device 00:1f.3: Intel 6300ESB
Probe succesfully concluded.
 
We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.
 
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):
 Module loaded succesfully.
 
 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).
 
Next adapter: ISA main adapter
Do you want to scan it? (YES/no/selectively):
Can't open /dev/i2c-1
 
Next adapter: SMBus I801 adapter at 1100
Do you want to scan it? (YES/no/selectively):
Client at address 0x2d can not be probed - unload all client drivers first!
Client found at address 0x2f
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83792D'... Success!
    (confidence 7, driver `w83792d')
Probing for `Winbond W83791SD'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Winbond W83627EHF'... Failed!
Probing for `Asus AS99127F (rev.1)'... Failed!
Probing for `Asus AS99127F (rev.2)'... Failed!
Probing for `Asus ASB100 Bach'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1029'... Failed!
Probing for `ITE IT8712F'... Failed!
Client found at address 0x30
Client at address 0x48 can not be probed - unload all client drivers first!
Client at address 0x49 can not be probed - unload all client drivers first!
Client found at address 0x60
Client found at address 0x61
Probing for `SMBus 2.0 ARP-Capable Device'... Success!
    (confidence 1, driver `smbus-arp')
Client found at address 0x69
Client found at address 0x6e
 
Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.
 
Do you want to scan the ISA bus? (YES/no):
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Success!
    (confidence 8, driver `w83781d')
Probing for `Winbond W83627EHF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8712F'
  Trying address 0x0290... Failed!
Probing for `ITE IT8705F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!
 
Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.
 
Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83627HF Super IO Sensors'
  Success... found at address 0x0295
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83687THF Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0x52)
Probing for `Winbond W83L517D Super IO'
  Failed! (0x52)
Probing for `Fintek F71805F/FG Super IO Sensors'
  Failed! (0x5241)
Probing for `Wi nbond W83627EHF/EHG Super IO Sensors'
  Failed! (0x5241)
 
Do you want to scan for secondary Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (skipping family)
 
 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:
 
Driver `w83792d' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 1100'
    Busdriver `i2c-i801', I2C address 0x2f
    Chip `Winbond W83792D' (confidence: 7)
 
Driver `smbus-arp' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 1100'
    Busdriver `i2c-i801', I2C address 0x61
    Chip `SMBus 2.0 ARP-Capable Device' (confidence: 1)
 
Driver `w83781d' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF' (confidence: 8)
 
Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0295 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF Super IO Sensors' (confidence: 9)
 
 
I will now generate the commands needed to load the I2C modules.
 
To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:
 
#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----
 
To load everything that is needed, add this to some /etc/rc* file:
 
#----cut here----
# I2C adapter drivers
modprobe i2c-i801
modprobe i2c-isa
# I2C chip drivers
modprobe w83792d
# Warning: the required module smbus-arp is not currently installed on your system.
# For status of 2.6 kernel ports see http://secure.netroedge.com/~lm78/supported.html
# If driver is built-in to the kernel, or unavailable, comment out the following line.
modprobe smbus-arp
modprobe w83781d  #YUAN I TOOK THIS ONE OUT LATER
modprobe w83627hf
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----
 
WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.
 
Do you want to generate /etc/sysconfig/lm_sensors? (YES/no):
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.
[root at localhost ~]# cp lm_sensors-2.10.0/prog/init/lm_sensors.init /etc/rc.d/init.d/lm_sensors
cp: overwrite `/etc/rc.d/init.d/lm_sensors'? y
[root at localhost ~]# gedit /etc/modprobe.conf 
<COMMENT: I ADDED FIELDS ABOVE>
[root at localhost ~]# gedit /etc/rc.local
<COMMENT: I ADDED FIELDS ABOVE>
[root at localhost ~]# reboot

Last login: Thu Mar  2 13:40:04 2006 from 192.168.0.23
[root at localhost ~]# sensors
w83627hf-i2c-0-2d
Adapter: SMBus I801 adapter at 1100
 
VCore 1:   +3.97 V  (min =  +0.00 V, max =  +0.00 V)
VCore 2:   +3.97 V  (min =  +0.00 V, max =  +0.00 V)
+3.3V:     +3.95 V  (min =  +3.14 V, max =  +3.46 V)
+5V:       +5.08 V  (min =  +4.73 V, max =  +5.24 V)
+12V:     +11.55 V  (min = +10.82 V, max = +13.19 V)
-12V:      +0.72 V  (min = -13.18 V, max = -10.88 V)
-5V:       +1.84 V  (min =  -5.25 V, max =  -4.75 V)
V5SB:      +5.56 V  (min =  +4.73 V, max =  +5.24 V)
VBat:      +0.13 V  (min =  +2.40 V, max =  +3.60 V)
fan1:        0 RPM  (min = 2848 RPM, div = 2)
fan2:     4218 RPM  (min = 2848 RPM, div = 2)
fan3:     4326 RPM  (min =  712 RPM, div = 8)
temp1:       -48?C  (high =   -37?C, hyst =   +59?C)   sensor = thermistor                                                                                 
temp2:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor                                                                                 
temp3:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor                                                                                 
vid:      +0.000 V  (VRM Version 9.0)
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled
 
w83792d-i2c-0-2f
Adapter: SMBus I801 adapter at 1100
 
in0:       +1.27 V  (min =  +0.00 V, max =  +2.04 V)
in1:       +1.28 V  (min =  +0.00 V, max =  +2.04 V)
in2:       +3.30 V  (min =  +2.96 V, max =  +3.62 V)
in3:       +2.99 V  (min =  +2.69 V, max =  +3.30 V)
in4:       +0.53 V  (min =  +0.30 V, max =  +0.75 V)
in5:       +3.18 V  (min =  +2.83 V, max =  +3.47 V)
in6:       +5.01 V  (min =  +4.01 V, max =  +4.90 V)       ALARM
in7:       +4.92 V  (min =  +4.01 V, max =  +4.90 V)       ALARM
in8:       +3.28 V  (min =  +2.96 V, max =  +3.62 V)
ERROR: Can't get FAN1 data!
ERROR: Can't get FAN2 data!
ERROR: Can't get FAN3 data!
ERROR: Can't get FAN4 data!
ERROR: Can't get FAN5 data!
ERROR: Can't get FAN6 data!
ERROR: Can't get FAN7 data!
temp1:     +38.0?C  (high = +80.0?C, hyst = +75.0?C)
temp2:     +42.5?C  (high = +80.0?C, hyst = +75.0?C)
temp3:     +42.0?C  (high = +80.0?C, hyst = +75.0?C)
chassis:  Chassis intrusion detection                  ALARM
 
w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +3.97 V  (min =  +0.00 V, max =  +0.00 V)
VCore 2:   +3.98 V  (min =  +0.00 V, max =  +0.00 V)
+3.3V:     +3.97 V  (min =  +3.14 V, max =  +3.46 V)
+5V:       +5.08 V  (min =  +4.73 V, max =  +5.24 V)
+12V:     +11.55 V  (min = +10.82 V, max = +13.19 V)
-12V:      +0.80 V  (min = -13.18 V, max = -10.88 V)
-5V:       +1.94 V  (min =  -5.25 V, max =  -4.75 V)
V5SB:      +5.59 V  (min =  +4.73 V, max =  +5.24 V)
VBat:      +0.13 V  (min =  +2.40 V, max =  +3.60 V)
fan1:        0 RPM  (min = 2848 RPM, div = 2)
fan2:     4272 RPM  (min = 2848 RPM, div = 2)
fan3:     4326 RPM  (min =  712 RPM, div = 8)
temp1:       -48?C  (high =   -37?C, hyst =   +59?C)   sensor = thermistor                                                                                 
temp2:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor                                                                                 
temp3:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor                                                                                 
vid:      +0.000 V  (VRM Version 9.0)
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled
 
[root at localhost ~]#

Ymu at Winbond.com.tw wrote:

Hello Pat,
Please remove the "modprobe w83781d" line first. I think You don't need that module.
Then you can try to install w83792d driver.
Because sensors-detect tell you 
"
# Warning: the required module w83792d is not currently installed on your system .
# For status of 2.6 kernel ports see http://secure.netroedge.com/~lm78/supported .html
# If driver is built-in to the kernel, or unavailable, comment out the following line.
modprobe w83792d
"
Rodolf has some backport of this driver,
http://assembler.cz/download/w83792d/

Or you can just try the driver attached with this mail

Best Regards
Yuan Mu



=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.

 

________________________________

Brings words and photos together (easily) with
PhotoMail <http://us.rd.yahoo.com/mail_us/taglines/PMall/*http:/photomail.mail.yahoo.com> - it's free and works with Yahoo! Mail.



=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060303/63f52a40/attachment-0001.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: old_w83792d_2.tar.gz
Type: application/x-gzip
Size: 12134 bytes
Desc: old_w83792d_2.tar.gz
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060303/63f52a40/old_w83792d_2.tar-0001.gz
