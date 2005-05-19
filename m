From: julmust@linux.se (tobbe)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: Ticket #1034
Message-Id: <20021021002626.676dc35d.julmust@linux.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, 

I found out what was wrong with my reading. Apparently there was an extra sensorcable that I had to connect to my motherboard in order to read the systemtemp.

So, the temperature that lmsensors said was my systemp was really the temperature of my CPU. And the temperature that the CPU showed was really the system temp, but since the sensor was not connected it got a bad reading.

I was stupid of my not to figure this out before i posted a ticket, I know..
Regards
/Tobbe
