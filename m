From: armenb@cs.umass.edu (Armen Babikyan)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: Sensors on IBM eServer 335/345?
Message-Id: <2A5055C0-6929-11D9-98D6-003065F94C4C@cs.umass.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Thanks, Jean, for the info about the "IBM Laptop detected" problem.  
The i2c-piix4 bus driver now loads with no problem on this IBM eServer 
335.

However, sensors-detect still isn't finding any sensor chips on this 
system.  Is there a giant table somewhere that lists motherboard/chip 
combinations so I can find the appropriate drivers for this system?  Or 
any general guidelines to what IBM or Serverworks prefer to use with 
their systems/electronics?  Could the sensor chips be proprietary?

Or has anyone used sensors on these machines and knows offhand? :)

Are there any gotchas with regards to installing the latest 
i2c/lmsensors (2.9.0) on an older kernel (2.4.21)?  I know this machine 
has two Xeon processors, and Xeons have embedded temperature sensors, 
but have not had much luck trying to access them after inserting the 
xeontemp lmsensors module - just wondering if my old kernel could have 
anything to do with it.

Any insight is appreciated!

Thanks,

   - Armen
