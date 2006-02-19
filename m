From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sun, 19 Feb 2006 21:20:39 +0000
Subject: [lm-sensors] Sensors.conf file for Abit AA8XE Fatal1ty
Message-Id: <43F8E127.5040304@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060219153638.2C9DE12ECC@bluewhale.planbit.co.uk>
In-Reply-To: <20060219153638.2C9DE12ECC@bluewhale.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Roger Lucas wrote:
> All,
> 
> Should anyone be wanting to use the Abit AA8XE Fatal1ty motherboard (which
> is a rather nice one), it uses both the uGuru and w83627hf sensors devices
> to give you the full information on the system's status.
> 
> I believe I have found the correct configuration file for this motherboard,
> so I have attached it to this mail.  Should anyone find errors in it, please
> can you pass the information back.
> 
> Thanks,
> 
> Roger
> 
> 

For clearity:

This sensors.conf assumes one is using the latest revision of the still 
to be merged abituguru driver, which can be had for now by a personal 
mail to me.

A review for merging has been done, and I'll try to make some time to 
process all the comments from the review and put the necessary 
improvements into the driver and then post a PATCH for merging soon.

Regards,

Hans

