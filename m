From: anthony.calabro@lmco.com (Calabro, Anthony)
Date: Thu, 03 Aug 2006 16:28:29 +0000
Subject: [lm-sensors] Flex Scanner Jammed Problem
Message-Id: <ECFA7CB48E408A45987215BF5593E04704F7F7BD@emss09m08.us.lmco.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


-----Original Message-----
From: Jean Delvare [mailto:khali at linux-fr.org] 
Sent: Thursday, August 03, 2006 11:41 AM
To: Calabro, Anthony
Cc: LM Sensors
Subject: Re: [lm-sensors] Flex Scanner Jammed Problem

> Try our latest default configuration file:
> http://lm-sensors.org/svn/lm-sensors/trunk/etc/sensors.conf.eg
> 
> If that works, then the problem is definitely the configuration file 
> you created. If not... Please tell us with which versions of flex and 
> bison you built lm_sensors.
> 
> Note that you can use the "-c" option of "sensors" to select a 
> configuration file. This should help you test different files.
> 
> -- I tried the newest config file, still flex scanner jammed, working 
> on getting a copy to send to you.
> 
> -- using flex version 2.5.4
> -- using bison version 1.875c

I just tried this combination but was unable to reproduce the problem.

Can you try removing the following line from lib/conf-lex.l:

%option nodefault

As I understand it, it should cause libsensors to output anything it
doesn't understand in the config file to stdout. Maybe that will provide
some hint. Other than that, I don't know what to suggest.

--------------

Thanks, I tried that, again I emptied out the sensors.conf file to just
the chip line and the label lines.  I got rid of all of the parsing
errors, but it outputs this when you run sensors -s:

	in0  in1  in2  in3  in4  in5  ....

So it seems that it doesn't recognize these names.  I tried changing
them to make sure, and it did the same thing, I changed all of the (n)'s
to (t)'s and got
	
	it0  it1  it2 .....

Samething when I run sensors.  I see the 

	in0  in1  in2  in3  in4  in5  ....

At the top of the output, followed by the sensors readings with 

in0:  
in1:	
....
...

as labels...



