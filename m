From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Fri, 10 Jun 2005 12:54:03 +0000
Subject: [lm-sensors] Re: [1/6] w1: Cleans up usage of
Message-Id: <20050610145322.6f99971f@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050604012146.2a89ec0a@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050604012146.2a89ec0a@zanzibar.2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 9 Jun 2005 22:25:38 -0700
Greg KH <greg@kroah.com> wrote:

> After this series is applied, I get the following compiler warning:
> 
> drivers/w1/w1_family.c: In function `w1_register_family':
> drivers/w1/w1_family.c:65: warning: implicit declaration of function `w1_reconnect_slaves'
> 
> Care to send a follow-on patch to fix this up?

Sure, patch included.
Thank you.

> thanks,
> 
> greg k-h


Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

--- ./drivers/w1.orig/w1_family.c	2005-06-10 15:00:41.000000000 +0400
+++ ./drivers/w1/w1_family.c	2005-06-10 15:01:17.000000000 +0400
@@ -29,8 +29,7 @@
 DEFINE_SPINLOCK(w1_flock);
 static LIST_HEAD(w1_families);
 
-extern struct list_head w1_masters;
-extern spinlock_t w1_mlock;
+extern void w1_reconnect_slaves(struct w1_family *f);
 
 static int w1_check_family(struct w1_family *f)
 {



	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
