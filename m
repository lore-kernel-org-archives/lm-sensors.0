From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 16 Dec 2008 14:57:32 +0000
Subject: Re: [lm-sensors] Problem with:
Message-Id: <20081216155732.0911d835@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <494652C1.8060506@redhat.com>
In-Reply-To: <494652C1.8060506@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 16 Dec 2008 14:40:07 +0100, Hans de Goede wrote:
> Jean Delvare wrote:
> > Do you have an update for this patch, please? I'd like to get all
> > f71882fg/f8000 patches sorted out today.
> 
> Yes I have (for more then a day) I guess I somehow forgot to send it.
> 
> Its attached now.

Applied, thanks.

Note that I added a compatibility quirk to lm-sensors 2.10.8 so that it
looks for temp#_max_alarm files if they exist. So maybe we can clean up
the f71882fg driver in 1 year or so.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
