From: tandrews@grok.co.za (Thomas Andrews)
Date: Wed, 03 May 2006 11:17:44 +0000
Subject: [lm-sensors] Address configuration for scx200_acb
Message-Id: <20060503111744.GC19375@grok.co.za>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060427234114.941c9657.khali@linux-fr.org>
In-Reply-To: <20060427234114.941c9657.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alex,

On Tue, May 02, 2006 at 04:08:36PM +0200, Alexander Krause wrote:

> >static void detect_acb_base_addresses(int *acb1, int* acb2)
> >{
> >    unsigned char h1 = 0;
> >    unsigned char l1 = 0;
> >    unsigned char h2 = 0;
> >    unsigned char l2 = 0;
> >
> >    /* Select ACB1  (LDN 5) */
> >    outb(0x07,CFG_INDEX);
> >    outb(0x05,CFG_DATA);
> >    outb(0x60,CFG_INDEX);
> >    h1 = inb(CFG_DATA);
> >    outb(0x61,CFG_INDEX);
> >    l1 = inb(CFG_DATA);
> >
> >    /* ACB2 (LDN 6) */
> >    outb(0x07,CFG_INDEX);
> >    outb(0x06,CFG_DATA);
> >    outb(0x60,CFG_INDEX);
> >    h2 = inb(CFG_DATA);
> >    outb(0x61,CFG_INDEX);
> >    l2 = inb(CFG_DATA);
> >    *acb1 = (h1 << 8) | l1;
> >    *acb2 = (h2 << 8) | l2;    
> >    DEBUG(1,printk("ACB1 at %x, ACB2 at %x",*acb1,*acb2));
> >}
> is there any patch against the last kernel containing this function?
> Well, i would write one if not and i could test it on my WRAP board (sc1100 
> processor).

Not currently, but I will have one ready in roughly a week. The delay is
because I am actually modifying an older version suitable for the 2.4
kernel. On my WRAP platform I don't yet have a suitable 2.6 kernel for
testing it. If you want a patch urgently to try out, I can perhaps make
one, but I'll have to rely on you to test it.

Regards,
Thomas

