From: icampbell@arcom.com (Ian Campbell)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: Linux i2c-pca-isa.c question
Message-Id: <1111571987.15795.87.camel@icampbell-debian>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Please at least cc the lmsensors (i2c) mailing list, I've added it now.
I'm not sure if you need to subscribe to post or not, the list is
maintained by hand so I think you can just post. If you wish to
subscribe just post to the list and ask.

On Tue, 2005-03-22 at 11:19 -0800, Jinggang Wang wrote:
> Sorry for the disturb. I noticed in this program you used irq for
> the pca9564 chip. My concern is: if we use interrupt, the PCA9564 chip
> will generate one interrupt for every byte it sends to I2C bus. If the
> I2C bus runs in 100kbps, it will generate one interrupt about every
> 100us. Could this be too heavy interrupt load for the system?

I don't really know -- I guess it depends on the system. The one I developed
on ought to be OK with it -- our i2c transfers are pretty intermittent
and I don't think 100us is a huge load for a 400MHz processor.

> I dont know if polling is better than interrupt when using PCA9564
> chip.

If you submit a patch to the mailing list to support an optional polled
mode then we can look at it.

Ian.
-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been virus scanned by MessageLabs.
