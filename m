From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 07 Jan 2013 21:53:54 +0000
Subject: Re: [lm-sensors] ASUS M5A99X EVO R2.0
Message-Id: <20130107225354.1b09320c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201301050318.r053Ioa1022953@mx3.lsn.net>
In-Reply-To: <201301050318.r053Ioa1022953@mx3.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 7 Jan 2013 15:42:43 -0600, Leslie Rhorer wrote:
> 	Hmm.  I just put the following into /etc/sensors.conf
> 
> chip "it8721-isa-0290"
> 
>    label fan2 "CPU Fan"
> 
> 	And then ran `sensors -s` followed by `sensors`, but the output from
> `sensors` did not change.  I also tried "*-isa-*.  Is there something else I
> should be doing?

Try /etc/sensors3.conf instead, or even better, create a new file
under /etc/sensors.d for your board.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
