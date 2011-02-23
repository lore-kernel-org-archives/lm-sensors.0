From: Phillip Susi <psusi@cfl.rr.com>
Date: Wed, 23 Feb 2011 16:29:37 +0000
Subject: Re: [lm-sensors] New sysfs attribute for fan control: fan pulses
Message-Id: <4D6535F1.4080601@cfl.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110223035414.GA18074@ericsson.com>
In-Reply-To: <20110223035414.GA18074@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 2/22/2011 10:54 PM, Guenter Roeck wrote:
> Hi all,
> 
> while working on NCT6776F support, I realized that there is a fan control
> attribute which is not currently supported by the syfs ABI: The number of
> fan pulses per revolution. On the NCT6776F, this can be configured in Bank 6,
> registers 0x44 to 0x46. Possible values are 0..3 for 4, 1, 2, or 3 pulses 
> per revolution.
> 
> I encountered the same parameter when working on PMBus devices. At the time,
> I thought this was a variant of a fan divisor (ie a divisor of 1, 2, 3, or 4),
> but apparently it is different and independent of the fan divisor.

How is it any different than the fan divisor?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
