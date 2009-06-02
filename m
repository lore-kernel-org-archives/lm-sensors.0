From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 02 Jun 2009 09:55:56 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (tmp401) Fix off-by-one error in
Message-Id: <20090602115556.3632e17d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090602081821.GA4546@ubuntu>
In-Reply-To: <20090602081821.GA4546@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2 Jun 2009 11:14:15 +0200, Andre Prendel wrote:
> On Tue, Jun 02, 2009 at 10:26:28AM +0200, Hans de Goede wrote:
> > Good catch!
> 
> Unfortunately this bug was introduced by myself :(
> I didn't read your code from fschmd carefully enough.

The patch which introduces the bug isn't merged yet, so I will simply
fold the fix into that patch. Thanks!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
