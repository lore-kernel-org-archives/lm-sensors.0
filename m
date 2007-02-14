From: riwright@vt.edu (Rick Wright)
Date: Wed, 14 Feb 2007 19:26:57 +0000
Subject: [lm-sensors] Abit AT8 (non-32X) / Winbond 83627EHF
Message-Id: <45D36281.7030509@vt.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D0A4B2.6030002@vt.edu>
In-Reply-To: <45D0A4B2.6030002@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rick Wright wrote:
> 
> I tested this userspace utility and it seems to be more correct, but 
> gives a strange warning in the immediate output that uGuru wasn't found 
> on the motherboard.

Yeah, the detect code needs work, hence the result of the detect is 
ignored and the utility continue as if nothing is wrong :)

>  The manual and BIOS definitely talk about uGuru 
> (TM!), though.
> 
> Output from openguru2.3.1 is attached.  This appears to be correctly 
> reading the chip info.  Running several time in a row gave small 
> fluctuations in fan RPM as one would expect.
> 

Yes, you definitely have an uguru motherboard otherwise openguru would 
be filling the screen with errors instead of usefull readings.

> I just joined the list so I will have to search the archives for your 
> kernel patch & instructions.  (unless you want to resend :) )  Thanks 
> for your help.
> 

I wonder where you want to go next, even if you compile and load the 
kernel module, most applications still won't see the sensors as 
libsensors the userspace part of sensors also requires updating and I 
haven't written a patch for that yet.

Regards,

Hans




