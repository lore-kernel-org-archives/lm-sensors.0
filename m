From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: via ch p vo-vn sorset
Message-Id: <3DA8A556.9020900@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1032812972.2682.5.camel@zion>
In-Reply-To: <1032812972.2682.5.camel@zion>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

8233A 0x3147 supported in 2.6.5.
8233A 0x3177 supported in CVS.
use lspci -n to see which you have.

Jonas wrote:
> Hello!
> I noticed that you have support for the South Bridge Chipset: VIA(r)
> VT8233A Bus, but I did not find the 8233A sensor chip only the 8231A. 
> I dont know if it should work but it didnt for me. I have used
> lm_sensors befor (on my old computer with an other via-chipset) and it
> worked very well. I tried to force the via686a driver but that didnt
> help (with any port). Will there be a 8233A driver soon or ever?
> /Jonas ?dahl
> 
> 


