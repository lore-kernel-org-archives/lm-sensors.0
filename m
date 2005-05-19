From: Michael.Madore@aslab.com (Michael Madore)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: Ticket #: 1737
Message-Id: <1096388884.26544.32.camel@drevil.aslab.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1096310877.11070.6.camel@drevil.aslab.com>
In-Reply-To: <1096310877.11070.6.camel@drevil.aslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Yes, upon inspecting the motherboard there is a W83792D chip.  In
addition, there is also a W83791SD device.  Can you tell from the i2c
dump what the chip ID for the W83792D is?  I can try adding it to the
w83781d driver and see if I get lucky. :-)  

Thanks for your help.

Mike

On Tue, 2004-09-28 at 01:50, Jean Delvare wrote:
> On Mon, 27 Sep 2004 14:02:04 -0700, Michael Madore wrote
> > Let's try that again. :-)
> > 
> > Mike
> 
> The chip at I2C addressed 0x2f/0x48/0x49 looks like a Winbond W83792D. The
> user's manual of the Asus NCCH-DL [1] confirms that. If you have visual access
> to the board, you may take a look and confirm too.
> 
> We don't support this chip yet. Winbond did not release a datasheet for it.
> All we could do is add detection support in sensors-detect, but that's about it.
> 
> With a little bit of luck, the W83792D may be somewhat compatible with the
> W83791D, which is supported by our w83781d driver under 2.4, but not under 2.6
> (I can't tell why). Unfortunately you seem to be using 2.6.
> 
> The W83792D is obviously the main hardware monitoring chip on your
> motherboard, which is why you couldn't get any fan readings from your
> secondary chip (W83627THF).
> 
> I'll update the ticket with this information.
> 
> The chip at 0x290 is obviously the W83627THF, so the IT87xx had to be a
> misdetection.
> 
> Thanks for reporting.
> 
> [1] http://www.asus.com/pub/ASUS/mb/Socket604/NCCH-DL/e1636_ncch-dl.pdf
