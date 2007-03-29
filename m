From: Ed Lucas <ejl@eberian.com>
Date: Thu, 29 Mar 2007 10:00:32 +0000
Subject: Re: [lm-sensors] Motherboard-specific configurations (sensors4mobo)
Message-Id: <460B8E40.9050908@eberian.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46084A44.4070101@eberian.com>
In-Reply-To: <46084A44.4070101@eberian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Morning All,
>>> We were thinking about using the following:
>>> system-manufacturer
>>> system-product-name
>>> system-version
>>> baseboard-manufacturer
>>> baseboard-product-name
>>> baseboard-version
I have cobbled together new versions of the sensors4mobo tools that only 
use those six parameters. The web server now does a very basic check for 
six parameters and the table marks the broken ones (loads more work & 
sanity checking to be done here). One valid file so far, and I will see 
about updating the rest when I have the time.

I have also added a "tags" field in which you can add a fixed set of 
tags to describe the file: so far I have thought of "broken", 
"experimental" and "beta". Perhaps this goes some way towards emulating 
your "unsure" database flag, Ivo? I went for the name "tags" rather than 
"status" so that other info could be added with minimal api changes. 
This is more for my sensors overlay work, so feel free to disregard it 
if it doesn't fit your goals.

Can anyone point me towards a description of the "dynamic chips support" 
for libsensors that Jean mentioned. (Sorry, my googling failed on this).

For motherboard specific sensors.conf files, would it make sense to use 
the same fan labels that are used in the manual and on the motherboard 
itself? (What is the offical naming policy? - grepping  sensors.conf 
shows a range of names)

Best regards,
    Ed

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
