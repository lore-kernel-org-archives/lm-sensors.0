From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 30 Jan 2010 09:33:21 +0000
Subject: Re: [lm-sensors] "No sensors found!" on Intel Entry Storage System
Message-Id: <20100130103321.26378e79@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1251523453.13079.32.camel@Ubuntu>
In-Reply-To: <1251523453.13079.32.camel@Ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Lou,

On Fri, 29 Jan 2010 19:17:06 -0500, Lou Gosselin wrote:
> I've attached two files.
> sensors.txt shows the output that I get with sensors-detect and sensors.
> 
> i2cbus.txt shows output for i2cdetect and i2cdump.
> Let me point out that after running "i2cdump 0 0x6a", lmsensors was no 
> longer responsive. Furthermore the machine failed to reboot until I did 
> a cold boot.

Let me point out that dumping random i2c chips is a very bad idea.
Especially chips in the 0x86-0x6a range, are often clock chips which
don't like being dumped at all...

> (...)
> I'll give any suggestions a shot, or if you're willing, I can setup one 
> of these machines for you to connect to.

The chip I would like to see a dump of is the one at 0x2e. This will
give us the chip ID of your SMSC chip. It's probably only a matter of
adding the right ID to the driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
