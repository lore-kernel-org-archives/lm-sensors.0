From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: request for drivers
Message-Id: <20040320121210.5474bcf7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1079336501.25709.182679907@webmail.messagingengine.com>
In-Reply-To: <1079336501.25709.182679907@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > From what I remember of my datasheets reading, the 47B27x should be
> > fully compatible with the 47M10x chips, so the smsc47m1 driver
> > should work. Please find attached a patch which adds the 47B27x
> > device ID to the smsc47m1 driver. After applying it, you should be
> > able to load the driver, and hopefully it will work out-of-the-box.
> > 
> > Please provide feedback so that I know if I should apply this patch
> > to our CVS repository.
>
> Yep, works just fine.  Thanks!

Great :) I've applied my patch to the CVS repository, and updated our
docs accordingly.

Thanks for testing. BTW, the driver is still marked "beta" in our docs.
If you test if completely and everything seems to work OK, we may
consider marking it "tested" instead. Let us know :)

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
