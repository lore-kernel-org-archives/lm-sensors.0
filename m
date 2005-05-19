From: wathey@salk.edu (Jack Wathey)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: unrecognized thermal sensor
Message-Id: <20030124145915.Y87112-101000@euler.salk.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030124083409.J85775-100000@euler.salk.edu>
In-Reply-To: <20030124083409.J85775-100000@euler.salk.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Mark,

Thanks for the speedy reply.  I also got a speedy reply from the
manufacturer of the board.  The chip is a National Semiconductor LM90.
The data sheet is attached as a pdf file.  The guy at GigaByte said that
the winbond chip is not being used to read the temperature on the new
boards, and that the temperature sensor now being used is a diode inside
the AMD cpu itself.

I seem to remember reading about "LM" chips in the lm_sensors
documentation, so I'm hoping this is one that you will recognize.  Do I
need to change the chip line in the sensors.conf file?  Any other specific
advice would be greatly appreciated.

Thanks again,
Jack

On Fri, 24 Jan 2003, Mark Studebaker wrote:

>
>
> Jack Wathey wrote:
> >
> >
> > If you don't know anything about it, can you tell me what kind of
> > technical questions I need to ask the motherboard manufacturer to be able
> > to solve this problem?
> >
> "what is the manufacturer and part number for temperature sensor chip on you motherboard?"
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: LM90_0214.pdf
Type: application/pdf
Size: 403097 bytes
Desc: 
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030124/e8e21bd7/LM90_0214.pdf
