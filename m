From: thenders@math.tamu.edu (Troy Henderson)
Date: Thu, 19 May 2005 06:24:24 +0000
Subject: lm_sensors & kernel
Message-Id: <Pine.LNX.4.44.0311101424220.10974-100000@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031110190054.5c8c683b.khali@linux-fr.org>
In-Reply-To: <20031110190054.5c8c683b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> It probably won't, since it's a bit late to have such a big patch into
> Linux 2.4.23 (so I was told). I should have been faster, my fault. I
> expect only a few simple fixes to be accepted into 2.4.23, the rest of
> the changes be left for 2.4.24. So I'll have to make a patch available
> once more.

Oh well!

> It is there! Take a look in drivers/i2c, you'll see almost all bus
> drivers, plus several chip drivers. The main problem is that user-space
> tools don't support Linux 2.6 yet (although I think someone is working
> on it) so you'll have to read the raw values in /sysfs. Admittedly not
> very comfortable.

I was able to do that, but I was looking for a way to make GKRellm show 
the sensor data.

##########################################################################
Troy Henderson                  Office: Blocker Building 619
Department of Mathematics       Phone : (979) 845-7769
Texas A&M University            E-mail: thenders@math.tamu.edu
College Station, TX 77845       URL   : http://www.math.tamu.edu/~thenders
##########################################################################
