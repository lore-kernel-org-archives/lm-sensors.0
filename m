From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 02 Nov 2007 10:17:58 +0000
Subject: Re: [lm-sensors] lm_sensors on ASUS M2NPV-VM motherboard using
Message-Id: <20071102111758.25abeab3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46ED7EFC.4030609@Winfirst.Com>
In-Reply-To: <46ED7EFC.4030609@Winfirst.Com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 31 Oct 2007 12:20:24 -0700, Mark E. Hansen wrote:
> On 10/31/07 11:47, Jean Delvare wrote:
> > Depends on what kernel version you're using. I added support for the
> > IT8716F in 2.6.19. For 2.6.17 and 2.6.18, there are kernel patches.
> 
> Oh, this may be a problem. I'm running CentOS 4.5, which uses kernel 2.6.9.
> I would imagine that it would take more than just building a new kernel to
> get my machine up to that level (I'm assuming there would be a lot of
> dependent packages that would need to be upgraded first, etc.).

Indeed, upgrading the kernel only, without touching the supporting
user-space packages, would certainly fail.

> Is there any way to apply this patch to a 2.6.9 kernel? (probably not...)

This would require a complete, expensive backport.

> I guess I'll start looking into upgrading my machine to CentOS 5.0 (which
> uses kernel 2.6.18, if I understand the site correctly).

If you care about hardware monitoring, that's definitely the most
reasonable solution, yes.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
