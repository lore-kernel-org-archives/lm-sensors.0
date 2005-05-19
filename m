From: decibel8@charter.net (David)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: 1250
Message-Id: <200306300136.29202.decibel8@charter.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200306021011.37032.decibel8@charter.net>
In-Reply-To: <200306021011.37032.decibel8@charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

	Finally got lm_sensors working again after whatever happened when
I installed the cvs. Had a heck of a time getting via686a to work. Keeped putting
in only lm80 for some reason. Module for via686a was loaded but sensors wouldn't
use it for some reason.  Then when would take out via-pro and lm80 it would say
no sensors, when ran  'sensors'.

Long story so won't bore you, but finally got it working, gkrellm2 working with it also again,
just like before. 

I did notice one thing that might be important during my trouble after the cvs and trying
to get it working again. 

sensors -s     

did work with the lm80 and Smsbus.  Just not with the via686a, so maybe what Philip
said about the ISA is correct.

>Philip Pokorny wrote:
> I don't have my lm_sensors source handy right now, but I wanted to
> reply so perhaps you or someone else could look into this...
> 
> I notice that the adapter is registered at address 6000.  That's a bit
> of a strange isa address.  I believe that the original ISA bus only
> has I/O addresses up to 3fff.  Anything above that is either an alias
> or a PCI bus address.
> 
> Perhaps there is a test in the ISA write function that makes sure the 
> address you're attempting to write is in the range: 0-3fff or less and
> if not, returns an error.


Dave

Sorry it took me a few days to get back with you, but have to work the weekends.
