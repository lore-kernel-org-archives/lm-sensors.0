From: Henrique de Moraes Holschuh <hmh@debian.org>
Date: Wed, 10 Oct 2007 00:40:00 +0000
Subject: Re: [lm-sensors] syfs attributes for signaling
Message-Id: <20071010004000.GA952@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 09 Oct 2007, Hans de Goede wrote:
> I just got some info from Siemens (Thanks Thilo) on howto detect the presence 
> of up to 2 power supplies with the fscscy and fscpos IC's and the status (OK or 
> fail) of these. So we need to come up with a sysfs interface for this.
> 
> I suggest:
> powersupplyX_present
> powersupplyX_fault
> 
> How does that sound?

Don't we have a sysfs powersupply class?  It should probably be used
instead.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
