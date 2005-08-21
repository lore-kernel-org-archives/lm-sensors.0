From: tero.saarni@gmail.com (Tero Saarni)
Date: Sun, 21 Aug 2005 11:09:59 +0000
Subject: [lm-sensors] SMBus not detected on SiS 964 south bridge
Message-Id: <ad348feb05082102096133a161@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <dctehc$g25$2@sea.gmane.org>
In-Reply-To: <dctehc$g25$2@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On 8/10/05, Mark M. Hoffman <mhoffman@lightlink.com> wrote:
> * Tero Saarni <tero.saarni@gmail.com> [2005-08-04 19:08:16 +0300]:
> > I now get "Enabling SiS 96x SMBus." in kernel log i.e. quirks.c
> > now seems to try enable SMBus but lspci still doesn't show SMBus.
>
> I have no idea, sorry.  I traced the IO of an Asus hardware monitoring program
> in order to figure out that quirk code.  Yours is the first 96x I've heard of
> for which it doesn't work - bummer.  Does DFI provide a hardware monitoring app?
> Can you fire it up inside Wine and capture the IO it performs?

DFI doesn't provide software for hardware monitoring for this board.  I mailed
them asking about it and they replied:

  "The 661FX-MLV is a cost-down board that does not support these 
   functions, as they are simply not present in the BIOS"

I suppose that might mean that the hardware does not exist or just that
the support is disabled (which quirks.c tries to work around?).  Maybe 
there really is versions of SiS964 chip without SMBus?

I tried couple of third party Windows apps with hardware monitoring features
(HWiNFO32 and SiSoft Sandra pro) but nothing came out of it, which was 
expected I guess...

Best regards,
Tero
