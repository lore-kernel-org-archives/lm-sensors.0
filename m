From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 04 Nov 2006 12:47:07 +0000
Subject: [lm-sensors] ASUS P5B DELUXE WiFi with Winbond W83627DHG - here
Message-Id: <20061104134707.fdf34927.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4536788E.8010504@fibertel.com.ar>
In-Reply-To: <4536788E.8010504@fibertel.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 3 Nov 2006 22:39:55 +0100, Christian Mahr wrote:
> Some more technical explanation I found here:
> 
> http://www.analog.com/library/analogDialogue/archives/38-02/fan_speed.html

Nice article, I've added a link to it to our "userful addresses" page.

> So this type of pwm control is completely useless for a 3 pin fan
> which expects modulated 12-V-power, unless....
>  
> What might be possible is to use some external circuitry to
> translate the 0..5V logic signal into a pwm-modulation of the
> +12V supply, i.e. a power switch.
> 
> 
> Before I start experimenting in hardware, just my question: 
>  - did anybody find already a ready-made-solution for this
>    kind of adapation circuitry?
>  - if not: Is there any suitable IC known which does all in one
>    (otherwise I might need at least 4 resistors and 2 transistors...)

Why don't you simply use 4-wire fans if that's what the board was
designed for?

-- 
Jean Delvare

