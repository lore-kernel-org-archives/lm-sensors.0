From: laytonjb@bellsouth.net (Jeffrey B. Layton)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: Problem with SiS950 on ECS MB
Message-Id: <3E7C8013.5010902@bellsouth.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E6265CB.6030005@bellsouth.net>
In-Reply-To: <3E6265CB.6030005@bellsouth.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

   I'm still attempting to get lm-sensors working correctly
on a ECS P6SSTP-FN motherboard. Mark helped me fix
my earlier problem of getting lm-sensors going on this
MB. However, now when I run 'sensors' I get wrong
information. I assume it's because of an incorrect
"temp_type" parameter for the it87 module, and/or a
problem with /etc/sensors.conf. I apologize for the length
of this email.
   I need determining the labels to use in sensors.conf and
also the temp_type to use with the it87 module. Does
anyone have values for this MB? If not, how do I go about
determinging these? I've been reading the docs for the it87
but I'm a bit confused about how to determine which sensor
is a diode or a thermistor.

TIA!

Jeff





