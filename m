From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 Jun 2007 10:11:11 +0000
Subject: Re: [lm-sensors] [PATCH for review] Add temperature-tracking mode
Message-Id: <20070619121111.5dcd55e7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1182008300609@dmwebmail.belize.chezphil.org>
In-Reply-To: <1182008300609@dmwebmail.belize.chezphil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Phil,

On Sat, 16 Jun 2007 22:39:08 +0100, Phil Endecott wrote:
> A couple of things I should have said:
> 
> - Ooops, I did the diff from the hwmon directory.  I'll try to get that 
> right next time.

Yes please :)

> - Could someone please look at how this interacts with the F71872F/FG ?

I can't test, but according to the datasheet, these registers are
exactly the same between the F71805F/FG and F71872F/FG, so there
probably isn't anything to care about.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
