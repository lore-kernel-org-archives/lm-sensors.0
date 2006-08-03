From: anthony.calabro@lmco.com (Calabro, Anthony)
Date: Thu, 03 Aug 2006 13:56:39 +0000
Subject: [lm-sensors] Flex Scanner Jammed Problem
Message-Id: <ECFA7CB48E408A45987215BF5593E04708A171A3@emss09m08.us.lmco.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

 


-----Original Message-----
From: Jean Delvare [mailto:khali at linux-fr.org] 
Sent: Thursday, August 03, 2006 4:50 AM
To: Calabro, Anthony
Cc: LM Sensors
Subject: Re: [lm-sensors] Flex Scanner Jammed Problem

Hi Anthony,

> Im still finding now that whatever I put in the sensors.conf file I 
> get flex scanner jammed.
> 
> Even with just two lines, one defining the chip, and one defining a 
> label.

Can you please send this file to us? In a way it won't be altered by the
transfer.

> Even with the newest version in the downloads section.
> 
> But when I put a 0 byte file there it works...
> 
> Any suggestions? 

Try our latest default configuration file:
http://lm-sensors.org/svn/lm-sensors/trunk/etc/sensors.conf.eg

If that works, then the problem is definitely the configuration file you
created. If not... Please tell us with which versions of flex and bison
you built lm_sensors.

Note that you can use the "-c" option of "sensors" to select a
configuration file. This should help you test different files.

-- I tried the newest config file, still flex scanner jammed, working on
getting a copy to send to you.

-- using flex version 2.5.4
-- using bison version 1.875c

-- Thanks...

