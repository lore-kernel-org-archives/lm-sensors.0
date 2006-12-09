From: christian.mahr.ulm@arcor.de (Christian Mahr)
Date: Sat, 09 Dec 2006 12:17:52 +0000
Subject: [lm-sensors] [PATCH 6/8] w83627ehf: Fix the detection of fan5
Message-Id: <200612091317.52595.christian.mahr.ulm@arcor.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <11612021961186-git-send-email-greg@kroah.com>
In-Reply-To: <11612021961186-git-send-email-greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

I always could read fans5 on my P5B wifi deluxe board.

I am still on 2.6.18.2 kernel with your version of w83627ehf driver (and 
Rudolfs coretemp patch). 
anything you want me to try out? 

Christian

Am Donnerstag, 7. Dezember 2006 22:01 schrieb David Hubbard:
> Hi Jean, Rudolf,
>
> I'm doing bits and pieces of the w83627dhg driver, and I want to make
> sure I test it on the latest patched w83627ehf driver. I believe this
> is Rudolf's last patch, the last update to the driver. However, the
> machine I develop on at home has a very slow internet connection, so I
> have tried linux-2.6.18-mm2 and linux-2.6.19-rc3. Neither seems to
> have that patch.
>
> Has Rudolf's patch been pushed upstream? I'm replying on the thread
> where Greg K received the patch. Sorry, this should be an easy one,
> but I'm stuck.
>
> Thanks,
> David
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors



	
		
___________________________________________________________ 
Der fr?he Vogel f?ngt den Wurm. Hier gelangen Sie zum neuen Yahoo! Mail: http://mail.yahoo.de


