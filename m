From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 14 Jan 2009 20:03:33 +0000
Subject: Re: [lm-sensors] sensord with rrd
Message-Id: <20090114210333.6d8d90ce@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <gkimcg$46k$1@ger.gmane.org>
In-Reply-To: <gkimcg$46k$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 14 Jan 2009 11:01:22 -0800, Mark Nienberg wrote:
> Jean Delvare wrote:
> >> [root@gecko ~]# rpm -q lm_sensors sensord
> >> lm_sensors-2.10.6-55.el5
> >> sensord-2.10.6-55.el5
> > 
> > This is somewhat old...
> 
> Agreed, but it is the latest rpm I could find already built for centOS 5.2.
> 
> > What hardware monitoring chip do you have? sensord in lm-sensors 2.10.x
> > lacks support for many recent chips. Could be that logging works
> > somewhat in generic mode but rrd supports need chip-specific support.
> 
> See my post from Jan 5 with subject "Asus KFN4-DRE board".
> 
> http://article.gmane.org/gmane.linux.drivers.sensors/18601
> 
> You can see that I have tried specifically setting the chip in the sensord init file, 
> but it didn't help.

I confirm that sensord in lm-sensors 2.10 has no support for the
w83792d. You need lm-sensors 3.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
