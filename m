From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 25 Jul 2013 18:45:59 +0000
Subject: Re: [lm-sensors] [PATCH] Avoiding warnings when piping to sensors-detect
Message-Id: <20130725204559.353c9ec7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <699701256.6909990.1374770991358.JavaMail.root@redhat.com>
In-Reply-To: <699701256.6909990.1374770991358.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jaromir,

On Thu, 25 Jul 2013 12:49:51 -0400 (EDT), Jaromir Capik wrote:
> The attached patch fixes <STDIN> handling when the user
> input is taken from /dev/null.
> I know this way of generating the config is undocumented
> and therefore unsupported, but it seems people use it
> that way as the script doesn't support running in 
> batch mode.
> 
> The patch was created for 3.3.4, but can be directly
> applied on the latest sources too.
> 
> Please, merge the fix.

Hmm, as far as I can see this solves the same problem as this patch of
mine I posted some months ago:
http://marc.info/?l=lm-sensors&m5091022118747&w=2

The only reason why I did not commit it yet is that I was waiting for
feedback, but the original requester never provided it :(

If my patch works for you and your users then I'll just apply it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
