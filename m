From: mstuff@pl.net (Morgan Read)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: Tellerstats, Computer Hardware Statistics
Message-Id: <42141A32.2010006@pl.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <pT0OxCEG.1108373919.2908350.khali@localhost>
In-Reply-To: <pT0OxCEG.1108373919.2908350.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,
Thanks very much for your response.
I've attached the output of i2cdump (following sensors-detect &
i2cdetect output for your info).

Jean Delvare wrote:
> Hi Morgan,
> 
> On 2005-02-14, Morgan Read wrote:
> 
>>Basically, I have a laptop with the mc1066 chip in that seems to be
>>doing _very_ strange things at start up.  I've set up the mc1066 part of
>>sensors.conf so:
>>
>>   label temp 		"Board"
>>   label remote_temp	"CPU"
>>(...)
>>   set temp_low			40
>>   set temp_over		54
>>   set remote_temp_low		55
>>   set remote_temp_over		69
> 
> 
> Setting low temps to 40 degrees doesn't sound like a sane thing to do.
> This means that temperatures below 40 degrees C will trigger an alarm. I
> do not personally consider it a problem when my systems run at 25
> degrees C. In fact, down to 15 degrees C seems to be fairly acceptable
> for any hardware, so you could just set the low limits to this.

I was intending to use the low temps to trip the fan cut off, when I
worked out how to control the fan.  May be incorrect strategy?

> BTW, are you sure you have an MC1066? That's a rare chip as far as I
> know. What laptop is this? Care to provide a dump of the chip (using
> i2cdump)?
> 

Only as sure as knowing what sensors-detect said:|  (See attached.)  The
dump for 0x69 (apart from appearing to be nothing) took quite a while to
output (cf. dump for 0x4e).  It's a clevo 2200t with desktop pIII in,
thus the heat generation.

> 
>>Boot starts; fan off; fan slow; fan off; boot ends.  I log in, sensors
>>reports settings as above, cpu temp climbs to 69, fan cuts in, the
>>values reset to: cpu high 127 (!!!); cpu low 55; board high 55; board
>>low -55 (!!!).  Then, cpu temp drops to (perhaps) 54, fan stops, the
>>values reset to: cpu high 70 (?); cpu low -55 (!!!); board high 55;
>>board low -55 (!!!).
> 
> 
> Looks like a chip reset to me (IIRC 55/70/-55 are the chip defaults for
> the adm1021/max1617 family). 127 also might have a special meaning, I'd
> need to get my hands on a MC1066 datasheet to make sure.
> 
> 
>>The cpu temp climbs to 70, the fan cuts in and then things seem to
>>stabilise around cpu 57-62.
>>
>>Or something like that!  Mad?
> 
> 
> Admittedly odd overall.
> 
> 
>>So, I'm trying to work out what on earth's going on?
> 
> 
> What version of lm_sensors are you using exactly? With what kernel? I
> remember we reworked the init process of the adm1021 driver some months
> ago, so if you're using a somewhat old version, you might get an
> improvement by simply updating it.

lm_sensors-2.8.6-1, as per fc2.  I realise this considered broken, but
thought I'd stick with what's provided for the distro - would an update
prove more useful?
Kernel is 2.6.10-1.9_FC2

Thanks again.
Regards,
Morgan.

> --
> Jean Delvare
> 

-- 
Morgan Read
<mailto:mstuffATplDOTnet>

-------------- next part --------------
[root@morgansmachine root]# sensors-detect
 
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
Use driver `i2c-sis630' for device 00:00.0: Silicon Integrated Systems SIS630
Probe succesfully concluded.
 
We will now try to load each adapter module in turn.
Load `i2c-sis630' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
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
 
Next adapter: SMBus SIS630 adapter at 1080 (Algorithm unavailable)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x4e
Probing for `National Semiconductor LM75'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Failed!
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Success!
    (confidence 5, driver `adm1021')
Probing for `National Semiconductor LM82'... Failed!
Probing for `National Semiconductor LM83'... Failed!
Client found at address 0x69
 
Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.
 
Do you want to scan the ISA bus? (YES/no): n
 
Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.
 
Do you want to scan for Super I/O sensors? (YES/no): n
 
 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:
 
Driver `adm1021' (should be inserted):
  Detects correctly:
  * Bus `SMBus SIS630 adapter at 1080' (Algorithm unavailable)
    Busdriver `i2c-sis630', I2C address 0x4e
    Chip `Onsemi MC1066' (confidence: 5)
 
 
 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?
 
To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:
 
#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----
 
To load everything that is needed, add this to some /etc/rc* file:
 
#----cut here----
# I2C adapter drivers
modprobe i2c-sis630
# I2C chip drivers
modprobe adm1021
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----
 
WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.
 
Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): n
 
[2]+  Done                    mozilla -mail
You have new mail in /var/spool/mail/root
[root@morgansmachine root]# i2cdetect -l
i2c-0   unknown         SMBus SIS630 adapter at 1080            Algorithm unavailable
You have new mail in /var/spool/mail/root
[root@morgansmachine root]# i2cdetect 0
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX 4e XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX
[root@morgansmachine root]# i2cdump 0 0x4e
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x4e, mode byte
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 2f 3c 00 00 04 36 28 45 37 ff ff ff ff ff ff ff    /<..?6(E7.......
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: 90 e0 32 37 ff ff ff ff XX XX XX XX XX XX 54 00    ??27....XXXXXXT.
You have new mail in /var/spool/mail/root
[root@morgansmachine root]# i2cdump 0 0x69
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x69, mode byte
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
You have new mail in /var/spool/mail/root
[root@morgansmachine root]#
