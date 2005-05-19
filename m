From: zdavatz@ywesee.com (Zeno Davatz)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: Gnome hangs after sensors installation
Message-Id: <BB4F04AB.6D64%zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BB4EE262.6D4C%zdavatz@ywesee.com>
In-Reply-To: <BB4EE262.6D4C%zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 31.7.2003 17:00, "Jean Delvare" <khali@linux-fr.org> wrote:

> If not, try the following:
> 
> cd /lib/modules/$(uname -r)/kernel/drivers/i2c
> 
> (make sure this command succeeded before running the rm commands below)
> 
> rm *.o
> rm -r busses
> rm -r chips
> 
> With no more sensor modules installed, everything should be back to
> normal I guess.
Ok, this worked. I did not reboot but changed straight into another console.
When starting Gnome now I get tons of Bonobo-Activation-Errors... That say
the 'panel' will now terminate...

I clicked OK several times and now just have the Terminal on my screen...

Everything else is gone...

Any hints?

Zeno

-- 
Mit freundlichen Gr?ssen / best regards

Zeno Davatz
Strategie & Akquisition

+41 1 350 85 86

www.ywesee.com > intellectual capital connected > www.generika.cc


