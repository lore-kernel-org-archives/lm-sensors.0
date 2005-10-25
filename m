From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 25 Oct 2005 15:24:55 +0000
Subject: [lm-sensors] Re: [patch 0/9] I2C: remove i2c_driver's .owner and
Message-Id: <KxyzGv2E.1130245987.3913680.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051024212201.485176000@antares.localdomain>
In-Reply-To: <20051024212201.485176000@antares.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Laurent,

On 2005-10-25, Laurent Riffard wrote:
> i2c_driver and i2c_driver.driver both have "owner" and "name"
> field.  One should go - there's no point needlessly duplicating
> stuff like this.

Looks alright to me, I'll merge this in my tree and will send it to Greg
quickly.

Greg, can you please confirm you are fine with this change?

Thanks,
--
Jean Delvare
