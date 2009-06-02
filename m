From: Jacob Steinberger <trefalgar@realitybytes.net>
Date: Tue, 02 Jun 2009 21:49:41 +0000
Subject: [lm-sensors] Power Supply Monitoring
Message-Id: <20090602164941.uz55en9rms0okkg0@blastoid.drak.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Gents,

Before I get too far into lmsensors, I'm hoping I can get a quick  
yea/nay on the path I'm going.

I'm trying to do power supply monitoring to detect if we're having a  
problem (loss of grid power, loss of UPS power, voltage issues, etc).  
I've found that some wiki pages state that this is, to some degree,  
the point of lmsensors. What I'm failing at figuring out if I can do  
this on my hardware or not.

I've run sensors-detect, and I get back ...

Driver `coretemp':
   * Chip `Intel Core family thermal sensor' (confidence: 9)

Driver `ipmisensors':
   * ISA bus, address 0xca8
     Chip `IPMI BMC KCS' (confidence: 8)

Driver `i5k_amb':
   * Chip `Intel AMB FB-DIMM thermal sensor' (confidence: 9)

Does either ipmisensors or i5k_amb support voltage type statistics? If  
not, I would assume if my hardware does have these sensors, lmsensors  
doesn't support them.

Thanks in advance for any responses (or lack there of ;),

Jacob


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
