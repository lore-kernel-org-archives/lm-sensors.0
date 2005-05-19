From: jopr@tele2adsl.dk (Jonathan)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: Regardding Ticket #: 1791
Message-Id: <000501c4b104$2203b3b0$843f4853@jonathan>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c4ad5f$6d5d83c0$843f4853@jonathan>
In-Reply-To: <000001c4ad5f$6d5d83c0$843f4853@jonathan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

I talked with Intel and this is what they said when I asked how to
access the temperatur sensors from my OS:

-------------------------------------
There is one thing only you can try to get access to the temperature
readings: You can try using the IPMI source code package for Linux* to
get access via a software program to the IPMI bus to access temperature
readings. You will find a download here:
http://support.intel.com/support/motherboards/server/ism/  Please scroll
down a little and you will see a link to  IPMI source code package for
Linux* This driver is listed as a courtesy for customers wanting to
validate their own solution. 
-------------------------------------

Is this source code usefull for you?

Regards Jonathan



-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: 11. oktober 2004 18:54
To: Jonathan
Cc: LM Sensors
Subject: Re: Regardding Ticket #: 1791


> Intel states that I can get the thermal info from there own program 
> "Intel server managemnt". This program is for Rehat and I'm running 
> Gentoo. My question is, If their software can access the thermal info,

> shouldn't there be a way for lm-sensors aswell?

The fact that there must be a way isn't relevant. As long as we don't
know how to do it, that information isn't worth anything.

-- 
Jean Delvare
http://khali.linux-fr.org/
