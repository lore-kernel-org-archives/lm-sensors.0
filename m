From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 30 Sep 2008 13:48:34 +0000
Subject: Re: [lm-sensors] [PATCH 0/4] hwmon: (w83791d) refresh fandiv patch
Message-Id: <20080930154834.3b960c38@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200808060029.22653.m.hulsman@tudelft.nl>
In-Reply-To: <200808060029.22653.m.hulsman@tudelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans, Marc,

On Wed, 06 Aug 2008 08:51:06 +0200, Hans de Goede wrote:
> Marc Hulsman wrote:
> > The following series of patches apply to the new-style version of the w83791d 
> > driver, with the earlier submitted fandiv patch applied. Hereby for 
> > convenience a refreshed version of that patch which applies cleanly to the 
> > current driver. 
> 
> Unfortunately Mark Hofmann has stepped down as hwmon maintainer due to lack of 
> time, I see that these patches have been Acked-by Jean. Can you please send 
> them directly to Andrew Morton (with a CC to the lm-sensors list) for 2.6.27 
> inclusion? Sending patches to Andrew now is the path for hwmon-patches to get 
> them included in Linus tree.

I'm looking at these patches now, and will add them to my hwmon tree if
I see no problem with them. This will then go in kernel 2.6.28 - it's
too late for 2.6.27, sorry.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
