From: gcoady.lk@gmail.com (Grant Coady)
Date: Mon, 21 Aug 2006 16:46:27 +0000
Subject: [lm-sensors] [RFC][PATCH] hwmon:fix sparse warnings + error
Message-Id: <tkoje25hlbjo1ui9i9v86fpdl6h4sfjnpq@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44E8C9AE.3060307@gmail.com> <20060821023017.GA30017@jupiter.solarsys.private> <20060821111127.fe93bc0a.khali@linux-fr.org>
In-Reply-To: <20060821111127.fe93bc0a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On Mon, 21 Aug 2006 11:11:27 +0200, Jean Delvare <khali at linux-fr.org> wrote:

>Mark, Michal,
>
>> Thanks for doing this... but Andrew please don't apply it.  The sensors project
>> people are working on these even now, and we already have a patch for the
>> w83627hf driver...
>> 
>> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-August/017204.html
>> 
>> Jean Delvare (hwmon maintainer) should be sending these up the chain soon.
>> 
>> Michal: if you're interested in fixing any of the rest of them, please take
>> a look at the patch above to see the mechanism we intend to use.  It actually
>> makes the drivers *smaller* than they were.
>
>The size change really depends on the driver. For older drivers with
>individual file registration (sometimes hidden behind macros) the
>driver size will indeed shrink, but for newer drivers with loop-based
>file registration, this would be a slight increase in size. Not that it
>really matters anyway, what matters is that we handle errors and file
>deletion properly from now on.
>
>Michal, if you go on working on this (and this is welcome), please
>follow what Mark did, as this is what we agreed was the best approach.
>Here is a quick status summary for drivers/hwmon:
>
...
> o adm9240

Somebody else is welcome to do this one, my last patch was dropped.

Grant.

