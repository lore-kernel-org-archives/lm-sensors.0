From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 24 Mar 2010 14:28:20 +0000
Subject: Re: [lm-sensors] Fujitsu D2778 sensors
Message-Id: <20100324152820.64994710@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <fphm77-hj.ln1@legba.gamic.com>
In-Reply-To: <fphm77-hj.ln1@legba.gamic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sergey,

On Wed, 24 Mar 2010 15:01:11 +0100, Sergey Spiridonov wrote:
> Jean Delvare wrote:
> > Please post the full output of sensors-detect still. The way it detects
> > nothing might be relevant.
> 
> It is in attachmemnt.

You are running a relatively old version of the script. It doesn't know
of the latest FSC chips (Hades and Syleus). Please try again with the
latest version of the script:
http://dl.lm-sensors.org/lm-sensors/files/sensors-detect

> PS It will be nice if somebody can at least confirm that this mainboard
> is supported.

I don't know, sorry. But it has a device at I2C address 0x73, which
makes me confident it is at least supportable.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
