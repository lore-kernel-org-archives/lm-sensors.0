From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: [PATCH 2.6] Rework memory allocation in i2c chip drivers
Message-Id: <20040417145309.4831f2b6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040403191023.08f60ff1.khali@linux-fr.org>
	<20040403202042.GA3898@sirius.home>
	<20040409173158.GC15820@kroah.com>
	<20040410165832.08e0c80d.khali@linux-fr.org>
In-Reply-To: <20040410165832.08e0c80d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
Cc: greg@kroah.com, vsu@altlinux.ru

> > > Instead of splitting one kmalloc in two, it would also be possible
> > > to add a "struct i2c_client client" field to each of the *_data
> > > structures - the compiler should align all fields appropriately.
> > > Probably this way will result in less changes to the code (and
> > > also less labels and less error paths).
> > 
> > I like this version a lot better.  It's simpler and if we do this,
> > we can easily switch to the proper refcount handling of the
> > i2c_client structures like we should do in 2.7.
> > 
> > Jean, care to redo your patch in this form?
> 
> OK, here you go. Thanks Sergey for the insightful example!

U-ho. I think I've introduced a memory leak with this patch :(

For drivers that handle subclients (asb100 and w83781d on i2c), the
sublient memory is never released if I read the code correctly. This is
because we now free the private data on unload, assuming that it
contains the i2c client data as well. That's true for the main i2c
client, but not for the subclients (data = NULL so nothing is freed).

Could someone take a look and confirm?

I can see two different fixes:

1* When freeing the memory, free the data if it's not NULL (main
client), else free client (subclients). Cleaner (I suppose?).

2* When creating subclients, do data = &client instead of data = NULL.
Then freeing will work. Less code, faster. Are there side effects? (I
don't think so)

My preference would go to 2*.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
