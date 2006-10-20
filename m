From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 20 Oct 2006 14:13:33 +0000
Subject: [lm-sensors] Determine where the thermal sensors are?
Message-Id: <20061020161333.6d20bf57.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200610192118.k9JLINDa006525@et-mia-7.site.stayonline.net>
In-Reply-To: <200610192118.k9JLINDa006525@et-mia-7.site.stayonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paul,

On Thu, 19 Oct 2006 17:18:21 -0400, Paul Aviles wrote:
> I have a weird question. The system I use are all the same, and one of them
> is really quiet and the others are somewhat louder in regards to the fans. I
> have all of them in the same rack and with the same hardware (memory, hard
> d, etc) and the same BIOS config, revision and OS level and sensors version.
> Still, only one unit works smoothly and the other are loud. I called the
> manufacturer (Tyan) and they don't know why they will be different or where
> the sensors are located on the motherboard. So, is there a way to find out
> by looking at the chips? My theory is that somehow some of them are getting
> a bit more air flow to certain areas thus making the fans rpm a bit lower.
> The chip is an lm85 or similar/compatible. 

You can usually find the chip itself on the board, but you can't see
the sensors, as they are very small and not really distinguishable. The
only way I know of to physically locate the thermal sensors is to probe
the board with a air dryer while watching the output of "watch -n 1
sensors". Your hardware may or may not like it ;)

If you have sensors working on all systems you should be able to check
whether there are actual differences in the reported temperature and
fan speeds. Care to share the data with us, comparing the silent system
with a loud one?

-- 
Jean Delvare

