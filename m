From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 10 Jun 2005 18:45:47 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc5-mm1 3/3] i2c: modify sensors
Message-Id: <20050610184519.1d8e1b00.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050602033727.GD4906@jupiter.solarsys.private>
In-Reply-To: <20050602033727.GD4906@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, Mark, all,

> > Well, i2c_get_adapter() could actually use i2c_adapter_idr properly:
> > (untested, not signed off, may eet ur branes, /me needs sleep)
> 
> Yeah, this looks probably right.  Anyone want to test it out?  :)

Applied to my local tree, let's see what happens. So far so good. I
think I understand I'm only supposed to verify that nothing breaks?

Thanks,
-- 
Jean Delvare
