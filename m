From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 21 Jul 2009 16:23:48 +0000
Subject: Re: [lm-sensors] What do I log if I'm not sure about the compute
Message-Id: <20090721182348.0d23c932@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0906220138120.9018@birdbird.example.com>
In-Reply-To: <Pine.LNX.4.64.0906220138120.9018@birdbird.example.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matt,

On Sun, 28 Jun 2009 15:31:39 -0500 (CDT), Matt Roberds wrote:
> Related to the below question: At home, I run lm-sensors 3.1.0 on kernel
> 2.6.26.  There are some entries below /sys/devices/platform for the
> it8716 chip on my motherboard.  Do the "files" below this directory
> provide the same raw values that libsensors is using?

It's not only "the same raw values", libsensors is reading the values
from exactly these files!

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
