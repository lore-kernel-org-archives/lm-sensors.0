From: p.wautelet@fractalzone.be (Philippe Wautelet)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: Ticket #1352
Message-Id: <3F2FEB70.5000900@fractalzone.be>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F2E9EBB.3040600@fractalzone.be>
In-Reply-To: <3F2E9EBB.3040600@fractalzone.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:

>Do `cat /proc/ioports` to see if anything collides with 0x1000-0x101f.
>If it's some device you don't use, try completely disabling that device
>in the BIOS.  Otherwise (unless Jean's hints work) I think you're out of
>luck, sorry.
>
The only thing that appears at this address is the SMBus for the 
2.6.0-test2 kernel and nothing for the 2.4.20 one.

Maybe a new version of the BIOS will solve that!

-- 
Philippe Wautelet
Research assistant,
Aerodynamics Group, University of Liege, Belgium, http://www.ulg.ac.be/aerodyn
Private website: http://www.fractalzone.be

