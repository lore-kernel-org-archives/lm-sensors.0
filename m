From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Jan 2010 18:05:20 +0000
Subject: Re: [lm-sensors] Found unknown SMBus adapter 10de:0aa2 at
Message-Id: <20100114190520.7cdc825f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100113153747.1dab14c5@hyperion.delvare>
In-Reply-To: <20100113153747.1dab14c5@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Manuel,

On Thu, 14 Jan 2010 18:49:27 +0100, Manuel Lamotte-Schubert wrote:
> I've downloaded the 2.6.33-rc4 kernel and integrated your patch.
> Please note, that I could not apply the patch automatically.
> I had to apply it by hand because the line numbers from the patch file
> didn't match the numbers in the target files.

I'm surprised. For one thing, "patch" is smart and can apply patches
even when line numbers don't match. For another, my patch was generated
exactly on top of 2.6.33-rc4, so it should have applied perfectly.

> Which tests shall I run now?

Just load the lm90 driver then run "sensors", you should see an entry
for the W83L771 with two temperature. temp1 would be the board
temperature and temp2 the CPU temperature.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
