From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: EEPROM write support
Message-Id: <3F1DD98B.3090204@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307221931.02558.sascha@akv-soft.de>
In-Reply-To: <200307221931.02558.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Just a few quick comments:

Jean Delvare wrote:

>The module was initially written to read
>memory chips eeproms, and that's not the kind of eeprom you want to
>write to (if you only can, I'm not sure about that.) 
>
Yeah, that was the initial application and reasoning.  And, yes, at that 
time (and probably still true), you could write over the SPD record on 
the eeprom on the DIMMs, making your computer not boot.  Not good!  
Eventhough there is a write protect pin on the eeprom (a hardware 
protection), the DIMM manufacturers seem to program the eeproms while on 
the DIMM.

BTW- There is a little app for the Mac which will 'fix' you incompatible 
DIMM's which get detected and disabled at boot by overwriting the SPD 
record with a 'valid' one (read: adjusting the timing specs to make the 
DIMM seem compatible).  A Mac user friend here at work showed me.  It 
looked like a bad idea, imho....  But, I understand that isn't what is 
being proposed here. ;')

>If we are to add write support to the module, it has to be an option,
>and disabled by default (my opinion).
>  
>
I thought we did have write support as a compile-time option (via a 
define or something).  I thought Mark did that a long time ago?  I could 
be imagining things.  (Or maybe we moved that to user-space only?)


Phil
