From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: question about lm_sensors
Message-Id: <3E4877F5.2010300@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.GSO.4.44.0302101014000.22414-100000@unixs1.cis.pitt.edu>
In-Reply-To: <Pine.GSO.4.44.0302101014000.22414-100000@unixs1.cis.pitt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

it doesn't really take that long to read the sensors.
ISA/PCI sensors in particular are quite fast. I2C sensors are somewhat slower.
But most drivers only get new readings if the old readings are more than 1.5 seconds old.
You can modify that if you wish by changing the test near the top of the
xxx_update_client() routine in each driver of interest.

Oleg Shigiltchoff wrote:
> 
> Hi!
> 
> According to the manual for lm-sensors, it takes at least 1.5 sec. to
> obtain the readings from the sensors:
> 
> "The LM78, and most other sensor chips like it, reads its sensors one by
> one. A complete scanning sweep will take about 1.5 seconds. The LM78 stops
> readings sensors if you try to access it, so if you access it very often
> (by reading sensor values; writing new limits is safe) it will not find
> the time to update its sensor values at all! Fortunately, the kernel
> module takes care not to do this, and only reads new values each 1.5
> seconds. If you read the values again, you will get the 'old' values
> again. "
> 
> We are developing real-time applications where we would like to use
> lm_sensors. The problem is that we don't need to read all sensors but only
> a few most crucial for us values. For real time applications 1.5 sec. is
> unacceptably long time. Therefore, I am wandering if it is possible to
> modify lm_sensors to read only a couple values but for less time? If so,
> does it imply significant changes in the code or there are some ways to
> "disable" some functionaly on behalf of time?
> 
> Thank you,
> 
> Oleg Shigiltchoff
> Real time embedded systems
> University of Pittsburgh
> 
