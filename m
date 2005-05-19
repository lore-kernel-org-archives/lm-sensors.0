From: ender@debian.org (David =?iso-8859-1?q?Mart=EDnez=20Moreno?=)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Typo (Re: [PATCH] i2c driver fixes for 2.6.2-rc2)
Message-Id: <200401301058.29324.ender@debian.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <10752464532256@kroah.com> <200401291227.15413.ender@debian.org> <20040129194705.GD5681@kroah.com>
In-Reply-To: <20040129194705.GD5681@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

El Jueves, 29 de Enero de 2004 20:47, Greg KH escribi?:
> On Thu, Jan 29, 2004 at 12:27:15PM +0100, David Mart?nez Moreno wrote:
> > 	Sure, it's only a small thing in return for all that Linux has given to
> > me.
> >
> > 	Following patch fixes two typos and a missing full stop. Applies cleanly
> > against 2.6.2-rc2 + i2c patches you just submitted.
>
> Hm, your mailer munged the patch (due to the PGP signature), care to
> redo it so that it can be applied?

	I agree. :-)

	There goes again, without GPG sig.

	Following patch fixes two typos and a missing full stop. Applies cleanly
against 2.6.2-rc2 + i2c patches you just submitted.

--- kernel-2.6.x/drivers/i2c/chips/lm85.c.orig	2004-01-29 12:18:49.000000000 +0100
+++ kernel-2.6.x/drivers/i2c/chips/lm85.c	2004-01-29 12:21:01.000000000 +0100
@@ -816,7 +816,7 @@
 			kind = lm85b ;
 		} else if( company = LM85_COMPANY_NATIONAL
 		    && (verstep & 0xf0) = LM85_VERSTEP_GENERIC ) {
-			dev_err(&adapter->dev, "Unrecgonized version/stepping 0x%02x"
+			dev_err(&adapter->dev, "Unrecognized version/stepping 0x%02x"
 				" Defaulting to LM85.\n", verstep);
 			kind = any_chip ;
 		} else if( company = LM85_COMPANY_ANALOG_DEV
@@ -827,7 +827,7 @@
 			kind = adt7463 ;
 		} else if( company = LM85_COMPANY_ANALOG_DEV
 		    && (verstep & 0xf0) = LM85_VERSTEP_GENERIC ) {
-			dev_err(&adapter->dev, "Unrecgonized version/stepping 0x%02x"
+			dev_err(&adapter->dev, "Unrecognized version/stepping 0x%02x"
 				" Defaulting to ADM1027.\n", verstep);
 			kind = adm1027 ;
 		} else if( kind = 0 && (verstep & 0xf0) = 0x60) {
@@ -1204,7 +1204,7 @@
 
 /* Thanks to Richard Barrington for adding the LM85 to sensors-detect.
  * Thanks to Margit Schubert-While <margitsw@t-online.de> for help with
- *     post 2.7.0 CVS changes
+ *     post 2.7.0 CVS changes.
  */
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Philip Pokorny <ppokorny@penguincomputing.com>, Margit Schubert-While <margitsw@t-online.de>");


	Regards,


		Ender.
-- 
Oh, I saw...Very American. Fire enough bullets and hope
 they hit the target!
		-- Allan Quatermain (The League of Extraordinary Gentlemen)
--
Servicios de red - Network services
RedIRIS - Spanish Academic Network for Research and Development
Madrid (Spain)
Tlf (+34) 91.585.51.50

