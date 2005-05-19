From: harry@dr-data.net (harry)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: LM-sensors Q
Message-Id: <20020924195938.GA9389@dr-data.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020924115615.A15392@mercury.solarsys.net>
In-Reply-To: <20020924115615.A15392@mercury.solarsys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for the fast response Mark. Please see in line with "<<<" markers.



On Tue, Sep 24, 2002 at 11:56:15AM -0700, Mark M. Hoffman wrote:
> Harry:
> 
> (cc'ed to sensors mailing list)
> 
> I do not have personal experience using mkpatch; I find it very easy to
> build everything as modules.  However, it looks to me like you built
> everything correctly.
> 
> > I then need to do a configure, make deps, make BZImage, etc, correct?
> 
> Yes of course.

<<<< I did not find any info on building the AS991275 as a module. The 
only 
reference I found was in the latest drivers section where there was a 
mkpatch link that I pulled the info listed below from. I would much perfer 
to build a standalone module against my current kernel as opposed to 
rebuilding the kernel. I assumed that as a result of the patches I would 
be able to configure the kernel to build the AS199127F module, which I 
assume is not an option w/o the patches.

Please advise as to how I might build the AS99127F module.

 > 
> Did sensors-detect find an I2C or SMBus?  The ASUS sensor chip requires one.
> A quick look at asus.com says your board has Intel 82801BA (ICH2), which
> is supported.  Send me the output of sensors-detect if you're still having
> problems.

<<<< Not sure. output is pasted below. As I mentioned, it did locate my 
brooktree BT888 (or such) TV tuner and my video card, which uses i2c for 
control, so I 
guess this means the system has some i2c support. The motherboard manual 
shows a SMBus connector, but impllies it would be used to attach to some 
type of external device; In other words, I do not recall hooking up any 
cables to this connector, but for MB HW monitoring I would assume an 
internal connection is present.

[sensor-detect output]

[root@dr-data lm_sensors-2.6.5]# /usr/local/sbin/sensors-detect   
 This program will help you to determine which I2C/SMBus modules you need 
to
 load to use lm_sensors most effectively.
 You need to have done a `make install', issued a `depmod -a' and made 
sure
 `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
 module path before you can use some functions of this utility. Read
 doc/modules for more information.
 Also, you need to be `root', or at least have access to the /dev/i2c[-/]* 
files
 for some things. You can use prog/mkdev/mkdev.sh to create these /dev 
files
 if you do not have them already.
 If you have patched your kernel and have some drivers built-in you can
 safely answer NO if asked to load some modules. In this case, things may
 seem a bit confusing, but they will still work.

 System vendor: System Manufacturer
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): yes
Probing for PCI bus adapters...
Use driver `i2c-riva' for device 01:00.0: GeForce2 MX
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-riva' (say NO if built into your kernel)? (YES/no): yes
modprobe: Can't locate module i2c-riva
Loading failed ()... skipping.
** Note: i2c-riva module is available at 
** http://drama.obuda.kando.hu/~fero/cgi-bin/rivatv.shtml
 Do you now want to be prompted for non-detectable adapters? (yes/NO): yes
Load `i2c-elektor' (say NO if built into your kernel)? (YES/no): y
modprobe: Can't locate module i2c-elektor
Loading failed ()... skipping.
Load `i2c-elv' (say NO if built into your kernel)? (YES/no): y
modprobe: Can't locate module i2c-elv
Loading failed ()... skipping.
Load `i2c-philips-par' (say NO if built into your kernel)? (YES/no): y
Module loaded succesfully.
Load `i2c-velleman' (say NO if built into your kernel)? (YES/no): y
modprobe: Can't locate module i2c-velleman
Loading failed ()... skipping.
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang 
halfway
 through; we can't really help that. Also, some chips will be double 
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you 
can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: bt848 #0 (Bit-shift algorithm)
Do you want to scan it? (YES/no/selectively): yes
Client at address 0x50 can not be probed - unload all client drivers 
first!
Client at address 0x61 can not be probed - unload all client drivers 
first!

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no): yes
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
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue: 


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver 
module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? isa

WARNING! If you have some things built into your kernel, the 
below list will contain too many modules. Skip the appropriate ones!
To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
# I2C chip drivers
#----cut here----

To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): yes
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.

[/sensors-detect output]

I have the following line in /etc/modules:

[root@dr-data lm_sensors-2.6.5]# cat /etc/modules.conf | grep i2c
# i2c
alias char-major-89 i2c-dev
options i2c-core i2c_debug=1
options i2c-algo-bit bit_test=1


Output of sensors.init:

[root@dr-data lm_sensors-2.6.5]# ./prog/init/lm_sensors.init status
eeprom-i2c-0-50
Adapter: bt848 #0
Algorithm: Bit-shift algorithm

[root@dr-data lm_sensors-2.6.5]# ./prog/init/lm_sensors.init stop  
Shutting down sensors: 
[root@dr-data lm_sensors-2.6.5]# ./prog/init/lm_sensors.init start
Starting up sensors: 
[root@dr-data lm_sensors-2.6.5]# ./prog/init/lm_sensors.init status
eeprom-i2c-0-50
Adapter: bt848 #0
Algorithm: Bit-shift algorithm


[lsmod output]

[root@dr-data lm_sensors-2.6.5]# lsmod
Module                  Size  Used by    Tainted: P  
eeprom                  3488   0  (unused)
i2c-proc                6272   0  [eeprom]
i2c-philips-par         1992   0  (unused)
i2c-dev                 3584   0 
NVdriver             1065248  10 
tun                     3584   3 
emu10k1                63040   1  (autoclean)
ac97_codec              9600   0  (autoclean) [emu10k1]
soundcore               3972   4  (autoclean) [emu10k1]
tuner                   8324   1  (autoclean)
tvaudio                 9856   0  (autoclean) (unused)
bttv                   59232   1  (autoclean)
videodev                5088   3  (autoclean) [bttv]
i2c-algo-bit            7052   1  (autoclean) [i2c-philips-par bttv]
i2c-core               13440   0  (autoclean) [eeprom i2c-proc i2c-dev 
tuner tvaudio bttv i2c-algo-bit]
agpgart                21856   3  (autoclean)
ipt_state                576   7  (autoclean)
ipt_LOG                 3456   1  (autoclean)
iptable_filter          1696   1  (autoclean)
ip_nat_ftp              3232   0  (unused)
iptable_nat            14996   2  [ip_nat_ftp]
ip_conntrack_irc        2656   0  (unused)
ip_conntrack_ftp        3488   0  [ip_nat_ftp]
ip_conntrack           15532   4  [ipt_state ip_nat_ftp iptable_nat 
ip_conntrack_irc ip_conntrack_ftp]
ip_tables              11648   6  [ipt_state ipt_LOG iptable_filter 
iptable_nat]
lp                      6208   0  (autoclean)
rtc                     6392   0  (autoclean)

depmod -a returns no errors.

MB manusal suggest leaving SMBus at "mux" as hub can be "unstable". The 
BIOS is set to "mux" as per this suggestion.

Current kernel build options for i2c:

                                                                                                                                               
<M> I2C support                                                                                                                             
<M> I2C bit-banging interfaces                                                                                                              
<M>   Philips style parallel port adapter                                                                                                   
< >   ELV adapter                                                                                                                           
< >   Velleman K9000 adapter                                                                                                                
< > I2C PCF 8584 interfaces                                                                                                                 
<M> I2C device interface                                                                                                                    


Thanks again for any guidance in this matter.


> 
> Regards,
> 
> -- 
> Mark M. Hoffman
> mhoffman@lightlink.com
> 
> * harry <harry@dr-data.net> [2002-09-24 10:48:59 -0700]:
> > Hey dude,
> > 
> > sorry for the interruption but I had a quick question I hope you will help 
> > me with.
> > 
> > I have an ASUS P4B266 MB, which is listed as having the AS99127F sensor at 
> > the MBM site.
> > 
> > I have sucessfully built and installed the lm_sensors-2.6.5 code, but hve 
> > no joy when I run sensors-detect WRT MB sensor (it does find my TV tuner 
> > card).
> > 
> > Accoring to the LM-monitor site, you wrote a patch for the ASUS chip. I 
> > wanted to quickly confirm the following (I'm not a hacker, and I really 
> > want to avoid messing up my system or going through hoops for little 
> > gain):
> > 
> > 
> > 1. I have ran the mkpatch.pl script against my current kerenl source and 
> > there were no errors. May I assume that all is cool with the kernel source 
> > and i2c stuff as a result?
> > 
> > 2. The Readme and mkpatch link is a little vauge about the need to rebuild 
> > the newly patched kernel. A dumb question I'm sure, but after doing:
> > 
> > " Later on, you will want to apply the diffs:
> >   cd /usr/src/linux
> >   patch -p1 -E < /tmp/lm_sensors-diffs
> > "
> > 
> > I then need to do a configure, make deps, make BZImage, etc, correct?
> > 
> > 
> > Thanks in advance; I hope these questions were not exceedingly lame.
> > 
> > PS> The link for mkpatch:
> > 
> > http://www2.lm-sensors.nu/%7Elm78/cvs/lm_sensors2/doc/mkpatch
> > 
> > does not include the ".pl" extension that is now present on the mkpatch 
> > script:
> > 
> > "The patch file is written to stdout; any errors are written to stderr.
> > So you will want to capture the output:
> >   mkpatch/mkpatch . /usr/src/linux > /tmp/lm_sensors-diffs"
> > 
> > [root@dr-data lm_sensors-2.6.5]# ls mkpatch/
> > Config.in  FILES  INCLUDES  mkpatch.pl  Module.mk
> > 				^^^^^^^
> > Thanks again!
> > 
