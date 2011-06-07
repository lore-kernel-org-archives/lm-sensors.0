From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 07 Jun 2011 19:02:16 +0000
Subject: Re: [lm-sensors] i2c device w/o registers
Message-Id: <20110607190216.GA3900@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <609440.53865.qm@web30206.mail.mud.yahoo.com>
In-Reply-To: <609440.53865.qm@web30206.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jun 07, 2011 at 02:57:59PM -0400, Randy wrote:
> Thanks.  I did the equivalent of this by modifying i2c_smbus_xfer_emulated() and 
> making my own read message, and it works.
> 
> Maybe I'll try to call i2c_transfer directly as your recommended, since that 
> sounds cleaner.
> 
Might be a good idea, at least if you plan to submit your driver ;).

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
