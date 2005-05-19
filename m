From: plukje@gmx.net (Eric)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: adm1021 (probably) does something VERY,VERY BAD
Message-Id: <4062DF99.4080504@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4062C734.5000104@gmx.net>
In-Reply-To: <4062C734.5000104@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

'greetings all list members

(transcript of the original conversation is at the bottom)

> You're lucky it did come back. I think I remember we once had a report
> of such a case and the system never came back :(

Well the main reason I figured wanted to use this chip was to know what
was behind it :) Guess that was kinda stupid.

> I'd like the brand and model of the motherboard too.

The motherboard is an MSI-6728, which is also known as a MSI 865PE Neo2-PLS
see
http://www.msi.com.tw/program/products/mainboard/mbd/pro_mbd_detail.php?UIDR8
for more gory details.

> I actually think that whatever you have at 0x4e, it isn't an adm1021
> compatible chip. You already have a full featured monitoring chip on
> the board W83627HF, adding an old LM84 wouldn't make any sense.

Well I'm not that much sensor chips and all, but my guess was that it could
access data the W83627HF could not access.

About the version I used, I couldn't find a version number in sensors-detect
but I'm fairly sure this is 2.8.5 (from sensors --version) or better.
To exclude any possible miscommunications I added the entire adm1021_detect
function at the bottom of this email.

Kind regards,


Eric

root@pathfinder eric # i2cdump 0 0x2e
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x2e, mode byte
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

root@pathfinder lib # cat /usr/sbin/sensors-detect |grep -A 52  
adm1021_detect
sub adm1021_detect
{
  my ($chip, $file,$addr) = @_;
  return if $chip = 0 and i2c_smbus_read_byte_data($file,0xfe) != 0x41 ||
                          (i2c_smbus_read_byte_data($file,0xff) & 0xf0) 
!= 0x00;
  return if $chip = 1 and i2c_smbus_read_byte_data($file,0xfe) != 0x41 ||
                          (i2c_smbus_read_byte_data($file,0xff) & 0xf0) 
!= 0x30;
  return if $chip = 4 and i2c_smbus_read_byte_data($file,0xfe) != 0x49;
  return if $chip = 5 and i2c_smbus_read_byte_data($file,0x04) != 0x00;
  return if $chip = 6 and i2c_smbus_read_byte_data($file,0xfe) != 0x23;
  return if $chip = 3 and i2c_smbus_read_byte_data($file,0xfe) != 0x4d ||
                           i2c_smbus_read_byte_data($file,0xff) != 0x01;
  return if $chip = 7 and i2c_smbus_read_byte_data($file,0xfe) != 0x54;
  # The remaining things are flaky at best. Perhaps something can be done
  # with the fact that some registers are unreadable?
  return if (i2c_smbus_read_byte_data($file,0x02) & 0x03) != 0;
  # Extra checks for MAX1617 and LM84, since those are often misdetected
  if ($chip = 2 || $chip = 5)
  {
    # Increase the misdetect value each time a temperature doesn't
    # match reasonable expectations
    my $misdetect = 0;
    # Negative temperatures
    $misdetect++ if ((my $lte=i2c_smbus_read_byte_data($file,0x00)) & 0x80);
    $misdetect++ if ((my $rte=i2c_smbus_read_byte_data($file,0x01)) & 0x80);
    # Negative high limits
        my ($lhi, $rhi);
    if (($lhi=i2c_smbus_read_byte_data($file,0x05)) & 0x80)
    {
      $misdetect++;
      $lhi-%6;
    }
    if (($rhi=i2c_smbus_read_byte_data($file,0x07)) & 0x80)
    {
      $misdetect++;
      $rhi-%6;
    }
    # Low limits over high limits
    my $llo=i2c_smbus_read_byte_data($file,0x06);
    my $rlo=i2c_smbus_read_byte_data($file,0x08);
    $llo-%6 if ($llo & 0x80);
    $rlo-%6 if ($rlo & 0x80);
    $misdetect++ if $llo > $lhi;
    $misdetect++ if $rlo > $rhi;
    return if $misdetect >= 4;
        # Also return if all six bytes have the same value
        return if $lte = $rte and $lte = $lhi and $lte = $rhi
      and $lte = $llo and $lte = $rlo;
  }
  return 3 if $chip = 2;
  return 7 if $chip <= 3;
  return 5;
}



Jean Delvare wrote:

> [Please reply to the list, not to me]
>
> Quoting Eric <plukje@gmx.net>:
>
>> Based on the output of sensors-detect I insmodded adm1021:
>>
>> Driver `adm1021' (should be inserted):
>> Detects correctly:
>> * Bus `SMBus I801 adapter at 0c00' (Algorithm unavailable)
>> Busdriver `i2c-i801', I2C address 0x4e
>> Chip `National Semiconductor LM84' (confidence: 5)
>>
>> The module was build from a 2.6.5-rc1 kernel tree (SMP). After
>> insmodding the module the machine shut down instantly, which could
>> have only been caused because the hardware detected _something_
>> critical enough that it shut down the system immediatly. Initial
>> tries to power up again were futile, only after unplugging
>> and giving it a few minutes the machine came back up again (*phew*).
>
>
> You're lucky it did come back. I think I remember we once had a report
> of such a case and the system never came back :(
>
>> I can't give you anything other helpfull information concerning what
>> happened, simply because there was none given. However I put the
>> details of the machine below.
>
>
> I'd like the brand and model of the motherboard too.
>
>> Whatever happened, it shouldn't have happened :-) (I'm just glad
>> the machine came back on again.)
>
>
> I actually think that whatever you have at 0x4e, it isn't an adm1021
> compatible chip. You already have a full featured monitoring chip on
> the board W83627HF, adding an old LM84 wouldn't make any sense.
>
> That said, yes, we still should try to prevent what happened to you from
> happening to others. This could include:
>
> 1* Refine sensors-detect again. I thought it was OK after my latest
> changes, but obviously it isn't (providing this was sensors-detect from
> lm_sensors 2.8.5). One thing that would help would be to know what the
> mysterious chip is, and add detection for it in sensors-detect (even if
> it's not a hardware monitoring chip). Any idea of what this could be?
>
> 2* Refine adm1021's detection procedure too.
>
> 3* Drop adm1021's limit init. This was already done in the 2.4 driver
> and should have been done in 2.6 as well.
>
>> let me know if you require any other information
>
>
> I'd appreciate a dump of the faulty chip (i2cdump 0 0x2e), this could
> help us find out what it is and possibly prevent it from being
> recognized as an adm1021-compatible one.
>
> Thanks and sorry for the trouble.
>
