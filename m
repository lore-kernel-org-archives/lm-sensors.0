From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: subclient leak in asb100 driver
Message-Id: <20040410180102.GB17335@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040410110533.49ba7483.khali@linux-fr.org>
In-Reply-To: <20040410110533.49ba7483.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2004-04-10 11:05:33 +0200]:
> I think that there is a i2c client and memory leak in your asb100 driver
> (2.4/CVS). In asb100_detach_client, you neither call i2c_detach_client
> on subclients, nor do you kfree their memory.

Nope, the I2C core calls asb100_detach_client() three times... once for the 
primary client and twice more for the subclients.

> I think that the same problem exists in the 2.6 version of the driver,
> as well as in the w83781d driver there. The 2.4/CVS version of the
> w83781d driver, on the other hand, seems OK.

The changes in 2.6 are also on purpose.  They're necessary because the
I2C client list was implemented differently than in 2.4,  which caused
it to try to release the subclients twice.

I.e. technically, it's the CVS w83781d driver that's wrong... although
it happens to be benign vs. 2.4 kernel.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
