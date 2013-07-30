From: Jaromir Capik <jcapik@redhat.com>
Date: Tue, 30 Jul 2013 17:50:28 +0000
Subject: Re: [lm-sensors] [PATCH] Avoiding warnings when piping to sensors-detect
Message-Id: <1109609098.9063710.1375206628243.JavaMail.root@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <699701256.6909990.1374770991358.JavaMail.root@redhat.com>
In-Reply-To: <699701256.6909990.1374770991358.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> 
> Hi Jaromir,

Hi Jean.

> Fair enough. eof() did not work (it blocked when STDIN was not
> redirected) but I found another way to implement your proposal in the
> Perl Cookbook. What do you think? If you can find a better wording,
> please let me know.

I believe the warning is explanatory enough.
If it works correctly, then go on and push the patch.

Regards,
Jaromir.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
