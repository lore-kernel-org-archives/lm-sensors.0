From: tonu@jes.ee (Tonu Samuel)
Date: Fri, 07 Oct 2005 14:52:07 +0000
Subject: [lm-sensors] SE95 patch - some questions
Message-Id: <200510071527.54004.tonu@jes.ee>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

I am writing support for Philips SE95 temperature sensor which is very similar 
to LM75 but has much higher precision. Because it is my first try with 
lm_sensors I came to different dead ends and now again in doubt.

Because lm75 and se95 are very similar I ended up in modifying lm75.c code 
instead of making one more copy of it. Patch against 2.6.14-pre3 is there:

http://www.jes.ee/~tonu/se95.patch

This patch actually works for SE95 and I hope I did not broke LM75 either. I 
have LM75 in house, so I later check it anyway.

Main difference between LM75 and SE95 is precision (9 vs 13 bits of data). I 
want to reuse as much possible of lm75 code but still avoid floating point 
arithmetics and such. Please take a look and tell what way to go. My 
questions (pretty related to each other):

1. Should I introduce value "precision" in bits in code or just have separate 
   hardcoded formulas for lm75 and se95?
2. Any more sensors which may be added here?
3. Maybe I should go back and implement se95 code in separate file at all?
4. I haven't searched hard but can I use value "kind" somehow to distinguish
    between different sensors? How? Probably I just grep around and find it
    myself too :)

Some output:

lm75-i2c-0-4f
Adapter: SMBus PIIX4 adapter at 5000

temp:      +19.4?C  (high = +80.0?C, hyst = +75.0?C)


next second:

lm75-i2c-0-4f
Adapter: SMBus PIIX4 adapter at 5000

temp:      +19.5?C  (high = +80.0?C, hyst = +75.0?C)

Ouch, were I can increase decimals? We need few more for that sensor :)

   Tonu
