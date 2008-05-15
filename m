From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 15 May 2008 20:54:33 +0000
Subject: Re: [lm-sensors] FSC D-1501 motherboard
Message-Id: <482CA309.20304@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <482A0867.5080602@zork.pl>
In-Reply-To: <482A0867.5080602@zork.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Lukasz Michalski wrote:
> Hi,
> 
> I have FSC-1501 motherboard and lm_sensors does not detect chip here.
> 
> How can I help to make it work? I have very little experience with 
> hardware monitoring.
> 

Judging from the manual this is a server motherboard, and judging from the 
sensors-detect output it does not have one of FSC's own custom hwmon IC's, so I 
think that ipmi is your best bet.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
