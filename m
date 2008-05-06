From: Romain Dolbeau <romain.dolbeau@caps-entreprise.com>
Date: Tue, 06 May 2008 14:55:05 +0000
Subject: Re: [lm-sensors] sensors.conf for the Supermicro PDSMi+
Message-Id: <48207149.5080001@caps-entreprise.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <482051E8.605@caps-entreprise.com>
In-Reply-To: <482051E8.605@caps-entreprise.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

> * -12V compute formula. Where did you get yours? Mine gives a better
>   value on my system (which doesn't mean it's correct, of course.)

From a snippet of code sent by supermicro support, but it may have been
a generic one or maybe even calid only for the X7DBE.

I haven't tried your version, but mine seems a little low (in absolute
value).

> * +5V and 5VSB compute formula. You cancel the 150 mV offset which the
>   driver is adding on purpose. Why? Both values were OK on my system
>   with the offset.

Mmm, this one is even more mysterious (I did that in last august !),
because I have two PDSMi+ running linux, and those 2 lines are in only
one of the file ... I suspect a PIBKAC on my part, sorry.

> * The connector for the 6th fan. I thought it was fan6 but you seem to
>   believe it's fan7. My system only had 2 fans so I will trust you.

Mine have 3 in a 1U, I suspect this is a leftover from the X7DBE.

I'll check some more on my systems and update in the wiki.

Also, maybe you should add a link to your files / the directory from the
wiki...

-- 
Romain Dolbeau
<romain.dolbeau@caps-entreprise.com>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
