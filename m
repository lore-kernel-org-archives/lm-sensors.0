From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: Centrino (855PM, ICH4-M): 82801DBM w/o LPC Bridge/SMBus?
Message-Id: <1082464313.4085183969283@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040412152503.GD6820@neu.nirvana>
In-Reply-To: <20040412152503.GD6820@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> you are right about the CVS renaming pain. I've renamed it back to
> it original name.
> 
> Are you considering switching to subversion?

No.

Now, if you tell me that we can switch to subversion and keep all the
history we have in CVS at the moment (including all branches) and that
subversion allows renaming files without losing their history, we might
reconsider. However, this means extra work for Philip Edelbrock
(installing subversion, migrating data, updating webcvs - BTW is there
a subversion equivalent?) and that "all" developers don't mind
switching. Not sure it's worth it.

> I cannot find the time to do the "proper" thing (e.g. go into
> i2c_801.c and enable the smbus there), so before it get too cold,
> I'd rather submit the fixes to the p4b_smbus.c.

You're right. That fix is easier and some users may enjoy it. I'll apply
this once home.

> I believe it should also fix
> http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket04

Correct. We want to contact that person once your fix is commited, in
case he is still using that laptop.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
