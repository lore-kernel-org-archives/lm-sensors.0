From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:53 +0000
Subject: Help getting hardware monitoring on Intel 855PM 82801DBM
Message-Id: <42682AC6.5080608@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1114109876.6001.26.camel@localhost.localdomain>
In-Reply-To: <1114109876.6001.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> My (ignorant) question is whether the reading at address 0x51 might mean
> that some hardware monitoring functionality could be possible.  My guess
> is NO, but I just wanted to be sure before I gave up all hope!  

Sorry it is just EEPROM on your RAM module. The 0x44 is from SMBUS host I think.
So it seems there is nothing interresting. You may try our latest sensors-detect
from CVS lm_sensors maybe you have some LPC I/O.

My question is: Can you see some temp status in bios?


Thanks

Regards

Rudolf
