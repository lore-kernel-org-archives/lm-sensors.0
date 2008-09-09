From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Sep 2008 16:08:56 +0000
Subject: Re: [lm-sensors] i2c output info
Message-Id: <20080909180856.5cf2c123@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dean,

Please keep the lm-sensors list Cc'd.

On Mon, 08 Sep 2008 19:00:52 -0700, Dean Loros wrote:
> Hi Jean--
> 
> I've identified AUX fan as my front intake fan, fan4 as my rear exhaust
> fan, CPU fan is correct & Case fan is running one of my two video card
> fans. The motherboard has 6 fan connections, so I would assume that
> there is another chip running at least one fan connector & as I can't
> see the other video card--I would guess that the w83627ehf runs four
> outputs?

I would be surprised if the W83627DHG can actually monitor your video
card's fan. For that, the fan in question would have to be connected to
the motherboard rather than the video card it cools. This seems
unlikely.

It is indeed possible that there's another monitoring chip on your
motherboard. Also, I have checked sensors-detect and the changes I
wanted to make to prevent the misdetection you experienced, happens to
be done there already. This make me suspect that you have been running
an old version of sensors-detect. Could you please try the latest
version?
http://www.lm-sensors.org/browser/lm-sensors/branches/lm-sensors-3.0.0/prog/detect/sensors-detect?format=txt

Unload the hardware monitoring drivers before running it. It should no
longer suggest that you load the lm78 driver. And maybe it will see
another monitoring chip.

> 
> The nForce SPP Fan speed I can only see in the BIOS--don't know where
> it's speed is--
> 
> Any more info you need?
> 
> Terminal data follows:
> 
> dean@linux:~/Desktop$ sudo rmmod w83627ehf
> [sudo] password for dean:
> dean@linux:~/Desktop$ sudo modprobe i2c-dev
> dean@linux:~/Desktop$ sudo isadump 0x295 0x296
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address register 0x295 and data register 0x296.
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 04 ff 04 40 31 00 1e 50 01 02 01 02 3c 3c 0a 0a
> 10: 04 01 50 00 00 01 01 3c 43 07 00 00 ff ff ff c0
> 20: a0 82 d0 d0 a0 c2 e5 5a e0 20 9a cb 88 cb 74 d9
> 30: 90 ff db ff fe 00 00 00 01 00 7f fe 54 0f b9 68
> 40: 01 10 10 ff ff ff 07 15 2d 00 40 c4 18 15 01 a3
> 50: 25 00 02 00 00 7f 05 e0 ff ff ff ff ff ff ff ff
> 60: 04 40 33 1e 02 02 3c ff 1f ff 1f ff ff ff ff ff
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 80: 04 ff 04 40 31 00 1e 50 01 02 01 02 3c 3c 0a 0a
> 90: 04 01 50 00 00 01 01 3c 43 07 00 00 ff ff ff c0
> a0: a0 82 d0 d0 a0 c2 e5 5a e0 20 9a cb 88 cb 74 d9
> b0: 90 ff db ff fe 00 00 00 01 00 7f fe 54 0f b9 68
> c0: 01 00 10 ff ff ff 07 15 2d 00 40 c4 18 15 01 a3
> d0: 25 00 02 00 00 7f 05 e0 ff ff ff ff ff ff ff ff
> e0: 04 40 33 1e 02 02 3c ff 1f ff 1f ff ff ff ff ff
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> dean@linux:~/Desktop$ sudo i2cdump 1 0x2d b
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-1, address 0x2d, mode byte
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 04 ff 04 40 31 00 1e 50 01 02 01 02 3c 3c 0a 0a    ?.?@1.?P????<<??
> 10: 04 01 50 00 00 01 01 3c 43 07 00 00 ff ff ff d8    ??P..??<C?.....?
> 20: a0 83 d0 d0 a0 c2 e6 5a e1 21 99 cb 88 cb 74 d9    ???????Z?!????t?
> 30: 90 ff db ff fe 00 00 00 01 00 7f fe 54 0f b9 68    ?.?.?...?.??T??h
> 40: 01 10 10 ff ff ff 07 15 2d 00 40 c4 18 15 01 a3    ???...??-.@?????
> 50: 24 80 02 00 00 7f 05 e0 ff ff ff ff ff ff ff ff    $??..???........
> 60: 04 40 33 1e 02 02 3c ff 1f ff 1f ff ff ff ff ff    ?@3???<.?.?.....
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 80: 04 ff 04 40 31 00 1e 50 01 02 01 02 3c 3c 0a 0a    ?.?@1.?P????<<??
> 90: 04 01 50 00 00 01 01 3c 43 07 00 00 ff ff ff c6    ??P..??<C?.....?
> a0: a0 83 d0 d0 a0 c2 e5 5a e0 20 99 cb 88 cb 74 d9    ???????Z? ????t?
> b0: 90 ff db ff fe 00 00 00 01 00 7f fe 54 0f b9 67    ?.?.?...?.??T??g
> c0: 01 10 10 ff ff ff 07 15 2d 00 40 c4 18 15 01 a3    ???...??-.@?????
> d0: 24 80 02 00 00 7f 05 e0 ff ff ff ff ff ff ff ff    $??..???........
> e0: 04 40 33 1e 02 02 3c ff 1f ff 1f ff ff ff ff ff    ?@3???<.?.?.....
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

I guess you will trust me that both dumps correspond to the same
device. All register values are the same.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
