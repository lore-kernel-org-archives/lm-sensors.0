From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 08 Jul 2007 18:02:12 +0000
Subject: Re: [lm-sensors] [PATCH] i2c: Delete the i2c-isa pseudo bus driver
Message-Id: <20070708180212.GF3591@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070708142637.7cdb7616@hyperion.delvare>
In-Reply-To: <20070708142637.7cdb7616@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2007-07-08 14:26:37 +0200]:
> Hi Mark,
> 
> After thinking about it some more, I think it'll be much easier for
> everyone if you take the patch killing i2c-isa in your hwmon tree, both
> for the testing and later to send it to Linus for 2.6.23-rc1.
> 
> Thanks.
> 
> * * * * *
> 
> There are no users of i2c-isa left, so we can finally get rid of it.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Check a big one off the TODO list, yay!  Applied to testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
