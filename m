From: Marco Chiappero <marco@absence.it>
Date: Sun, 14 Sep 2008 18:51:35 +0000
Subject: Re: [lm-sensors] New Asus board and multiple sensors
Message-Id: <48CD5D37.40402@absence.it>
List-Id: <lm-sensors.vger.kernel.org>
References: <48CCB294.907@hhs.nl>
In-Reply-To: <48CCB294.907@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans de Goede ha scritto:
> When manufacturers change a board chances are high they will change more 
> then just the northbridge. That seems to be the case here, as the smbus 
> probe for your board shows no sensors IC's attached.
 > If you really want to know how the additional headers are hooked up
 > you will need to go and look for hwmon IC's, and yes that means you
 > might need to take the cooler of the motherboard.

I gave a quick look at the motherboard, you are right (and I was wrong, 
sorry).While the w83791d is clearly visible on the Maximus/Rampage Formula
(http://www.overclock3d.net/gfx/articles/2007/10/31181936232l.jpg) this
is not the case for the MIIF.
Unfortunately it's not that easy to remove the heatsink and it makes the
warranty void, but I have found some images of the "naked" board. I
modified them to show you the well know chips, but I need your help to
identify those unknown chips that might be hwmon IC. This is the picture:
http://i37.tinypic.com/29ofhmo.jpg
http://i33.tinypic.com/2m4rfqe.jpg
http://i35.tinypic.com/33e1vyr.jpg
I suspect them to be the iROG marked chips as I think this board is the 
first Asus mounting such ICs and being capable of showing 
temperatures/voltages/fan speeds on an external LCD, included with the 
board. Again, unfortunately no other information is printed.

> Are they actually all 
> monitored, maybe some of them will drive a fan but do not monitor it?
> How many fans does windows allow you to monitor?.

Both the BIOS and the Asus utility show the speed readings for every 
header but at this time I'm using only 3 fan headers (+ the CPU header). 
I'll give a try as soon as possible. However, as far as I know, no Asus 
utility can control this fans and other software only recognizes the 
winbond chip, but some regulations are still possibile in the BIOS. Is 
there a way to find out through a bus scan what chips are they? What can 
we do now? Should we try to contact Asus?

Thank you
Marco



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
