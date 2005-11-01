From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 01 Nov 2005 18:31:20 +0000
Subject: [lm-sensors] Good news , bad news
Message-Id: <20051101183055.4878f52b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43679C33.5010605@cs.bgu.ac.il>
In-Reply-To: <43679C33.5010605@cs.bgu.ac.il>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Niv,

> I am glad to report lm_sensors works on my IDEQ 210V . This pc has the 
> via KM400 and VT8378. sensors-detect found the it87 and it looks good.

Great :)

> I also have a TV card on this pc , and it uses I2C.
> 
> Question: How to omit the other chips that show up in the sensors command?
> 
> I mean the eeprom-i2c-1-51,Philips -i2c-0-61,tveeprom

I think that "sensors -U" is what you are looking for.

Starting with lm_sensors 2.9.2 and Linux 2.6.14,
non-hardware-monitoring will no more show in "sensors" anyway.

-- 
Jean Delvare
