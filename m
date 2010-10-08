From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 08 Oct 2010 12:44:12 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp: fix reading of microcode revision
Message-Id: <20101008124412.GA24894@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CADB0A1020000780001B335@vpn.id2.novell.com>
In-Reply-To: <4CADB0A1020000780001B335@vpn.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Oct 08, 2010 at 08:33:22AM -0400, Henrique de Moraes Holschuh wrote:
[ ... ]
> 
> The nasty thing about microcode revisions is that they can increase at any
> point in time (although we CAN get notified of it), but I don't think we 
> ensure that they cannot go BACK after suspend/resume cycles.
> 
Not sure if it would be worthwhile dealing with that. This sounds a lot like
"let's try to make the OS's life miserable", and you end up with a lot of
nasty code trying to deal with such situations. Next would be to try to verify
if the microcode is really the version it claims to be, or if someone hacked it.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
