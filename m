From: pakar@imperialnet.org (Patric)
Date: Mon, 23 Jan 2006 23:17:13 +0000
Subject: [lm-sensors] Asus a8v problems.
Message-Id: <43D563F9.6020901@imperialnet.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43CE945F.8020105@imperialnet.org>
In-Reply-To: <43CE945F.8020105@imperialnet.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:

> 
> Some boards have fan headers that are wired to +12V instead of using
> the hwmon chip PWM output, even though the speed detection signal is
> there.  One of my boards is like that (Asus P4C800E-Deluxe); probably
> yours is too.  Sorry.
> 

That's just to bad... Could not find any information about my a8v, but i 
think it's quite evil of them to call the board fully "cool'n'quiet" 
compatible as they say. In my eyes that would mean to be able to control 
all fans connected to the mainboard. :(

If i ever do an win-install of this system i will do a test just to 
verify that it's not controllable. But it's probably gonna take 10-20 
years for me to loose my mind and install windows on this system :)
(pwm3 is the connector that's between the cpu-socket and the rear-io 
connector if you don't want to wait for me and want to try it yourself. =)


Well well, got myself a manual controller and put it on the least useful 
fan. And never again Asus without checking stuff like this before.

Thanks for the assistance, even if i had to get angry because of Asus :)


/Patric




