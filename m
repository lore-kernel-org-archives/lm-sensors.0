From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Wed, 21 Dec 2005 07:05:46 +0000
Subject: [lm-sensors] Abit AN7 Problems
Message-Id: <43A8FECA.2050205@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1135123884.5991.1.camel@localhost.localdomain>
In-Reply-To: <1135123884.5991.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

atlas wrote:
> Hello,
> 
> First thanks for your good job ;)
> I trying to use lm-sensors but it seems to don't work with my
> motherboard Abit AN7 (chipset nforce2 and ?guru)
> 

Hi,

The Abit uGuru sensprs chip currently is not supported by lm_sensors. 
I'm however working on a driver. I'm about to send a new version to a 
couple of people who have expressed their interest in this driver and 
who have done testing for me. This most recent version should be the 
last one, all problems reported to me by testers are fixed.

I hope to be able to send the new version to my testers today (I only 
have to finish / update the docs). I'll include you in the CC-list. Let 
me know if it works for you and on which motherboard, also please report 
any problems you may have.

Regards,

Hans

