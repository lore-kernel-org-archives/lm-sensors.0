From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 06 Jan 2006 18:53:32 +0000
Subject: [lm-sensors] seeking a W83687THF patch for 2.6.15 (re: ticket
Message-Id: <20060106195332.45aed75e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43BDFEEE.4070408@rogers.com>
In-Reply-To: <43BDFEEE.4070408@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Steven,

> I have the misfortune of having the Windbond W83687THF Super I/O IC on 
> my Soltek motherboard (SL-B9D-FGR).

Nothing to worry about. Sure we don't support this chip right now, but
given the good relationship that exists between the lm_sensors group
and Winbond, I am certain we should be able to come up with a solution
fast.

> I tried manually patching the w83627hf.c file contained in the 2.6.15 
> sources with the changes outlined in the experimental patch for 
> 2.6.13-rc3 found on the lm_sensors drivers page.  There were a few 
> differences in line numbers but thats about it (i.e. it was pretty 
> straightforward what to change).  Unfortunately, it didn't work for me 
> (sensors-detect didn't detect...didn't even probe for this chip).  This 
> was probably predictable, as I'm not at all familiar with what was 
> required and what all else would have needed to have been changed (i.e. 
> I was just taking a stab in the dark in hopes that I might get it right). 

Which version of lm_sensors (user-space) are you using? The W83687THF
detection was added in version 2.9.2, so you need at least this
version. Please note also that the detection code was written without
the benefit of a datasheet, so it might simply be incomplete.

You could provide the output of "isadump -k 0x87,0x87 0x2e 0x2f 0x0b"
so that I compare the ID of your chip with what is believed to the the
W83687THF chip ID. Note that you need isadump from lm_sensors 2.9.2 for
it to work.

> Which brings me to my question: how do I go about applying the 
> experimental code/patch in order to gain support for my board' w83687thf ?

I just updated the patch for Linux 2.6.15:
http://jdelvare.net2.nerim.net/sensors/linux-2.6.15-hwmon-w83687thf.diff

But this shouldn't be fundamentally different from what you had
starting from the 2.6.13-rc3 patch, if you fixed it properly.

Please also keep in mind that for user-space support you need to apply
the following patch to the lm_sensors sources:
  http://jdelvare.net2.nerim.net/sensors/CVS-w83687thf.diff
I checked it and it still applies to CVS with some offset.

-- 
Jean Delvare

