From: tandrews@grok.co.za (Thomas Andrews)
Date: Fri, 12 May 2006 18:22:33 +0000
Subject: [lm-sensors] Support for Fintek F71872F
Message-Id: <20060512182233.GL30963@grok.co.za>
List-Id: <lm-sensors.vger.kernel.org>
References: <4464D0B8.8070203@drzukov.is-a-geek.org>
In-Reply-To: <4464D0B8.8070203@drzukov.is-a-geek.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, May 12, 2006 at 08:15:20PM +0200, Jure Klako??ar wrote:

> I have an Epox 9NPA7I board that uses the F71872F chip. The CVS version 
> of sensors-detect returns:
> 
> Driver `f71805f' (should be inserted):
>   Detects correctly:
>   * ISA bus address 0x0295 (Busdriver `i2c-isa')
>     Chip `Fintek F71872F/FG Super IO Sensors' (confidence: 9)
> 
> However I am unable to successfully insert the f71805f module for the 
> 2.6.16 kernel. How much work still has to be done to support the F71872F 
> chip? I'd be willing to program the support myself, but I would need a 
> few pointers and the necessary documentation.

Having started playing with i2c a couple of weeks ago, I'd say just give
it a try yourself: Rebuild your kernel with i2c debugging enabled, and
then just have a look at dmesg output to see what happens. What I do is
put a bunch of printk messages in the driver, and just watch to see what
happens. It isn't hard to figure it out.

-Thomas

