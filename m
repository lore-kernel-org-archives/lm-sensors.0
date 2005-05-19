From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: i2c address probing and AT24RF08 corruption
Message-Id: <40840EEB.4080800@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082123259.407fe3fb3d41c@imp.gcu.info>
In-Reply-To: <1082123259.407fe3fb3d41c@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:

>
>LTC1710: 0x58-0x5A.
>The docs say that the chip will not acknowledge on reads. I'd like to
>know if it just keeps quiet or locks the bus. Phil? This is an uncommon
>chip if I'm not mistaking, unlikely to be found in PCs. People who have
>this probably know they do and where it is, and can use a force
>parameter.
>  
>

BTW- I don't have a clue what this chip does when read.  I don't think 
it locks anything up or does anything bad, but it's been a few years 
since I've played with one.  And, yes, it's probably very, very rarely 
used.  The driver was written out of curiousity, not user demand.


Phil
