From: vz-sensors@zeitlins.org (Vadim Zeitlin)
Date: Thu, 11 Jan 2007 17:13:28 +0000
Subject: [lm-sensors] FB-DIMM temperature
Message-Id: <E1H53UW-0006kr-00@smtp.tt-solutions.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45A65914.6040302@assembler.cz>
In-Reply-To: <45A65914.6040302@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 11 Jan 2007 17:57:38 +0100 Rudolf Marek <r.marek at assembler.cz> wrote:

RM> The 0x111d signature is company called IDT. They manufacture IDTAMB0480
RM> which may be used there.

 FWIW the FB-DIMMs are 1GB PC5300 modules manufactured by Samsung but I
don't have the model number at hand (but I could look it up).

RM> Question is if the register layout is same as in intel AMB
RM> 
RM>  http://www.intel.com/design/chipsets/datashts/313072.htm

 Thanks for the link! I didn't find anything as detailed about IDTAMB0480
though, all I could find was this:

    http://www.idt.com/products/files/6186383/AMB0480_product_brief.pdf

Astonishingly, at least to me, the max temperature for these things seems
to be 124C: see page 12 of the above link or section 3.3.1 at page 25 of
http://download.intel.com/design/chipsets/designex/31306603.pdf

 Do I really understand this correctly? Or should it be divided by 2?

 I'll read Intel datasheets a bit more tonight, I'm sure they're ideal
bed-side reading ;-)

 Regards,
VZ


