From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: [PATCH] I2C update for 2.6.6
Message-Id: <10845773571232@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10845773573553@kroah.com>
References: <10845773562431@kroah.com>
In-Reply-To: <10845773562431@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1587.15.10, 2004/05/05 15:34:40-07:00, khali@linux-fr.org

[PATCH] I2C: Fix memory leaks in w83781d and asb100

Quoting myself

> U-ho. I think I've introduced a memory leak with this patch :(
>
> For drivers that handle subclients (asb100 and w83781d on i2c), the
> sublient memory is never released if I read the code correctly. This
> is because we now free the private data on unload, assuming that it
> contains the i2c client data as well. That's true for the main i2c
> client, but not for the subclients (data = NULL so nothing is freed).
>
> Could someone take a look and confirm?

I could test and actually saw memory leaking when cycling the w83781d
driver at a sustained rate (5/s).

> I can see two different fixes:
>
> 1* When freeing the memory, free the data if it's not NULL (main
> client), else free client (subclients). Cleaner (I suppose?).
>
> 2* When creating subclients, do data = &client instead of data = NULL.
> Then freeing will work. Less code, faster. Are there side effects? (I
> don't think so)
>
> My preference would go to 2*.

I ended up implementing 1*. That's cleaner and there's actually almost
no extra code.

Mark, can you confirm that I'm doing the correct thing? I'll do
something similar in our CVS repository (for now, the asb100 and w83781d
drivers had not their memory allocation scheme reworked there).


 drivers/i2c/chips/asb100.c  |    8 +++++++-
 drivers/i2c/chips/w83781d.c |    8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c	Fri May 14 16:19:58 2004
+++ b/drivers/i2c/chips/asb100.c	Fri May 14 16:19:58 2004
@@ -855,7 +855,13 @@
 		return err;
 	}
 
-	kfree(i2c_get_clientdata(client));
+	if (i2c_get_clientdata(client)=NULL) {
+		/* subclients */
+		kfree(client);
+	} else {
+		/* main client */
+		kfree(i2c_get_clientdata(client));
+	}
 
 	return 0;
 }
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Fri May 14 16:19:58 2004
+++ b/drivers/i2c/chips/w83781d.c	Fri May 14 16:19:58 2004
@@ -1336,7 +1336,13 @@
 		return err;
 	}
 
-	kfree(i2c_get_clientdata(client));
+	if (i2c_get_clientdata(client)=NULL) {
+		/* subclients */
+		kfree(client);
+	} else {
+		/* main client */
+		kfree(i2c_get_clientdata(client));
+	}
 
 	return 0;
 }

