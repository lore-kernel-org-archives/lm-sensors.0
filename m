From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: subclient leak in asb100 driver
Message-Id: <20040410202552.769d25fd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040410110533.49ba7483.khali@linux-fr.org>
In-Reply-To: <20040410110533.49ba7483.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Nope, the I2C core calls asb100_detach_client() three times... once
> for the primary client and twice more for the subclients.

Ohhhh OK. Now I get it. It's a bit confusing at first. I'd have expected
two different detach functions (i.e. two different driver structures).
But I agree it works.

> The changes in 2.6 are also on purpose.  They're necessary because the
> I2C client list was implemented differently than in 2.4,  which caused
> it to try to release the subclients twice.

I didn't see much change, except the sysctl_id being gone.

> I.e. technically, it's the CVS w83781d driver that's wrong... although
> it happens to be benign vs. 2.4 kernel.

Yes, I see that now. I'm surprised that it doesn't cause more trouble
than it does. Care to correct the 2.4/CVS driver so that it does what
your asb100 driver does (i.e. the right thing)?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
