From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 08 Dec 2006 06:43:43 +0000
Subject: [lm-sensors] [i2c] M1563 - "Could not allocate I/O space"
Message-Id: <20061208074343.9e8b36e3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Brian,

Please answer to the list rather than to me only.

On Thu, 07 Dec 2006 23:06:46 -0500, Brian Hinz wrote:
> > Well, first of all, keep the base address at 0x8080. Secondly, 0xE is
> > actually 14, not 15 (and 0xF is 15, not 16) so maybe you should try
> > setting the Length to 0x10. Note that I'm not familiar with the DSDT
> > syntax though, so maybe the 4th value is an offset and not the region
> > length, in which case 0xF would be correct correct.
> 
> Heh, that's embarrassing...  Yeah, so if I had actually thought about it I 
> would have realized that the i2c driver is requesting 0x10 @ 0x8080, while 
> the bios is reserving 0x0E @ 0x8080.  So obviously you're right, the length 
> in the dsdt should be increased.

OK. Can you please tell us the brand and model name of the affected
laptop for reference? So that we can help other users affected by the
problem. I suggest that you report the issue to the laptop manufacturer
and ask them for a BIOS update (assuming it is not already available -
did you check that?)

-- 
Jean Delvare

