From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Jul 2007 12:28:02 +0000
Subject: Re: [lm-sensors] generic in and fan print code update headsup
Message-Id: <20070705142802.03dfccad@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <468AA345.30209@hhs.nl>
In-Reply-To: <468AA345.30209@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Tue, 03 Jul 2007 21:41:02 +0200, Hans de Goede wrote:
> Hans de Goede wrote:
> > I'm working on and will shortly commit an update to the generic in and fan 
> > print code.
> > 
> > The in code currently will not print the ")" after printing the min voltage if 
> > an in input has a min limit but not a max.
> > 
> > The fan code currently will not print the divider for chips without a min 
> > limit, such as the fscpos ans fscher chips.
> > 
> > The update will fix this.
> (...)
> This update also adds fanX_fault handling.

Looks good, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
