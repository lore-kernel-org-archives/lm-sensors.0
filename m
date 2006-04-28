From: tandrews@grok.co.za (Thomas Andrews)
Date: Fri, 28 Apr 2006 06:47:32 +0000
Subject: [lm-sensors] Address configuration for scx200_acb
Message-Id: <20060428064732.GA14420@grok.co.za>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060427234114.941c9657.khali@linux-fr.org>
In-Reply-To: <20060427234114.941c9657.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Apr 27, 2006 at 11:41:14PM +0200, Jean Delvare wrote:

> Can you please comment on this?
> http://bugzilla.kernel.org/show_bug.cgi?idd45#c15
> 
> This is a propsal to make the scx200_acb driver's default base
> addresses configurable through Kconfig. What do you think?
> 
> Another possibility would be to detect them at runtime depending on
> some platform data. Sounds more complex, if possible at all.
> 
> Or we can stick to the current state (default addresses, can be
> overriden with module parameters).
> 
> What makes the current default addresses (0x820 and 0x840) more
> legitimate than what Alexander has (0x810 and 0x820)?

I've been wondering about this myself. I also use the wrap boards, and
I've found that the address can be automatically set using something
like this:

static void detect_acb_base_addresses(int *acb1, int* acb2)
{
    unsigned char h1 = 0;
    unsigned char l1 = 0;
    unsigned char h2 = 0;
    unsigned char l2 = 0;

    /* Select ACB1  (LDN 5) */
    outb(0x07,CFG_INDEX);
    outb(0x05,CFG_DATA);
    outb(0x60,CFG_INDEX);
    h1 = inb(CFG_DATA);
    outb(0x61,CFG_INDEX);
    l1 = inb(CFG_DATA);

    /* ACB2 (LDN 6) */
    outb(0x07,CFG_INDEX);
    outb(0x06,CFG_DATA);
    outb(0x60,CFG_INDEX);
    h2 = inb(CFG_DATA);
    outb(0x61,CFG_INDEX);
    l2 = inb(CFG_DATA);
    *acb1 = (h1 << 8) | l1;
    *acb2 = (h2 << 8) | l2;    
    DEBUG(1,printk("ACB1 at %x, ACB2 at %x",*acb1,*acb2));
}

Would this not work for the whole family ?

Regards,
Thomas

