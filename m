From: p.wautelet@fractalzone.be (Philippe Wautelet)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: Ticket #1352
Message-Id: <3F3145DC.5090307@fractalzone.be>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F2E9EBB.3040600@fractalzone.be>
In-Reply-To: <3F2E9EBB.3040600@fractalzone.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>And, if you have another OS on the machine, do you have any hardware
>monitoring working there?
>
No, I have only linux on this machine.

>00:02.1 being the SMBus device, I suspect all these is related.
>Obviously, your BIOS manufacturer did not allocate an IRQ for the device
>if ACPI isn't used, and did not allocate an adequate I/O space, if I
>followed your discussion with Mark M. Hoffman correctly. I suspect they
>just don't want you to use the device yet. As you say in your other
>mail, a newer BIOS may help someday.
>
>Maybe you should contact Packard-Bell and ask them about it?
>
Yes, I think I'll do it. Maybe that it could be interesting to also 
contact Mitac because apparently this is a Mitac 8640 hidden under the 
Packard-Bell name! If I get some feedback, I will send you the results.

-- 
Philippe Wautelet
Research assistant,
Aerodynamics Group, University of Liege, Belgium, http://www.ulg.ac.be/aerodyn
Private website: http://www.fractalzone.be

