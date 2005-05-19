From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: lm_sensors installation success after errors
Message-Id: <20041006072806.M30981@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <066201c4ab25$e8f27540$0a01a8c0@bullwinkle>
In-Reply-To: <066201c4ab25$e8f27540$0a01a8c0@bullwinkle>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 5 Oct 2004 16:54:37 -0500, Scott Blomfield wrote
> ruik figured out that since my two tv tuner cards were also 
> exporting an i2c interface that there were not enough i2c files 
> available under fedora core 2 to support the two tuner cards plus 
> the two motherboard sensors. The guy deserves a medal, he ran a 
> veritable marathon trying to figure it out and never once referred 
> me to the documentation. Which I did read, too. Good stuff.
> 
> Anyways, just reporting success.

Great that ruik & you finally got the damn thing to work. However, you better
contact the FC folks. The script we distribute with lm_sensors creates 32
device files, which should be more than enough for everyone. So if the FC 2
only creates 2, you should tell them it isn't sufficent. They should create at
least 8.

Note that most distros out there now use devfs or udev, so you are not
supposed to create the device files manually. This may be why the problem went
unnoticed so far.

-- 
Jean Delvare
http://khali.linux-fr.org/
