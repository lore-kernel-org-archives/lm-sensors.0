From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 Jun 2007 11:15:32 +0000
Subject: Re: [lm-sensors] Fintek F71805F on Jetway J7F4K1G5D - fancontrol?
Message-Id: <20070613131532.2ae12090@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070609191229.GB16891@warped.org>
In-Reply-To: <20070609191229.GB16891@warped.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Phil,

On Mon, 11 Jun 2007 12:55:06 +0100, Phil Endecott wrote:
> I've put a couple of photos of my J7F2 board here:
> http://chezphil.org/tmp/j7f2_cpufan_top.jpeg
> http://chezphil.org/tmp/j7f2_cpufan_bottom.jpeg
> 
> In the top photo, you can see an unpopulated position for a transistor 
> ("Q1") next to the CPU fan connector.  In the bottom photo, you can see 
> a "zero-ohm resistor" and some more unpopulated positions (the three 
> pins on the left of this picture are the bottom of the fan connector).
> 
> If your board looks similar, you're right that you can't control the 
> fan speed.  If you have a transistor and other components near the fan 
> connector, then keep trying!

Very interesting. This trick seems to work for other motherboard brands
too. I have an Asus board here where I can't control the CPU fan and
bingo! there's unpopulated room for a 3-leg component labelled Q12 next
to the CPU fan header. So it seems that they designed the board with fan
control in mind, and finally didn't solder the required components.
Maybe because they share the same design between different models.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
