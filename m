From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 10 Jan 2011 18:56:00 +0000
Subject: Re: [lm-sensors] Erratic value of MCH temp. (0C),
Message-Id: <20110110195600.25c03dd6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1294052867.1860.36.camel@Asus5>
In-Reply-To: <1294052867.1860.36.camel@Asus5>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Joris,

On Mon, 10 Jan 2011 19:48:38 +0100, Joris Creyghton wrote:
> Thank you for your work on the driver.
> I really would like to test it ASAP, but I don't know how.
> I'm a Linux newbie so I'm afraid I must ask you a recipe for this task.
> Maybe you can point me to some links where the necessary steps are
> explained.
> I'm familiar with the process of compiling and linking to obtain
> executable code but have no experience in testing drivers in Linux.
> 
> I'm planning to add an empty disc to my system and install a fresh
> Ubuntu 10.10 64 bit desktop on it just for test purposes and to make
> sure that I won't blow up my regular system.

You can pick any example Makefile on my site, e.g.:
http://khali.linux-fr.org/devel/misc/w83795/Makefile

Change
  DRIVER := w83795
to
  DRIVER := asus_atk0110

put both files in a temporary directory, then type "make". You'll need
make, gcc and configured kernel headers installed. When the build is
successful, you can test the module as root with:

# rmmod asus_atk0110
# insmod ./asus_atk0110.ko

Hope that helps,
-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
