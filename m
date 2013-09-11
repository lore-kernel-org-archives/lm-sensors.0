From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Sep 2013 11:47:16 +0000
Subject: Re: [lm-sensors] [PATCH] Avoiding warnings when piping to sensors-detect
Message-Id: <20130911134716.78a570a3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <699701256.6909990.1374770991358.JavaMail.root@redhat.com>
In-Reply-To: <699701256.6909990.1374770991358.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 30 Jul 2013 13:50:28 -0400 (EDT), Jaromir Capik wrote:
> > Fair enough. eof() did not work (it blocked when STDIN was not
> > redirected) but I found another way to implement your proposal in the
> > Perl Cookbook. What do you think? If you can find a better wording,
> > please let me know.
> 
> I believe the warning is explanatory enough.
> If it works correctly, then go on and push the patch.

Sorry for the delay, I just committed the patch.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
