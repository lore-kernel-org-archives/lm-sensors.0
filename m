From: pakar@imperialnet.org (Patric)
Date: Wed, 18 Jan 2006 19:17:51 +0000
Subject: [lm-sensors] Asus a8v problems.
Message-Id: <43CE945F.8020105@imperialnet.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I seem to have some problems with lm-sensors here.
First, it seems like in some revision of lm-sensors i lost the ability 
to see the RAM that was installed in the system (see the i2cdump later). 
I know this worked before, but i'm not shure what version of lm-sensors 
it was ten.

The problem that i'm having is that i dont seem to be able to control 
fan3. Speeds and everything is correct, but if i just do an echo 0 >pwm3 
the fan still does not stop. fan1 and 2 (and pwm1 and 2) works 
perfectly. Any hints of what to look at would be a great help, or if you 
know that there is some problems like this. (did not find any matching 
entrys in the bug-tracker)


Just got the latest daily snapshot of the lm-sensors today but some 
stuff seem to still be missing, so lets collect some info.
---------------------------------------------------------
# sensors-detect revision 1.412 (2006/01/17 07:34:49)

Use driver `i2c-viapro' for device 00:11.0: VIA Technologies VT8237 
South Bridge
Probe succesfully concluded.

Next adapter: SMBus Via Pro adapter at 0400
Do you want to scan it? (YES/no/selectively):
Client found at address 0x2f

Probing for `Winbond W83791SD'... Success!
     (confidence 3, driver `not-a-sensor')

Client found at address 0x48

Client found at address 0x49

Client at address 0x50 can not be probed - unload all client drivers first!
Client at address 0x51 can not be probed - unload all client drivers first!
Client at address 0x52 can not be probed - unload all client drivers first!
Client at address 0x53 can not be probed - unload all client drivers first!
Client found at address 0x61
Probing for `SMBus 2.0 ARP-Capable Device'... Success!
     (confidence 1, driver `smbus-arp')
Client found at address 0x69


Do you want to scan for Super I/O sensors? (YES/no):

Probing for `Winbond W83627THF Super IO Sensors'
   Success... found at address 0x0290



First address at 0x2f
# i2cdump 0 0x2f
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c/0, address 0x2f, mode byte
Continue? [Y/n]
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 82 00 00 01 00 00 ff    .........?..?...
10: 00 00 7f 00 00 10 00 00 00 00 00 00 00 00 00 80    ..?..?.........?
20: 10 05 0f bf 05 05 05 7d ff ff ff 7e 68 00 00 ed    ???????}...~h..?
30: b0 00 00 20 10 10 20 10 00 00 20 20 80 02 ff ff    ?.. ?? ?..  ??..
40: 01 30 20 00 00 00 00 50 2f 10 01 44 01 95 80 5c    ?0 ....P/??D???\
50: ff ff ff ff ff ff 00 80 72 70 ff 00 00 00 05 ff    .......?rp....?.
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: 01 ff 01 ff 00 00 00 00 01 01 01 01 3c 3c 0a 0a    ?.?.....????<<??
90: 00 00 00 01 ff 00 00 00 01 01 3c 00 00 00 01 01    ...?....??<...??
a0: ff ff ff 00 00 00 00 00 18 ff 6b 18 00 ff ff ff    ........?.k?....
b0: bf 00 05 ff 00 06 20 04 00 09 ff ff 84 00 ff ff    ?.?..? ?.?..?...
c0: 7d 80 00 4b 00 50 00 ff 7d 80 00 4b 00 50 00 ff    }?.K.P..}?.K.P..
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff 00 ff 00 01 00 ff ff 02 ff 00 00 10 ff 1d    .....?...?...?.?

next address at 0x48
# i2cdump 0 0x48
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c/0, address 0x48, mode byte
Continue? [Y/n]
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
10: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
20: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
30: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
40: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
50: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
60: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
70: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
80: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
90: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
a0: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
b0: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
c0: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
d0: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
e0: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
f0: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP

next one at 0x49
# i2cdump 0 0x49
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c/0, address 0x49, mode byte
Continue? [Y/n]
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
10: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
20: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
30: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
40: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
50: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
60: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
70: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
80: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
90: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
a0: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
b0: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
c0: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
d0: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
e0: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP
f0: 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50 7d 00 4b 50    }.KP}.KP}.KP}.KP


next ones at 0x50-0x53 these seem to be the missing info about the ram 
in the system:
# i2cdump 0 0x50
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c/0, address 0x50, mode byte
Continue? [Y/n]
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 07 0d 0b 02 40 00 04 50 70 00 82 08 00 01    ??????@.?Pp.??.?
10: 0e 04 10 01 02 20 f0 60 70 75 70 3c 28 3c 28 80    ????? ?`pup<(<(?
20: 60 60 40 40 00 00 00 00 00 37 46 1e 28 50 00 00    ``@@.....7F?(P..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 bd    ...............?
40: 7f 7f 9e 00 00 00 00 00 01 56 53 31 47 42 34 30    ???.....?VS1GB40
50: 30 43 33 20 20 20 20 20 20 20 20 00 00 00 00 00    0C3        .....
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

# i2cdump 0 0x51
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c/0, address 0x51, mode byte
Continue? [Y/n]
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 07 0d 0b 02 40 00 04 50 70 00 82 08 00 01    ??????@.?Pp.??.?
10: 0e 04 10 01 02 20 f0 60 70 75 70 3c 28 3c 28 80    ????? ?`pup<(<(?
20: 60 60 40 40 00 00 00 00 00 37 46 1e 28 50 00 00    ``@@.....7F?(P..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 bd    ...............?
40: 7f 7f 9e 00 00 00 00 00 01 56 53 31 47 42 34 30    ???.....?VS1GB40
50: 30 43 33 20 20 20 20 20 20 20 20 00 00 00 00 00    0C3        .....
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

# i2cdump 0 0x52
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c/0, address 0x52, mode byte
Continue? [Y/n]
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 07 0d 0a 02 40 00 04 50 60 00 82 08 00 01    ??????@.?P`.??.?
10: 0e 04 08 01 02 20 00 60 70 75 75 3c 28 3c 28 40    ????? .`puu<(<(@
20: 60 60 40 40 00 00 00 00 00 37 46 28 28 55 00 00    ``@@.....7F((U..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 88    ...............?
40: 7f 7f 9e 00 00 00 00 00 01 56 53 35 31 32 4d 42    ???.....?VS512MB
50: 34 30 30 20 20 20 20 20 20 20 20 00 00 00 00 00    400        .....
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


# i2cdump 0 0x53
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c/0, address 0x53, mode byte
Continue? [Y/n]
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 07 0d 0a 02 40 00 04 50 60 00 82 08 00 01    ??????@.?P`.??.?
10: 0e 04 08 01 02 20 00 00 00 00 00 3c 28 3c 28 40    ????? .....<(<(@
20: 60 60 40 40 00 00 00 00 00 37 46 28 28 55 00 00    ``@@.....7F((U..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ce    ...............?
40: 7f 7f 9e 00 00 00 00 00 01 56 53 35 31 32 4d 42    ???.....?VS512MB
50: 34 30 30 20 20 20 20 20 20 20 20 00 00 00 00 00    400        .....
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



So at 0x49 at those ram-info entrys we see to have the string describing 
the memory-modules. (yes, i got 2x1Gb and 2x512Mb)


amd ~ # i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c/0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 2f
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX 48 49 XX XX XX XX XX XX
50: UU UU UU UU XX XX XX XX XX XX XX XX XX XX XX XX
60: XX 61 XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX

# i2cdetect -l
i2c-0   smbus           SMBus Via Pro adapter at 0400           Non-I2C 
SMBus adapter


NOTE!!
I'm currently switched to the BAD, but better than nothing, Q-fan 
function in bios to reduce the noicelevel a little bit. Everything still 
looks the same from the "sensors" point of view, and i can see that pwm1 
seems to have been reduced by the qfan function.



Hope you can help me, or point me in the right direction.

Regards,
Patric



