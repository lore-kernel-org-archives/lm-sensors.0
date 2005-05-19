From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:24 +0000
Subject: KT4AV-L mobo with w83697hf
Message-Id: <41A7FC6D.40105@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1101512791.2802.13.camel@localhost.localdomain>
In-Reply-To: <1101512791.2802.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

beeps is a bitmask with the same definition as alarms, not a counter.
this is documented in doc/developer/proc.

koz wrote:
> I have a KT4AV-L mother board with a w83697hf chip.
> 
> 1. I noticed that the V5SB voltage with the default calc' always shows
> something like +5.5* V where as the BIOS shows +5.0* V. If you set the
> calc' to "compute in7 ((5.1/10)+1)*@ ,  @/((5.1/10)+1)" the result is
> more consistent with the BIOS.
> 
> 
> 2. Question - I originally thought that the beep_enable feature wouldn't
> work since I couldn't get it to beep, but then when I run sensors -u I
> get a line showing the beep_enable followed by a line showing beeps, and
> I can set the number of beeps in sensors.conf with something like 
> 
>     set beep_enable 1
>     set beeps 1
> 
> Is this documented anywhere ? how exactly should it work ?
> 
> regards, Koz
> 
> 
> 
> 
> 
> 
> 
