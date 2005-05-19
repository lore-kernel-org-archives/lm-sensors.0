From: p.henning@fh-karlsruhe.de (Prof. Dr. Peter A. Henning)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: Broken DS1621 detection / ds1621 module / A7V8X
Message-Id: <200501040208.12906.p.henning@fh-karlsruhe.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,

I have some DS1621 temperature sensors attached to an VIA 8235 sitting on my 
Asus A7V8X.

111111111111111111111111111111111111111111111111111111111
Detection of the DS1621 in sensors-detect is broken. According to the data 
sheet of the DS1621, one bit of the configuration register is always 1 and 
another always 0. This is simply not true, if the chip is not properly 
initialized. I suggest the following replacement for sub ds1621_detect in 
sensors-detect

--------------- SNIP ---------------------------------------------------
# $_[0]: A reference to the file descriptor to access this chip.
#        We may assume an i2c_set_slave_addr was already done.
# $_[1]: Address
# Returns: undef if not detected, (3) if detected,
#   (5) or (7) if even more bits match. 
# Registers used:
#   0xAA: Temperature
#   0xA1: High limit
#   0xA2: Low limit
#   0xAC: Configuration
#
# subroutine modified by Peter A. Henning
# Old version checks, if Bit 3 is set and Bit 2 is clear. 
# => THIS IS NOT ALWAYS TRUE
# The DS1621 will however aways have a config like 0x????1??? 
# Also, the calculation of temperatures needs to swap bytes. The lower byte 
# (before swapping) contains the temperature as signed 8-bit integer, the
# higher byte's (before swapping) highest bit is worth another 0.5 degree.
# Hence, logical AND with 0x7F00 should give zero. 

sub ds1621_detect
{
  my $i;
  my ($file,$addr) = @_;
  my $temp = i2c_smbus_read_word_data($file,0xAA);
  return if ($temp & 0x7F00);
  $temp = i2c_smbus_read_word_data($file,0xA1);
  return if ($temp & 0x7F00);
  $temp = i2c_smbus_read_word_data($file,0xA2);
  return if ($temp & 0x7F00);
  my $conf = i2c_smbus_read_byte_data($file,0xAC);
  return (7) if ($conf & 0x10) = 0x10;
}
------------- SNAP --------------------------------------------------------

22222222222222222222222222222222222222222222222222222222222
The DS1621 kernel driver module only loads correctly, if each of the DS1621 
chips is initialized properly. For this I use a simple Perl script writing 
into the configuration register a value of 0x09

i2c_smbus_write_byte_data(\*FILE,0xAC,0x09);

Could one integrate this into the kernel module ?


3333333333333333333333333333333333333333333333333333333333
A note on the Asus Mainboard A7V8X: It carries an ASB100 chip, which occupies 
addresses 0x48 and 0x49. These collide with the two lower addresses possible 
for the DS1621 (ranging from 0x48 - 0x4f). Address bits for the DS1621 must 
be set accordingly. Also, I find that for this Asus Mainboard one needs a 
different temperature algorithm in sensors.conf:

Contribution to sensors.conf:

------------- SNIP -------------------------------------------
# Dallas 1621 Chips connected to internal SMBus
# Last number = 48 + 3-Bit Adress set at Sensor Chip
# Careful: Adresses 0x48 and 0x49 need to be kept free for asb100
#
chip "ds1621-i2c-*-4f"
    label temp  "Power Temp"
    set temp_hyst 35
    set temp_over 40
chip "ds1621-i2c-*-4e"
    label temp  "GPU Temp"
    set temp_hyst 45
    set temp_over 55
chip "ds1621-i2c-*-4d"
    label temp  "Harddisk Temp"
    set temp_hyst 35
    set temp_over 40
#
# Configuration for Asus A7V8X
#
# asb100 Chip on Board
#
chip "asb100-*"

    (Here is the usual stuff for voltages & fans)

    # Used for Athlon Socket A
    # obtained by careful comparison against Asus Probe under Windows
    label temp2 "CPU Socket Temp"
    set temp2_over 60
    set temp2_hyst 50
    compute temp2 (@*90/100)+7, (@-7)*100/90

    # Used for Athlon diode
    # obtained by careful comparison against Asus Probe under Windows
    label temp4 "CPU Diode Temp"
    set temp4_over 60
    set temp4_hyst 50
    compute temp4 (@*90/100)+7, (@-7)*100/90
---------------- SNAP ----------------------------------------------------             

Regards

-- 
Peter Henning

----------------------------------------------PGP 0x5CDC14A1 -------
| Prof.Dr.Peter A.Henning
| 
| European E-Learning Award EureleA
| http://www.eurelea.org
|
| Director MediaLab
| Computer Science, Karlsruhe University of Applied Sciences
| http://medialab.fh-karlsruhe.de/
|-------------------------------------------------------------------
