From: "Welch, Martyn (GE EntSol,
Date: Tue, 19 Aug 2008 15:46:34 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) Don't spam the kernel log
Message-Id: <1CADFA951940554D86FBD8B24BBFF3A001E370AE@LONMLVEM08.e2k.ad.ge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080819161727.16c58eea@hyperion.delvare>
In-Reply-To: <20080819161727.16c58eea@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Degrade the "Unsupported chip" message from info to debug level.
> There's nothing wrong with this, so no need to bother the user.
> Also make the message slightly more descriptive.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
> Ben, Martyn, could any of you please review, test and ack this patch?
> It applies on top of the 8 other lm90 patches that are queued for
> kernel 2.6.28:
>   http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/
> Thanks.
> 
Hi Jean,

Tested on top of the lm90 patches. I haven't added the adt one, but that
should be a non-issue. The patch looks good, applies, compiles and
functions correctly, feel free to ack me.

Martyn

-- 
Martyn Welch MEng MPhil MIET
Principal Software Engineer

GE Fanuc Intelligent Platforms
Tove Valley Business Park, Towcester,
Northants, NN12 6PF, United Kingdom

Telephone: +44 (0) 1327 359444
Direct Dial: +44 (0) 1327 322748
Fax: +44 (0) 1327 322800
email: martyn.welch@gefanuc.com
web: www.gefanuc.com

GE Fanuc Intelligent Platforms Ltd, registered in England and Wales
(3828642) at 100 Barbirolli Square, Manchester, M2 3AB, VAT GB 729 849
476

GE Fanuc Intelligent Platforms Confidential and Proprietary. If you
have received this message in error please notify us immediately and
permanently remove it from your system and destroy any printed
hardcopies.  

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
