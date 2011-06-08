From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 08 Jun 2011 13:58:02 +0000
Subject: Re: [lm-sensors] [PATCH] Don't point the user to the ipmisensors
Message-Id: <20110608135802.GB7193@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110608151843.357fa29c@endymion.delvare>
In-Reply-To: <20110608151843.357fa29c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 08, 2011 at 09:18:43AM -0400, Jean Delvare wrote:
> The development of the ipmisensors driver stalled 5 years ago, the
> driver isn't usable, so stop pointing the users to it, it only confuses
> them. See https://bugzilla.novell.com/show_bug.cgi?idU8756 for
> example.
> 
> ---
> I have this patch in openSUSE for 1.5 year, any objection to me
> getting it upstream for everyone's benefit?
> 
Makes sense to me. Too bad this driver is not supported, though - I would need it ;).

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
