From: jrclarke@btinternet.com (john)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: CPU temp does not update
Message-Id: <200501251116.14041.jrclarke@btinternet.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200501241750.44403.jrclarke@btinternet.com>
In-Reply-To: <200501241750.44403.jrclarke@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,
Thanks for the very prompt response, which is very much appreciated.
My replies are inline.

Additionally, it may help you to know that if I put  my Mandrake 9.1 
installation into the same machine (I only have one computer - system hard 
drives are mounted in removable trays) sensors all work correctly within 9.1, 
this is using lm_sensors 2.7.0-2mdk and kernel 2.4.21-0.33mdk.

If you need any more information from me, I apologise that I will not be able 
to reply to you until tomorrow as I will be at work and away from my computer 
until after midnight today.

Thanks again
John
On Monday 24 January 2005 19:00, Jean Delvare wrote:
> Hi John,
>
> > I cannot get the CPU temp to update, from  cold (after being powered
> > down  overnight for example) sensors will report a temp of approx
> > 16-17c and it  will not move. If I run for a while and reboot, CPU
> > temp will then show  something like 45-50c and again it will not move.
> > In both cases this is  similar to the temp reported by BIOS as the
> > system boots. I think I have shown the relevant information below.
> >
> > Any suggestions will be gratefully received.
>
> You configuration looks OK. I would like you to test and answer the
> following:
>
> 1* Do the voltage and fan speeds change? IOW, is the whole chip stuck or
> only the temperature channels?
Yes, voltage & fan speeds do change, also sytem temp (temp1) does change.
It is only CPU (temp2) which sticks.
> 2* If you sit in the BIOS, can you see the temperatures change, or not?
Yes, temperature does change
> 3* If you unload and reload the w83627hf driver, do the temperatures
> (sometimes) change?
I'm not completely sure what you need me to do, so I have rmmod w83627hf and 
then modprobe w83627hf, issued service lm_sensors restart and then run 
sensors, the CPU temp does not change.
> 4* Please provide a dump of the chip (isadump 0x295 0x296).
>
# isadump 0x295 0x296
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x295 and data register 0x296.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 01 ff 01 ff 00 00 00 00 01 01 01 01 3c 3c 0a 0a
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: 68 00 cf b7 ce 12 30 19 d1 ff ff 76 6b 00 04 d9
30: c4 c3 b1 d9 b2 32 15 3b 31 28 25 40 03 00 00 00
40: 01 00 00 00 00 00 00 57 1f 02 89 c4 54 95 00 a3
50: ff ff 00 ff ff ff 00 00 60 70 ff ff 11 01 ff 05
60: 68 00 cf b7 ce 12 30 19 d1 ff ff 76 6b 00 04 d9
70: c4 c3 b1 d9 b2 32 15 3b 31 28 25 40 03 00 00 00
80: 01 ff 01 ff 00 00 00 00 01 01 01 01 3c 3c 0a 0a
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: 68 00 cf b7 ce 12 30 19 d1 ff ff 76 6b 00 04 d9
b0: c4 c3 b1 d9 b2 32 15 3b 31 28 25 40 03 00 00 00
c0: 01 00 00 00 00 00 00 57 1f 02 89 c4 54 95 00 a3
d0: ff ff 00 ff ff ff 00 00 60 70 ff ff 11 01 ff 05
e0: 68 00 cf b7 ce 12 30 19 d1 ff ff 76 6b 00 04 d9
f0: c4 c3 b1 d9 b2 32 15 3b 31 28 25 40 03 00 00 00


