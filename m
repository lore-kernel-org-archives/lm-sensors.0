From: hans.edgington@xs4all.nl (Hans Edgington)
Date: Tue, 16 Jan 2007 15:49:05 +0000
Subject: [lm-sensors] Support for Fintek F71882FG
Message-Id: <000801c73985$da917d70$20140a0a@EA002>
List-Id: <lm-sensors.vger.kernel.org>
References: <45ACB395.4050005@ne2000.de>
In-Reply-To: <45ACB395.4050005@ne2000.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Toby,

Sorry for not responding to your to your previous mail, but I hope you
understand I had other things on my mind last week. Still do. 

The driver was almost completed and thanks for offering to help test the
driver. It is a simple driver only reading sensor data, which I will expand
in the future. I have made a small app to read the data from the sensors and
can post it later if anyone is interested.

Due to a wrecked power supply I can't start up the pc with the sensors
project at the moment. I won't go in to the gruesome details of hw it got
destroyed, picking up a new one later.

I will update the wiki as soon as I have more time. I haven't found any
reason to believe the EP1308 and F71882FG are different chips, except for
one field that seems to be odd.

Regards,
Hans

-----Original Message-----
From: Tobias Zuegel [mailto:neodym at ne2000.de] 
Sent: 16 January 2007 12:14
To: lm-sensors at lm-sensors.org; hans.edgington at xs4all.nl
Subject: Support for Fintek F71882FG

Hi,

I had a careful look at my Foxconn P9657AA board and it does contain an 
original unbranded Fintek F71882FG. The FoxOne chip seems to be 
something different. The F71882FG seems to be used also by MSI, Albatron 
and Jetway mainly on Intel P965 boards.

I am very interested in a driver and I will help if I can (e.g. testing)

It would be nice, if you could update the number of requests on the 
devices page in the wiki. It might also be helpful to combine requests 
for EPoX EP1308 and F71882FG if they truely use the same driver.

Greets,
Toby



