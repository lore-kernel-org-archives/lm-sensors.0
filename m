From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: testers wanted
Message-Id: <Pine.LNX.4.53.0312241240360.23656@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031222231810.53439aaf.khali@linux-fr.org>
In-Reply-To: <20031222231810.53439aaf.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Wed, 24 Dec 2003, Jean Delvare wrote:

> 4* What's the point in moving the "adapter->clients[i] = NULL" loop from
> top to bottom of function i2c_detach_client? This too makes much noise
> for nothing. If there is no special reason for doing so, let's reverse
> that change. If there is, this doesn't belong to this patch either.

Policy; have the list lock while making a change to it, on removal
the race is not that dangerous but still worth a fix. Note the different
return paths we should handle otherwise.

Postpone if you wish.

> > Fix module reference counting to use try_inc_mod_count in place of
> > __MOD_INC_USE_COUNT, and have i2c_inc_use_client return int. While
> > this is an API change, the return code is just silently ignored. Fix
> > i2c_use_client to study the mentioned return code.
>
> I'm not sure I get you here. Are these things already in CVS and to be
> ported to Linux 2.4, or the particular points that are broken in CVS
> which should be fixed before we can submit a clean patch for Linux 2.4?

This is about fixing the possible race while rmmoding, as the .owner
field is (sometimes) initialized. The race is not yet fixed in CVS.

I will not import broken things from CVS with my patches.

I'm thinking whether to pass controlling_mod in i2c_register_entry as
this is client->driver->owner. I would like to make this API change,
remove it, for the sake of not changing lm_sensors chip drivers.
Can you find anyone else using it?

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>
