From: daniel.n.nilsson@home.se (Daniel Nilsson)
Date: Mon, 28 Nov 2005 18:50:01 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20051128174836.GA9531@oden.homeip.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

Thanks for the help to far! I have some new data to show...

On Mon, Nov 28, 2005 at 10:40:44AM +0100, Rudolf Marek wrote:
> > I tried executing 'setpci  -s 0:1f.3 40.b=1', that command completed
> > without complaining but I didn't see any difference in the
> > behaviour. But I don't know how to verify that the setpci command
> > actually did what you were expecting it to do.
> 
> This just disables the smbalert signal. Maybe the output from a chip is routed
> to other pin. Please can you provide the dump after cold boot and BEFORE loading
> the w83792d driver?
> 
> i2cdump 0 0x2c

Ok, after a cold boot and before loading the driver:

oden:~# i2cdump 0 0x2c
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x2c, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 64 64 bf 00 00 63 00 ff 04 00 f5 00 8f 80    ..dd?..c..?.?.??
20: d3 d4 b9 b8 b8 b9 cd 17 41 ff 75 ff 00 96 64 d7    ????????A.u..?d?
30: af d9 b1 d9 b1 d7 af ff 00 25 00 f0 f0 f0 bf bf    ???????..%.?????
40: 03 00 00 00 70 ff ff bb 2c 13 40 c3 51 ff 80 5c    ?...p..?,?@?Q.?\
50: ff ff ff ff ff ff ff ff 7a 40 ff bb bb c1 05 7f    ........z@.?????
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: 81 8f 81 8f 00 00 00 00 11 11 ff ff 3c 3c 0a 0a    ????....??..<<??
90: 00 00 00 81 8f ff 00 00 11 ff 3c 00 0f 01 01 ff    ...??...?.<.???.
a0: 81 81 81 8f 8f 8f 8f ff 3e 42 00 e0 ff ff 00 00    ???????.>B.?....
b0: d3 ca ff ff ff 00 e2 b9 ff ff ff f0 f0 f0 00 ff    ??....??...???..
c0: 28 80 02 39 00 3c 00 ff 2e 80 00 5d 00 60 00 ff    (??9.<...?.].`..
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: 8b 8b 8b 28 3c 50 28 3c 50 28 3c 50 ff ff ff ff    ???(<P(<P(<P....
f0: ff ff 00 ff 00 01 00 00 ff 02 ff 00 00 00 00 ff    .....?...?......

> 
> We have a patch from Yuan, I hope it is not malformed by my stupid mail client.
> [snip]
> Because fan6 and fan7 - mean their pins are programmable so correct
> would be to create their files when they actual outputs are really
> used for fans...

I applied the patch, the only real difference I can see is that the
/sys/bus/i2c/devices/0-002c/fan7_* nodes are no longer created. But
the system hangs just the same anyway, the only difference is that no
write to fan7_* limits is happening:

Setting /sys/bus/i2c/devices/0-002c/in8_min to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in7_min to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in6_min to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in5_min to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in4_min to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in3_min to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in2_min to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in1_min to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in0_min to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in8_max to 10000 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in7_max to 10000 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in6_max to 10000 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in5_max to 10000 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in4_max to 10000 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in3_max to 10000 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in2_max to 10000 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in1_max to 10000 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/in0_max to 10000 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/temp3_max to 100000 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/temp2_max to 100000 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/temp1_max to 100000 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/temp3_max_hyst to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/temp2_max_hyst to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/temp1_max_hyst to 0 , sleeping 1s...ok.
Setting /sys/bus/i2c/devices/0-002c/fan6_min to 0 , <system hangs>

Regards
-- 
Daniel Nilsson
