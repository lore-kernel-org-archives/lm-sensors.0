From: stevenkaratnyk@rogers.com (Steven Karatnyk)
Date: Fri, 06 Jan 2006 05:23:58 +0000
Subject: [lm-sensors] seeking a W83687THF patch for 2.6.15 (re: ticket 1944)
Message-Id: <43BDFEEE.4070408@rogers.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

I have the misfortune of having the Windbond W83687THF Super I/O IC on 
my Soltek motherboard (SL-B9D-FGR). 

I tried manually patching the w83627hf.c file contained in the 2.6.15 
sources with the changes outlined in the experimental patch for 
2.6.13-rc3 found on the lm_sensors drivers page.  There were a few 
differences in line numbers but thats about it (i.e. it was pretty 
straightforward what to change).  Unfortunately, it didn't work for me 
(sensors-detect didn't detect...didn't even probe for this chip).  This 
was probably predictable, as I'm not at all familiar with what was 
required and what all else would have needed to have been changed (i.e. 
I was just taking a stab in the dark in hopes that I might get it right). 

Which brings me to my question: how do I go about applying the 
experimental code/patch in order to gain support for my board' w83687thf ?

Thanks, CK


