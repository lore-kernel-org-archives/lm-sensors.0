From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 02 Nov 2010 14:05:58 +0000
Subject: Re: [lm-sensors] [PATCH] Display 3 decimal places in raw sensors
Message-Id: <20101102140558.GC30009@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101102132644.46cf8da4@endymion.delvare>
In-Reply-To: <20101102132644.46cf8da4@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Nov 02, 2010 at 08:26:44AM -0400, Jean Delvare wrote:
> I would like the raw output of "sensors" to display 3 decimal places
> as most sensor types use at the sysfs interface. This will make it
> easier for us to help users find out correct scaling factors when
> needed. Instead of telling them to go read the raw sysfs attributes,
> they can just report the output of "sensors -u -c /dev/null".
> 
> Objection anyone?

No objection. Makes sense to me.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
