From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 03 Aug 2006 08:49:59 +0000
Subject: [lm-sensors] Flex Scanner Jammed Problem
Message-Id: <20060803104959.62f86115.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Anthony,

> Im still finding now that whatever I put in the sensors.conf file I get
> flex scanner jammed.
> 
> Even with just two lines, one defining the chip, and one defining a
> label.

Can you please send this file to us? In a way it won't be altered by
the transfer.

> Even with the newest version in the downloads section.
> 
> But when I put a 0 byte file there it works...
> 
> Any suggestions? 

Try our latest default configuration file:
http://lm-sensors.org/svn/lm-sensors/trunk/etc/sensors.conf.eg

If that works, then the problem is definitely the configuration file
you created. If not... Please tell us with which versions of flex and
bison you built lm_sensors.

Note that you can use the "-c" option of "sensors" to select a
configuration file. This should help you test different files.

-- 
Jean Delvare

