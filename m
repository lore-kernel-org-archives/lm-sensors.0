From: cilly <cilly@cilly.mine.nu>
Date: Fri, 27 Jul 2007 21:33:32 +0000
Subject: Re: [lm-sensors] VT1211: wrong vid, vcore
Message-Id: <DB3036CF-CAFA-4768-B90C-895B10540AA3@cilly.mine.nu>
List-Id: <lm-sensors.vger.kernel.org>
References: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
In-Reply-To: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Jul 27, 2007, at 5:48 AM, Juerg Haefliger wrote:

> Hmm... That doesn't make sense. What happens if you do 'isaset -y -f
> 0x6051 0x08'? Does the fan turn off? If yes, can you turn it back on
> with 'isaset -y -f 0x651 0x00'?

freshly bootet system:

# isaset -y -f 0x6051 0x08

fan still running

# isadump -y -f 0x6000 0x80
        0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
6000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f 08
6010: 03 10 0d 41 8c 06 46 01 00 00 00 00 02 74 6f 6c
6020: 6e bf c1 78 bd c4 c9 7f 72 72 00 ce ba 7b 74 ce
6030: a9 d6 af d4 c0 72 07 14 7b 93 8e ff ff c9 b6 b0
6040: 01 00 00 ff ff e0 ff 50 2d 45 03 55 55 00 0f 00
6050: 01 08 00 00 00 00 ff ff ff ff ff ff 00 77 11 33
6060: ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
6070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

# isaset -y -f 0x651 0x00
Data mismatch, wrote 0x00, read 0xff back.

# isadump -y -f 0x6000 0x80
        0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
6000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f 08
6010: 03 10 0d c3 83 06 46 86 00 00 00 00 02 74 6f 6c
6020: 6e bf c1 78 bd c4 c9 7f 72 73 00 ce ba 7b 74 ce
6030: a9 d6 af d4 c0 72 07 14 7b 93 8e ff ff c9 b6 b0
6040: 01 00 00 ff ff e0 ff 50 2d 85 03 d5 55 00 0f 00
6050: 01 08 00 00 00 00 ff ff ff ff ff ff 00 77 11 33
6060: ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
6070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

now, what to do? --- reboot

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
