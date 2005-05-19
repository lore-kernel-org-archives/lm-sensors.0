From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: beeping issues
Message-Id: <20030722095236.320cda25.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030721094037.55d98610.khali@linux-fr.org>
In-Reply-To: <20030721094037.55d98610.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Steps 3, 4, and 5 result in turning my computer off. I didn't attempt
> any other steps.

Whaou. Strange and dangerous. Damn this undocumented chip :(

> I have devised a workaround to the problem which works in my case:
> 
> For my respective chip (chip "as99127f-*") I located in sensors.conf
> the line
> set in0_max vid*1.05
> and changed it to:
> set in0_max vid*1.16
> 
> Afterwards I ran the command "sensors -s" as root and the beeping
> stopped.

That's really interesting, I will tell the other persons about this. I
think there's a cleaner fix however.

> I think the values you have for the motherboards "VCore 1"
> maximum is incorrect which gave me an "ALARM".

The value for vcore 1 max and min are computed from the value of vid,
which is given to us by your motherboard itself. I, your case, it seems
that vid should be 1.55V while it is 1.35V, thus the problem. The first
thing you should try is to change the vrm setting in your
/etc/sensors.conf file (as99127f section). The VRM defines how the vid
data is interpreted. If you can't get vid to 1.55, then change the
in0_min and in0_max lines to these ones:

set in0_min 1.55 * 0.95
set in0_max 1.55 * 1.05

And it should be OK. That's IMHO nicer than what you did (but I'm glad
you figured out how to make the beeps stop in the first place).

> The only trouble is everytime my comp is turned on, I must type
> "sensors -s" to stop beeping.

You should have it called for you from your init scripts right after the
w83781d module is loaded. That's what the init script we generate does.

Thanks a lot for your help.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
