From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: VIA
Message-Id: <Pine.OSF.4.10.10206252050450.14710-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 25 Jun 2002, Danne wrote:

> Hi,
>  
> Sorry to disturb you but i have a problem which i hope you can help me
> solve..
>  
> Im currently writing a monitoring tool specialized for my system..
> I have a vt8233a based motherboard with a winbond w83697hf monitoring
> chip..
>  
> The tool will be used under windows..
>  
> My question for you is:
>  
> Can i access the winbond chip with SMBus? Or do i have to use some other
> method?
> My software has detected the VIA chip and SMBus on port 5000..
>  

A quick look to lm_sensors documentation reveals that this sensor
chip would be supported via (pun intended) ISA i/o.
For developers' convenience under lm-sensors, these ISA (or LPC)
connected clients appear to be connected on a pseudo SMBus (i2c-isa).

Hope I remembered it somewhat right.. I am not actively involved in
lm-sensors development for the time being, better contact the 
developers list or search the support database for more details.

Cheers,

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi

