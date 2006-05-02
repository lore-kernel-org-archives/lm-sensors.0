From: alexander.krause@erazor-zone.de (Alexander Krause)
Date: Tue, 02 May 2006 14:08:36 +0000
Subject: [lm-sensors]  Address configuration for scx200_acb
Message-Id: <200605021608.37024.alexander.krause@erazor-zone.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060427234114.941c9657.khali@linux-fr.org>
In-Reply-To: <20060427234114.941c9657.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

>static void detect_acb_base_addresses(int *acb1, int* acb2)
>{
>    unsigned char h1 = 0;
>    unsigned char l1 = 0;
>    unsigned char h2 = 0;
>    unsigned char l2 = 0;
>
>    /* Select ACB1  (LDN 5) */
>    outb(0x07,CFG_INDEX);
>    outb(0x05,CFG_DATA);
>    outb(0x60,CFG_INDEX);
>    h1 = inb(CFG_DATA);
>    outb(0x61,CFG_INDEX);
>    l1 = inb(CFG_DATA);
>
>    /* ACB2 (LDN 6) */
>    outb(0x07,CFG_INDEX);
>    outb(0x06,CFG_DATA);
>    outb(0x60,CFG_INDEX);
>    h2 = inb(CFG_DATA);
>    outb(0x61,CFG_INDEX);
>    l2 = inb(CFG_DATA);
>    *acb1 = (h1 << 8) | l1;
>    *acb2 = (h2 << 8) | l2;    
>    DEBUG(1,printk("ACB1 at %x, ACB2 at %x",*acb1,*acb2));
>}
is there any patch against the last kernel containing this function?
Well, i would write one if not and i could test it on my WRAP board (sc1100 
processor).

>Would this not work for the whole family ?
I'm not sure which devices uses scx200_acb and i can't imagine autodetection 
works on each one.
Maybe the module should try autodetection at first and uses static base 
addresses if it failed. 
And autodetection should be dissabled if there is any kernel parameter like 
scx200_acb.base=0x???,0x???

...just some thoughts.

cheers Alex
-- 
Alexander Krause
Amtmann-K?stner-Platz 11
99091 Erfurt

Mail alexander.krause at erazor-zone.de
Tel. +49 (179) 4725826

