From: M.Ives@zzzzx.plus.com (Matthew Ives)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: no cpu temp or fan readouts.
Message-Id: <1053558627.814.23.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
Im having problems getting the ln sensors to work and was hoping that
you could help me.

First of all, my hardware is quite standard stuff:
Abit Kr7a mainboard
Athlon xp 2100 cpu
512 mb pc2100 ram.


In windows,the harware detector software that came with the
mainboard,picks up fan speeds and cpu temps,so I know it must be
possible.

I'm running Red Hat linux 8 with a kernel 2.4.20 that I compiled myself
and I made sure that the Ic2 options were all compiled as modules.The
kernel tree also corresponds to the current kernel I'm running.


Anyway,I am a relative newbie to Linux,so please bear with my ignorance.
What I did was: 
1.Compile the kernel so that the i2c options were all modules and not in
the kernel itself

2.downloaded the i2c -2.7.0 package and compiled and  installed it.
I did "make all" then "make install" as it said in the install file.I
then did an /sbin/depmod -a

The modules went to /lib/modules/2.4.20/kernel/drivers/i2c 
and the header files went to
/usr/local/include/linux

3.then I downloaded the lm_sensors-2.7.0 file and did:
"make" and then as root "make install"

4.I then added the line /usr/local/lib to /etc/ld.so.conf 
5. then I did /sbin/ldconfig
6.Then I ran the mkdev.sh file in the program directory.
7.then I ran the sensors-detect file and  it gave me the following to
do:

Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 5000' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x50
    Chip `Serial EEPROM' (confidence: 8)
  * Bus `SMBus Via Pro adapter at 5000' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x51
    Chip `Serial EEPROM' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver
module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? smbus

WARNING! If you have some things built into your kernel, the
below list will contain too many modules. Skip the appropriate ones!
To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-viapro
# I2C chip drivers
modprobe eeprom
#----cut here----

To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): y
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.
[root@localhost ludwig]#

Whilst doing this ,it failed to detect the ISA stuff (sorry,I can't
quite remember) ,but it tried and failed to detect several ISA things.

8.Anyway,I added the suggested lines,rebooted and did a /usr/bin/sensors
and got only this feedback:

[root@localhost ludwig]# /usr/bin/sensors
eeprom-i2c-0-50
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Non-I2C SMBus adapter

eeprom-i2c-0-51
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Non-I2C SMBus adapter

So,in short, no CPU temp (which is what I'm really after) or fan speeds.


Can you tell me where i might have gone wrong?
Sorry for the long email,but I wanted to be as clear as I could.

thanks,
Matthew
-- 
Matthew Ives <M.Ives@zzzzx.plus.com>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030522/d230de0d/attachment.html
