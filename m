From: Wim Van Sebroeck <wim@iguana.be>
Date: Thu, 20 May 2010 07:52:29 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] [RFC] watchdog: f71808e_wdt: new
Message-Id: <20100520075229.GO4008@infomag.iguana.be>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100325125005.6d58cfaf@lxorguk.ukuu.org.uk> <1269523063-30346-1-git-send-email-me@mortis.eu> <1269523063-30346-2-git-send-email-me@mortis.eu> <1269523063-30346-3-git-send-email-me@mortis.eu> <20100330090639.GA8822@salidar.me.mortis.eu>
In-Reply-To: <20100330090639.GA8822@salidar.me.mortis.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Giel van Schijndel <me@mortis.eu>
Cc: Hans de Goede <hdegoede@redhat.com>, Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <jic23@cam.ac.uk>, Wim Van Sebroeck <wim@iguana.be>, Laurens Leemans <laurens@signips.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Giel,

> On Thu, Mar 25, 2010 at 02:17:43PM +0100, Giel van Schijndel wrote:
> > Add a new watchdog driver for the Fintek F71808E Super I/O chip.
> 
> Updated patch:
>  * fixes a bug where detection wouldn't function properly if a
>    non-Fintek device was found (or a wrong Super I/O port chosen).
>  * Add support for the F71882FG
> 
> NOTE: This patch depends on patch [1] (applied in [2]) and patch [3].
> 
> [1] https://patchwork.kernel.org/patch/89023/
> [2] http://git.kernel.org/?p=linux/kernel/git/jbarnes/pci-2.6.git;a=commit;h16607809324cc796c0809630b6ae8a768404296
> [3] https://patchwork.kernel.org/patch/88235/

Driver looks OK to me. Can't apply it before the I/O resource sharing is in place.
How do you want to proceed?

Kind regards,
Wim.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
