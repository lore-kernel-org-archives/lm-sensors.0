From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 08 Dec 2010 17:46:31 +0000
Subject: Re: [lm-sensors] How to commit the source-code of a new driver for
Message-Id: <20101208174631.GB28993@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CFFA5B5020000AA000081EE@center.bmk-electronics.de>
In-Reply-To: <4CFFA5B5020000AA000081EE@center.bmk-electronics.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Dec 08, 2010 at 09:35:17AM -0500, Matthias Zacharias wrote:
> Hi together,
> 
> which address on the lm-sensors.org is reserved for the commit of new
> unverified drivers?
> 
Documentation/SubmittingPatches should give you an idea where to send patches
(or new drivers) to. But what is "unverified" ?

> Where can I find a "HowTo" or "ReadMe" Tutorial?

Documentation/SubmittingDrivers would be a good start. hwmon is no different
to other subsystems, and follows the same rules.

Besides that, it is always a good idea to remove statements such as
"This e-mail may contain confidential information ..." from e-mails sent
to open source (or any other public) related mailing lists, unless you
want to pretty much ensure that you won't get any replies. If you are
concerned about confidentiality, don't send e-mail to public mailing lists.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
