From: se.witt@gmx.net (Sebastian Witt)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: ATXP1 kernel patch
Message-Id: <41D9F5C8.3050604@hasw.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D821D9.5030003@hasw.net>
In-Reply-To: <41D821D9.5030003@hasw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
 >>I've updated the module:
 >>http://www.hasw.net/linux/atxp1-0.3.patch
 >
 >
 > Comments:
 >
 > 1* Please respect the alphabetical order in i2c/chips/Makefile.
 >
 > 2* You include linux/config.h but don't seem to use it.
1-2 Ok.

 > 3* What is this "low_voltage" module parameter?
It allows setting of 1075mV which is not available on all platforms. 
Think this is removeable when using i2c-sensor-vid?

 > 4* I am really suspicious that the atxp1 has 0x37 and 0x4e as possible
 > addresses. How do you know?
On all mainboards (full list under http://www.hasw.net) I've seen, the 
ATXP1 is using 0x37 or 0x4e. If someone has a board with an ATXP1 which 
is using a different address, I think it can easily be added.

 > 5* normal_i2c_range is gone in Linux 2.6.10.
 >
 > 6* Don't use .id in i2c_driver atxp1_driver, you don't need it.
 >
 > 7* Other drivers don't call I2C_CLIENT_INSMOD directly.
Ok.


 > 8* In the current implementation, atxp1_data.valid is usless (value is
 > always 0). I also think that you should use restore and use
 > atxp1_data.last_updated.
Already fixed that, now using in atxp1_update_device:

# Update register data if needed
for(count = 0; count <= 0x0a; count++) {
     if((data->valid >> count & 1) = 0) {
         data->reg[count] = i2c_smbus_read_byte_data(client, count);
         data->valid |= 1 << count;
     }
}

 > 9* What's the difference between VID and CPU VID?
VID is the VID output control, enables or disables VID output control.
CPU VID are the original VID pins from the CPU.

 > 10* You hardcode the VID <-> Vcore translation formula. Depending on the
 > VRM version, it might or might not be correct. You should use the
 > functions in i2c-sensor-vid.
Ok.

 > 11* atxp1_write is quite complex. What makes you believe that the write
 > could possibly fail? Other i2c drivers don't do that kind of check.
Ported code. I'll remove it.

 > 12* Why does vcore default to 1.650V in atxp1_storevcore? Why is vcore
 > arbitrarily kept between 1.075V/1.100V and 1.850V? If trying to write a
 > value outside of this range is an error, then atxp1_storevcore should
 > return an error (negative value) when it happens.
1.075V-1.85V is the VRM range that is available on my 8RDA+ board. 
Greater range isn't possible.

 > 13* Use dev_info/dev_dbg etc... instead of printk wherever possible.
Ok.

 > 14* Care to comment/document the final loops in atxp1_storevcore? Since
 > atxp1_write is complex, I fear that these loops will be damn slow. Why
 > are they needed at all?
Trying to set CPU voltage in greater steps will freeze the CPU 
immediately (>+/-125mV, less under high CPU load). By in-/decrease the 
voltage in 25mV step the stability is increased. On my PC a script 
controls the CPU frequency and voltage and I do not recongize if it 
switches multiple times between 1125mV and 1650mV in a minute for 
testing. Ok that's subjective but could you define "slow" a little bit 
more please?

 > 15* Why does atxp1_storevcore set data->valid to 0?
So it only updates the local data if there was an write.
Is already replaced.

 > 16* Sysfs file name should probably be cpu0_vid, not cpu_vid, although I
 > admit I don't know how to properly handle the case where more than one
 > device is present.
Not thought on this, but is there a MP system which uses two of theses 
chips to
let the user independently control the CPU core voltages? But it should 
be modified.

 > 17* Don't set new_client->id to 0 in atxp1_detect, it's useless.
Ok.

 > 18* You detection method is too weak and will most likely result in
 > frequent misdetections. You have to improve it. I know that the device
 > doesn't have a decidated identification register, nor does it have many
 > registers to test, but we can certainly do something. Which registers
 > does the device have exactly? What happens when reading from
 > non-existent registers? The output of "i2cdump" may help.
Yes, that's right. I've attached the dump. Maybe using 0x0b-0x0f (shows 
all zero), 0x10-0x1a showing same value as 0x00 and >0x20 all zero.

 > 19* atxp1_detach_client frees the client data even if the deregistration
 > failed. This is probably dangerous.
Ok, fixed.

 > 20* init and exit functions are not properly marked __init and __exit.
also.

 > Good work nonetheless, this device is completely different from what we
 > have seen before so it's quite normal that some things need to be
 > discussed and tweaked before you/we get them right.

Thanks for your help.

Regards,
Sebastian
-------------- next part --------------
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x37, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 29 0a 1c 0c 0c 81 96 03 00 00 fb 00 00 00 00 00    )???????..?.....
10: 29 29 29 29 29 29 29 29 29 29 29 09 09 08 08 08    )))))))))))?????
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
