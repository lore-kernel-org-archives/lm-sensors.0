From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 11 Jun 2007 19:54:50 +0000
Subject: Re: [lm-sensors] sensor-detect and non-compliant SMSC Super I/Os
Message-Id: <466DA88A.2000802@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0706111131w61cc4abfo31ba33bba90a3314@mail.gmail.com>
In-Reply-To: <191fb4ca0706111131w61cc4abfo31ba33bba90a3314@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Juerg Haefliger wrote:
 > All,
 >
 > I looked through a lot of SMSC datasheets the last couple of days with
 > the goal to improve sensor-detect to correctly identify more SMSC
 > Super I/Os. I noticed that some of the chips don't conform to the ISA
 > PNP standard with the device ID register living at a different address
 > (0x0d instead of 0x20). In order to correctly identify those chips, a
 > somewhat ugly (and totally SMSC specific) hack would be necessary.
 > Something like reading from both addresses and then using the value
 > from 0x0d for some of the SMSC chips.
 >
 > I wonder how much value this adds given that none of these Super IOs
 > have HW monitoring capabilities? The only benefit I can see is that
 > the chip is correctly identified and we can flag it as not being a
 > sensor and thus users won't bug us for adding support.
 >
 > Any thoughts, comments, ideas?
 >

I think that if the hack isn't too gross, it would be good to also be able to 
identify those chips.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
