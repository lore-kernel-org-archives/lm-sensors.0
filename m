From: ericb@aspsys.com (Eric J. Bowersox)
Date: Fri, 08 Jul 2005 00:22:15 +0000
Subject: [lm-sensors] W83792D & Overtemperature LED on Supermicro
Message-Id: <1120774860.28604.18.camel@wiz.dev.aspsys.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1120167411.32695.31.camel@wiz.dev.aspsys.com>
In-Reply-To: <1120167411.32695.31.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Gentlemen, thank you for your responses.  Unfortunately, none of them
seem to have made a difference.

On Thu, 2005-07-07 at 13:19, Jean Delvare wrote: 
> This suggests that some voltages and fan readings are out of range
> (namely fan3, 5vcc and fan4). So maybe your overtemperature LED is
> reacting to more than just overtemperatures but also to other out of
> range conditions. Please try fixing all voltages and fans, and see if it
> helps.
> 
> Remember that adding "ignore" lines in sensors.conf does NOT disable the
> associated channel and alarm, it merely hides it to you. So please
> remove all ignore statements and make sure they were not hiding alarms.

I set all unused "fan" channels to a minimum RPM of 0 and all three
temperature channels to a high of 70 and hysteresis of 60 (highest
actual reading of the three was 54).  Still blinking.


On Thu, 2005-07-07 at 13:26, Jean Delvare wrote: 
> Another thing here, see these lines in the patch:
> 
> +	/* Start monitoring */
> +	w83792d_write_value(client, W83792D_REG_CONFIG,
> +			    (w83792d_read_value(client,
> +						W83792D_REG_CONFIG) & 0xf7)
> +			    | 0x01);
> 
> I believe that the mask should be 0x7e, rather than 0xf7. Could you
> please change that and see if it helps?
> 
> Thanks,

Changed that line, tried the new module.  Still blinking.

On Thu, 2005-07-07 at 14:10, Rudolf Marek wrote: 
> It seems the chip was reset. If the first dump is really after reboot and second is really when the driver loads I must admit it is strange.
> Please can you change
> 
> static int init;
> to
> static int init=0;
> 
> Maybe your kernel is not cleaning global data area...

Tried that too.  Still blinking.

FYI, I can confirm that, at system reset time, the light is NOT blinking, and
that it is the action of loading the w83972d driver that causes the light to
start blinking (i.e. "modprobe w83792d" and blinks happen right then).

These dumps were taken with the driver with both patches loaded.  Before:

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 64 64 93 00 00 13 00 ff 00 00 05 00 00 b3    ..dd?..?....?..?
20: a8 a9 d1 bd 1e c8 d3 2b 25 26 ff af 96 af 96 e2    ???????+%&.?????
30: b9 ce a8 2f 13 d9 b1 cc a7 50 4b ed ed ed 1f a6    ???/?????PK?????
40: 03 00 20 9f 7f ff ff 33 2f 13 88 80 07 ff 80 5c    ?. ??..3/????.?\
50: ff ff ff ff ff ff ff ff 7a 30 ff 33 33 01 05 7f    ........z0.33???
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff 88 ff 88 0a 1e 1e 55 88 88 ff ff 00 00 0a 0a    .?.????U??....??
90: 36 36 00 01 8f ff 00 00 11 ff 3c 00 ff 01 01 ff    66.??...?.<..??.
a0: 01 01 01 8f 8f 8f 8f ff 3c 80 30 68 ff ff 00 00    ???????.<?0h....
b0: cf cd ff ff cc a7 e2 b9 ff ff ff ed ed ff ff ff    ??..????...??...
c0: 2c 00 00 4b 00 50 00 ff 2b 80 00 28 00 3c 00 ff    ,..K.P..+?.(.<..
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: af af 8b 3c 46 7f 3c 46 7f 28 3c 50 ff ff ff ff    ???<F?<F?(<P....
f0: ff ff 80 ff 00 01 00 00 ff 02 ff 00 00 00 00 ff    ..?..?...?......

After:

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 64 64 93 00 00 13 00 ff 00 00 05 00 00 b3    ..dd?..?....?..?
20: a8 a9 d2 be 1e c8 d4 2f 78 81 ff af 96 af 96 e2    ???????/x?.?????
30: b9 ce a8 2f 13 d9 b1 cc a7 50 4b ed ed ed 33 ba    ???/?????PK???3?
40: 01 80 30 00 00 ff ff 11 2f 13 03 80 07 ff 80 5c    ??0....?/????.?\
50: ff ff ff ff ff ff ff ff 7a 60 ff 11 11 01 05 7f    ........z`.?????
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: 01 8f 01 8f 00 00 00 00 11 11 ff ff 3c 3c 0a 0a    ????....??..<<??
90: 00 00 00 01 8f ff 00 00 11 ff 3c 00 00 01 01 ff    ...??...?.<..??.
a0: 01 01 01 8f 8f 8f 8f ff 3c 80 30 68 ff ff 00 00    ???????.<?0h....
b0: cf cd ff ff cc a7 e2 b9 ff ff ff ed ed ff ff ff    ??..????...??...
c0: 36 00 00 4b 00 50 00 ff 10 80 00 28 00 3c 00 ff    6..K.P..??.(.<..
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: 8b 8b 8b 28 3c 50 28 3c 50 28 3c 50 ff ff ff ff    ???(<P(<P(<P....
f0: ff ff 00 ff 00 01 00 00 ff 02 ff 00 00 00 00 ff    .....?...?......

Any more ideas?  Our production engineer is happy for any assistance
you may have to offer in this matter.

					Eric

-- 
Eric J. Bowersox, Software Engineer     Aspen Systems, Inc.
<ericb@aspsys.com>                      3900 Youngfield Street
Tel: +01 303 431 4606 x113              Wheat Ridge, CO  80033, USA
Fax: +01 303 431 7196                   <http://www.aspsys.com>

