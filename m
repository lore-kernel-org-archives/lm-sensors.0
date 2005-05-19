From: ham.radio@tiscalinet.it (hamradio)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: It works!! (After some troubles)
Message-Id: <3BFD4994.6080604@tiscalinet.it>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

  Hi there,
I'm happy that lm_sensors 2.6.2 now is working fine, and I thought I 
have to send you this report.
I've installed i2c-2.6.2 and lm_sensors-2.6.2 on my Slackware 8.0 (with 
'vanilla' kernel 2.4.13) with 'option 1' for both.
When I first ran sensors-detect it detected the following devices:

Driver `adm1021' (should be inserted but causes problems):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 5000' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x18
    Chip `National Semiconductor LM84' (confidence: 6)
  Misdetects:
  * Bus `SMBus Via Pro adapter at 5000' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x18
    Chip `Maxim MAX1617' (confidence: 3)

Driver `lm80' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 5000' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x2d
    Chip `National Semiconductor LM80' (confidence: 3)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 5000' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x50
    Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)
  * Bus `SMBus Via Pro adapter at 5000' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x51
    Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)

So it suggested me the following entries in /etc/rc.d/rc.modules:
# I2C adapter drivers
modprobe i2c-viapro
# I2C chip drivers
modprobe adm1021
modprobe lm80
modprobe eeprom

Well, during the scanning it also found another device, i2c-philips-par 
, which I don't know anything about...
The problem was that doing as indicated by sensors-detect lent to 
unmeaningful results when running 'sensors'.
In fact I have an Abit KT7A motherboard, which is equipped with a KT133A 
chipset (VIA VT8363A and VT82C686B), and after reading all your 
documentation, FAQ, etc. etc. I understood I'd better not to follow 
sensors-detect's indications. So I modified my /etc/rc.d/rc.modules as 
follows:
# I2C adapter drivers
/sbin/modprobe i2c-isa
/sbin/modprobe i2c-viapro
# I2C chip drivers
/sbin/modprobe via686a
/sbin/modprobe ddcmon
/sbin/modprobe eeprom

and /etc/modules.conf as follows:

# I2C module options
alias char-major-89 i2c-dev
post-install i2c-dev /usr/local/bin/sensors -s

And everything is now working ok. I know this should be something very 
obvious to someone who really has understood how lm_sensor and the I2C 
hardware works, but I really knew nothing before reading all your 
documentation (yes, that's why you wrote it!! :-)). Thanks for it!
Then I've made some tweaking, in order to have all the readings aligned 
to what the bios (and the VIA utility under Windows) reports, and here 
is the result (/etc/sensor.conf):

chip "via686a-*"

    label "2.0V" "Vcore"   # The same labels as my motherboard's bios
    label "2.5V" "+2.5V"
    ignore "2.5V"
#   label "3.3V"
    label "5.0V" "5V"
    label "12V" "12V"

    label fan1  "CPU Fan"
    label fan2  "PWR Fan"

    label temp1 "SYS Temp"
    label temp2 "CPU Temp"
    label temp3 "SBr Temp"
    ignore temp3

    set in0_min 1.6   # This because I have an Athlon Thunderbird, 
running with 1.75 V core.
    set in0_max 2.0   #

   compute "2.0V" 1.04*@ ,  @/1.04       # Vcore
   compute "3.3V" 1.02*@  <mailto:1.02*@%C2%A0> ,  @/1.02      # 3.3V
   compute "5.0V" 1.027*@  <mailto:1.027*@%C2%A0> ,  @/1.027    # 5V
   compute "12V" 1.027*@ ,  @/1.027      # 12V
   compute "fan1" @/1.03 ,  1.03*@       
<mailto:1.03*@%C2%A0%C2%A0%C2%A0%C2%A0%C2%A0%C2%A0> # CPU Fan
   compute "fan2" @/1.03 ,  1.03*@       
<mailto:1.03*@%C2%A0%C2%A0%C2%A0%C2%A0%C2%A0%C2%A0> # PWR Fan
   compute "temp1" @/1.064 ,  1.064*@    
<mailto:1.064*@%C2%A0%C2%A0%C2%A0> # SYS Temp
   compute "temp2" @/1.05 ,  1.05*@      
<mailto:1.05*@%C2%A0%C2%A0%C2%A0%C2%A0%C2%A0> # CPU Temp

Well, I think the 'compute' lines are what could be interesting to other 
Abit KT7A owners, that's also why I'm sending you this e-mail. Please 
let me know if you perhaps need some other detail.
That's all, I want to thank you for the valuable job you are doing with 
the lm_sensors project, and I hope this e-mail could be of some interest 
to you.
Kind regards.
Riccardo Tritto - hamradio@quipo.it <mailto:hamradio@quipo.it>



