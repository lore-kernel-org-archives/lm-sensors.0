From: james@evilpenguin.com (J. Bolt)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: Ticket 1552
Message-Id: <200402021128.51167.james@evilpenguin.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040201215112.2227131d.khali@linux-fr.org>
In-Reply-To: <20040201215112.2227131d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Monday 02 February 2004 8:59 am, you wrote:
> [Please CC: the mailing-list on reply.]
>
> Quoting "J. Bolt" <james@evilpenguin.com>:
> > james@plutonium:/usr/src$ sensors
> > w83l785ts-i2c-1-2e
> > Adapter: SMBus nForce2 adapter at 5500
> > temp: 49.00 (temp)
> >   temp_over: 110.00 (temp_over)
>
> Uh-oh. Should display better than that. Patch against lm_sensors 2.8.3
> attached. Care to give it a try?
>

Ok, applied.

w83l785ts-i2c-1-2e
Adapter: SMBus nForce2 adapter at 5500
Algorithm: Unavailable from sysfs
temp:        +51?C  (high =  +110?C)

> I'm also a bit surprised that temp_over is 110 degrees C. According to
> the data sheet, only two values are possible: 85 and 100. I don't give
> much credit to that data sheet, still I'd like to take a closer look to
> your chip, if you don't mind. "i2cdump 1 0x2e" (after unloading the
> w83l785ts driver) should provide the information I am after. You'll
> probably notice XX's in the dump. See below.
>

root@plutonium:/etc/rc.d# i2cdump 1 0x2e
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-1, address 0x2e, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
10: ff ff ff ff XX ff ff ff ff ff ff ff ff ff ff ff    ....X...........
20: 35 36 00 00 00 00 5c 35 00 00 00 ff 00 ff 00 00    56....\5........
30: 00 00 00 00 00 00 00 50 4b 50 4b 00 00 00 00 00    .......PKPK.....
40: 0d 00 00 00 00 80 ff ff ff ff ff ff a3 5c 70 ff    ?....?......?\p.
50: 06 04 03 6e 7f 4b 46 4b 46 00 fa bc ff ff ff ff    ???n?KFKF.??....
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff 00 18 ff ff ff ff ff ff ff ff ff    ......?.........
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff XX ff ff ff ff ff ff ff ff ff ff ff ff ff    ..X.............
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: c9 02 3a 71 39 38 37 33 ff ff ff ff ff ff ff ff    ??:q9873........
f0: ff 2e 00 ff 00 65 00 ff 00 00 ff 00 00 02 ff ff    .....e.......?..

(also @ http://james.evilpenguin.com/i2cdump.png)

> > asb100-i2c-1-2d
> > Adapter: SMBus nForce2 adapter at 5500
> > VCore 1:   +1.76 V  (min =  +1.63 V, max =  +1.81 V)
> > +3.3V:     +3.17 V  (min =  +3.12 V, max =  +3.46 V)
> > +5V:       +4.87 V  (min =  +4.73 V, max =  +5.24 V)
> > +12V:     +11.49 V  (min = +10.76 V, max = +13.19 V)
> > -12V:     -12.01 V  (min =  -0.00 V, max =  -0.00 V)
> > -5V:       -5.04 V  (min =  -0.00 V, max =  -0.00 V)
>
> No min/max limits set for -12V/-5V?
>

I have a problem w/ min/max limits in general since using the asb100 driver 
instead of as99127f. It seems that the hyst/over values aren't retrieved 
properly from my sensors.conf. E.g.

    label temp1 "mb_temp"
    set temp1_over 45
    set temp1_hyst 40

mb_temp:     +21?C  (high =    +0?C, hyst =    +0?C)

Although it doesn't affect everything

    label temp2 "cpu_temp"
    set temp2_over 65
    set temp2_hyst 60

cpu_temp:    +46?C  (high =   +60?C, hyst =   +65?C)

I seem to have the same problem w/ some of the voltage settings (not getting 
the -5v & -12v max/min values)

    label in5 "-12V"
    compute in5 -@ * 3.97 ,  -@ / 3.97
    set in5_max -12 * 0.90
    set in5_min -12 * 1.10

I've attached the asb100-* extract from my sensors.conf file for reference.

> > cpu_fan:  4824 RPM  (min = 1225 RPM, div = 4)
>
> I would set the fan_div to 2 and raise the min to 3000.
>

It's a variable speed smartfan (runs between 1300 & 4800RPM). It seems to work 
best with a divider of 4 and "compute fan1  @/2.12,  2*@".

> > big_fan:  2033 RPM  (min = 1896 RPM, div = 4)
> > psu_fan:  1722 RPM  (min = 1454 RPM, div = 4)
> > mb_temp:     +19?C  (high =    +0?C, hyst =    +0?C)
>
> No limits here either? BTW, this is a very very low temperature you
> have
> here. Where is that system living?
>

See above for my limits problem. The 19C value is the same as reported by the 
BIOS. It's only about 21 degC in here at the moment & I'm pretty sure my 
large fan is blowing on the air temp sensor. On cutting the fan it rises in 
to the low 20s.

> > cpu_temp:    +44?C  (high =   +60?C, hyst =   +65?C)
> > vid:      +1.725 V
> > alarms:
> >
> > Patched fine to 2.6.2, seems to work fine. Does rarely show "-1",
> > although I'm sure that's the fault of the chip itself.
>
> More or less. Other users have reported the problem as well. This is
> caused by the driver being unable to read the temperature register,
> probably because of a bus collision. Maybe your system logs show
> something of that kind? 

Nothing logged, I'll enabled some of the CONFIG_I2C_DEBUG_* options when I 
move from kernel 2.6.2-rc2 to rc3 to apply your 
linux-2.6.2-rc3-i2c-w83l785ts-retries.diff patch.

> Probably Asus' COP feature accesses the chip in
> our back and causes the trouble, but it doesn't seem to be something we
> can disable, so we'll have to cope (ah ah) with it.
>
> Simply returning -1 isn't nice from us, nevertheless. There are several
> other things that could be done:
> - Notify the error (i.e. reading from the sysfs file returns an error),
> then return the last known good value, if we have one.
> - Retry reading the register until we succeed or reach a limit count.
>
> We usually ignore read errors in chip drivers because they are rare, but
> since it happens so frequently with that specific chip, we will have to
> do it here. I will try to implement the solutions listed above, if you
> want to help me test them.

Will apply that patch in a second... 

J. Bolt

-- 
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.2.4 (GNU/Linux)

mQGiBD7s3PIRBAC2KWjpIG0YfRLgIHUxBrFQmTiIq0yQlaBa7vgjSkKroEtvSjBS
sk5N9NE0y92rGa7C2pfG0w1/rmEghyTLRRfUKyXAnLr/jE6QEnT4yIN+4mRodwZg
bDlSML0AQ09JUv+QBidGtd1kH01lvRdnbCvsMyMNmsp6ryS6pneRKJQ7AwCgyR5I
0rkR4s+sGE3OIfgkw2z5PIUEAKST5r8Lg07T4FSWdOE/EtwX3Xe4vWGBayZKHh0t
A2U8IbaMMLhVHk9g7c3jZ6ptIJqY3yWpp26A+kZNTk53wohnmawtLFEs1HLgFeRc
ppJMNB7TgpyVWUTTYLtZ5GCeA4A67Iq8+CaqX4Tf7Dq1X9dgyUR+b64ajJFd/igt
F/TQA/9zemvSCw1iGgjK+X3WCiAmeYpI9CT6r+XcNkjNI07EpcJyb6upsClLPgqr
Gpc5O6fv+1zmD409xwTi/1QykogkyeYoNbMVnG35ZQ2K5702HA9ZF6lWXLNU3Rho
/q8nRnqgpj8re6koAiQZfNatEAD5x0zktEfWC4N6DQDUCM9RdrQiSmFtZXMgQm9s
dCA8amFtZXNAZXZpbHBlbmd1aW4uY29tPohXBBMRAgAXBQI+7NzyBQsHCgMEAxUD
AgMWAgECF4AACgkQzRkMO5+4Zu3ljQCfVCXWrTxkP1UdtYe+Kfa/4w4h0SAAoI0o
QYXKsXvXHDDw1GgxAD4DvH+1uQENBD7s3PIQBADQkIB2Ml9tAPNOk1BhbdpSF1oM
8XYkHpzA8IviczaDqr/ArSPfbkoxyDr165T+hhqGx+zhQSpJ2re7L4tsLpZvojUW
LEH65rUZ5OJNKUt4ayAM3MFMZFLfZoUSQoqjkZOvJSZQJGCA6lKTtYnLglJdS7vv
DrqZbHjZIqDlCuHkFwADBQQAiuP4Wfmg950F/UJ4zbup5jn/ABnMasUbd3dmnK5F
nNNiWhE7l4/oEh2zgF6g+3qT9s/7m77nn/ccheuA7TTeO82uLiqWdmde8+l+RMpp
rCa4Gr4bAN5OLzr85dcd31mepYw7CmQG3iiKUCHgSxuBvlR8MXWaWnei3VQPCHeo
veqIRgQYEQIABgUCPuzc8gAKCRDNGQw7n7hm7ZQjAJ0faoGh6Eq4WSxYk1xMf4rC
6/IehwCdH/Tq0Yjis8PDCKZiIKJlqHkJfiE=r11q
-----END PGP PUBLIC KEY BLOCK-----
-------------- next part --------------
chip "asb100-*"
    set vrm 9.0

    label in0 "VCore 1"
    set in0_min vid * 0.95
    set in0_max vid * 1.05

    label in1 "VCore 2"
    ignore in1
    set in1_min vid * 0.95
    set in1_max vid * 1.05

    label in2 "+3.3V"
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05

    label in3 "+5V"
    compute in3 1.68 * @ ,  @ / 1.68
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05

    label in4 "+12V"
    compute in4 3.8 * @ , @ / 3.8
    set in4_min 12  * 0.90
    set in4_max 12  * 1.10

    label in5 "-12V"
    compute in5 -@ * 3.97 ,  -@ / 3.97
    set in5_max -12 * 0.90
    set in5_min -12 * 1.10

    label in6 "-5V"
    compute in6 -@ * 1.666 , -@ / 1.666
    set in6_max -5  * 0.95
    set in6_min -5  * 1.05

    label temp1 "mb_temp"
    set temp1_over 45
    set temp1_hyst 40

    label temp2 "cpu_temp"
    set temp2_over 65
    set temp2_hyst 60

    # PWRTMP connector on P4S333, for external sensor
    ignore temp3
    label temp3 "Power Temp"
    set temp3_over 60
    set temp3_hyst 65

    # Used for Athlon diode, ignore for P4S333
    ignore temp4
    label temp4 "CPU Temp (AMD)"
    set temp4_over 60
    set temp4_hyst 50

    label fan1 "cpu_fan"
    set fan1_div 4
    set fan1_min 1300

    label fan2 "big_fan"
    set fan2_div 4
    set fan2_min 1900

    label fan3 "psu_fan"
    set fan3_div 4
    set fan3_min 1450

    compute fan1  @/2.12,  2*@
    compute fan2  @/2,     2*@
    compute fan3  @/2,     2*@
